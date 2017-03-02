//
//  LockView.m
//  MYPGestureUnlock
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 MengYP. All rights reserved.
//

#import "LockView.h"
#import "CircleView.h"

@interface LockView()
@property (nonatomic,strong) NSMutableArray *selectedButtons;
@property (nonatomic,assign) CGPoint currentMovePoint;

@end
@implementation LockView

#pragma mark - 初始化
- (NSMutableArray *)selectedButtons
{
    if (_selectedButtons == nil) {
        _selectedButtons = [NSMutableArray array];
    }
    return _selectedButtons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

//创建可点击的Button
- (void)setup
{
    for (int index = 0; index < 9; index++) {
        //创建按钮
        CircleView *btn = [CircleView buttonWithType:UIButtonTypeCustom];
        
        //给 button绑定tag
        btn.tag = index;
        
        //添加按钮
        [self addSubview:btn];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (int index = 0; index < self.subviews.count; index++) {
        CircleView *btn = self.subviews[index];
        
        CGFloat btnW = 74;
        CGFloat btnH = 74;
        
        int totalCol = 3;//总列数
        int col = index % totalCol;//列号
        int row = index / totalCol;//行号
        
        CGFloat marginX = (self.bounds.size.width - btnW * totalCol) / (totalCol + 1);//x间隙
        CGFloat marginY = marginX;
        
        CGFloat btnX = marginX + (marginX + btnW) * col;
        CGFloat btnY = marginY + (marginY + btnH) * row;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        //设置 LockView 的Height
        CGRect frame = self.frame;
        frame.size.height = (marginY + btnH) * (self.subviews.count / totalCol + 1);
        self.frame = frame;
    }
}

#pragma mark - 私有方法
/**
 *  根据 touches 集合,获得对应的触摸点位置
 */
- (CGPoint)pointWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:touch.view];
}
/**
 *  根据触摸点位置获得对应的按钮
 */
- (CircleView *)buttonWithPoint:(CGPoint)point
{
    for (CircleView *btn in self.subviews) {
        CGFloat wh = 25;
        CGFloat frameX = btn.center.x - wh * 0.5;
        CGFloat frameY = btn.center.y - wh * 0.5;
        CGRect frame = CGRectMake(frameX, frameY, wh, wh);
        
        //调节frame的大小,即可调节触摸圆时连接的位置
        //判断btn的frame范围内是否包含当前触摸点
        if (CGRectContainsPoint(frame, point)) {
            return btn;
        }
    }
    //如果触摸点,没有在选中范围(按钮范围),就返回空
    return nil;
}

#pragma mark - 触摸方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //清空当前移动点
    self.currentMovePoint = CGPointZero;
    
    //1.获得触摸点位置
    CGPoint pos = [self pointWithTouches:touches];;
    
    //2.获得触摸的按钮
    CircleView *btn = [self buttonWithPoint:pos];
    
    //3.设置按钮的状态
    if (btn && (btn.selected == NO)) {//1.触摸到按钮 2.不能重复触摸
        //设置被选中的按钮状态为:选中状态
        btn.selected = YES;
        //把被选中的button放进数组中
        [self.selectedButtons addObject:btn];
    }
    
    //4.刷帧
    [self setNeedsDisplay];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //1.获得触摸点位置
    CGPoint pos = [self pointWithTouches:touches];
    
    //2.获得触摸的按钮
    CircleView *btn = [self buttonWithPoint:pos];
    
    //3.设置按钮的状态
    //(btn.selected == NO) 相当于 [self.selectedButtons containsObject:btn] == NO
    if (btn && (btn.selected == NO)) {//1.触摸到按钮 2.不能重复触摸
        btn.selected = YES;
        
        //把被选中的button放进数组中
        [self.selectedButtons addObject:btn];
        
    }else {//没有摸到按钮
        
        self.currentMovePoint = pos;//当前触摸点,全局化(属性)
        
    }
    
    //4.刷帧
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(lockView:didFinshPath:)]) {
        //1.拼接路径tag,保存用户轨迹
        NSMutableString *str = [NSMutableString string];
        for (CircleView *btn in self.selectedButtons) {
            [str appendFormat:@"%ld",(long)btn.tag];//拼接数字,为字符串
        }
        NSLog(@"%@",str);
        
        //2.通知代理执行代理方法
        [self.delegate lockView:self didFinshPath:str];
    }
    
    //1.清除选中按钮状态,选中按钮为不选中状态
#if 0 //第一种方法
    for (CircleView *btn in self.selectedButtons) {
        btn.selected = NO;//相当于 [btn setSelected:NO]; //set方法
    }
#else //第二种方法

//    [self.selectedButtons makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];//把 NO 是0 ,包装成对象: @(NO)
    
    [self.selectedButtons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CircleView *btn = obj;
        btn.selected = NO;
    }];
#endif
    
    //2.清除路径(当解锁结束,取消路径)
    [self.selectedButtons removeAllObjects];
    
    
    //3.刷帧
    [self setNeedsDisplay];
    
}

#pragma mark - 绘图
- (void)drawRect:(CGRect)rect
{
    //刚载入时(第一次载入时) 判断是否选中button
    if (self.selectedButtons.count == 0) return;
    
    //贝塞尔曲线路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //找到起始点,连接其他选中的button
    for (int index = 0; index < self.selectedButtons.count; index++) {
        CircleView *btn = self.selectedButtons[index];
        
        if (index == 0) {
            [path moveToPoint:btn.center];//找到起始按钮
        }else{
            [path addLineToPoint:btn.center];//连接其他选中的按钮
        }
    }
    
    //    [path addLineToPoint:self.currentMovePoint];
    
    //连线
    if (CGPointEqualToPoint(self.currentMovePoint, CGPointZero) == NO) {
        [path addLineToPoint:self.currentMovePoint];
    }
    
    //线的样式
    [[UIColor colorWithRed:32/250.0 green:210/250.0 blue:254/250.0 alpha:0.5] set];
    //    [[UIColor greenColor] set];//颜色
    path.lineWidth = 8;
    path.lineJoinStyle = kCGLineJoinBevel;//连接处斜向剪切,变为扁平的
    path.lineCapStyle = kCGLineCapRound;//线的起始和末尾圆滑设置
    
    //渲染
    [path stroke];
}


@end
