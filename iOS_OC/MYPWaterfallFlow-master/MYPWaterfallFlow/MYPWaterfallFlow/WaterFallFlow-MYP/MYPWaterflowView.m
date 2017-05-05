//
//  MYPWaterflowView.m
//  MYPWaterfallFlow
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 MengYP. All rights reserved.
//  使用瀑布流形式展示内容的控件

/**
 瀑布流特点：
 1.每一个cell的宽度是相同的
 2.每一个cell的高度是不一定相同的
 3.下一个cell的摆放规则：按照所有列中，每一列最后一个cell 的 最大Y值，比较，最小的那列则是下一个cell的摆放列
 */


#import "MYPWaterflowView.h"
#import "MYPWaterflowViewCell.h"

#define kWaterflowViewCellDefaultCellH 70          //默认cell的高度
#define kWaterflowViewCellDefaultMargin 8          //默认间隙
#define kWaterflowViewCellDefaultNumberOfColumns 3 //默认列数

@interface MYPWaterflowView()
/** 所有cell的frame数据，存入数组 */
@property (nonatomic,strong) NSMutableArray *cellFrames;
/** 正在展示的cell */
@property (nonatomic,strong) NSMutableDictionary *displayingCells;
/** 缓存池（用Set，存放离开屏幕的cell） */
@property (nonatomic,strong) NSMutableSet *reusableCells;
@end
@implementation MYPWaterflowView

#pragma mark - 公共接口
- (CGFloat)cellWidth
{
    //总列数
    NSUInteger numberOfColumns = [self numberOfColumns]; //列数
    CGFloat leftM = [self marginForType:MYPWaterflowViewCellMarginTypeLeft]; //左间隙
    CGFloat rightM = [self marginForType:MYPWaterflowViewCellMarginTypeRight]; //右边间隙
    CGFloat columnM = [self marginForType:MYPWaterflowViewCellMarginTypeColumn]; //列间隙
    
    return (self.bounds.size.width - leftM - rightM - (numberOfColumns - 1) * columnM) / numberOfColumns;
}


- (void)reloadData
{
    //清空之前的所有数据
    //移除正在显示的cell
    [self.displayingCells.allValues makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.displayingCells removeAllObjects];
    [self.cellFrames removeAllObjects];
    [self.reusableCells removeAllObjects];
    
    //cell的总数
    NSUInteger numberOfCells = [self.dataSource numberOfCellsInWaterflowView:self];
    
    //总列数
    NSUInteger numberOfColumns = [self numberOfColumns];
    
    //各个间隙
    CGFloat topM = [self marginForType:MYPWaterflowViewCellMarginTypeTop];
    CGFloat bottomM = [self marginForType:MYPWaterflowViewCellMarginTypeBottom];
    CGFloat leftM = [self marginForType:MYPWaterflowViewCellMarginTypeLeft];
    CGFloat rowM = [self marginForType:MYPWaterflowViewCellMarginTypeRow];
    CGFloat columnM = [self marginForType:MYPWaterflowViewCellMarginTypeColumn];
    
    //cell的宽度（每一个cell的宽度是相同的）
    CGFloat cellW = [self cellWidth];
    
    //使用一个C语言数组存放所有列的最大Y值
    CGFloat maxYOfColumns[numberOfColumns];
    for (int i=0; i<numberOfColumns; i++) { //数组元素初始化为0.0
        maxYOfColumns[i] = 0.0;
    }
    
    //计算所有cell的frame
    for (int i=0; i<numberOfCells; i++) {
        //cell处在第几列（最短的一列）
        NSUInteger cellColumn = 0;
        //cell所处那列的最大Y值（最短那一列的最大Y值）
        CGFloat maxYOfCellColumn = maxYOfColumns[cellColumn];
        
        //求出最短的一列
        for (int j=1; j<numberOfColumns; j++) {
            if (maxYOfColumns[j] < maxYOfCellColumn) {
                cellColumn = j;
                maxYOfCellColumn = maxYOfColumns[j];
            }
        }
        
        //询问代理i位置的高度
        CGFloat cellH = [self heightAtIndex:i];
        
        //cell的位置
        CGFloat cellX = leftM + cellColumn * (cellW + columnM);
        CGFloat cellY = 0;
        if (maxYOfCellColumn == 0.0) { //首行
            cellY = topM;
        }else{
            cellY = maxYOfCellColumn + rowM;
        }
        
        //添加frame到数组中
        CGRect cellFrame = CGRectMake(cellX, cellY, cellW, cellH);
        [self.cellFrames addObject:[NSValue valueWithCGRect:cellFrame]];
        
        //更新最短那一列的最大Y值
        maxYOfColumns[cellColumn] = CGRectGetMaxY(cellFrame);
    }
    
    //设置contentSize
    CGFloat contentH = maxYOfColumns[0];
    for (int j=1; j<numberOfColumns; j++) {
        if (maxYOfColumns[j] > contentH) {
            contentH = maxYOfColumns[j];
        }
    }
    contentH += bottomM;
    self.contentSize = CGSizeMake(0, contentH);
}


- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    __block MYPWaterflowViewCell *reusableCell = nil;
    
    [self.reusableCells enumerateObjectsUsingBlock:^(MYPWaterflowViewCell *cell, BOOL *stop) {
        if ([cell.identifier isEqualToString:identifier]) {
            reusableCell = cell;
            *stop = YES;
        }
    }];
    
    if (reusableCell) { //从缓存池中移除
        [self.reusableCells removeObject:reusableCell];
    }
    return reusableCell;
}

#pragma mark - 私有方法
/**
 *  总列数
 */
- (NSUInteger)numberOfColumns
{
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsInWaterflowView:)]) {
        return [self.dataSource numberOfColumnsInWaterflowView:self];
    }else{
        return kWaterflowViewCellDefaultNumberOfColumns;
    }
}
/**
 *  index位置对应的高度
 */
- (CGFloat)heightAtIndex:(NSUInteger)index
{
    if ([self.delegate respondsToSelector:@selector(waterflowView:heightAtIndex:)]) {
        return [self.delegate waterflowView:self heightAtIndex:index];
    }else{
        return kWaterflowViewCellDefaultCellH;
    }
}
/**
 *  间距（根据type不同，计算不同的间隙 上、下、左、右、行、列）
 */
- (CGFloat)marginForType:(MYPWaterflowViewMarginType)type
{
    if ([self.delegate respondsToSelector:@selector(waterflowView:marginForType:)]) {
        return [self.delegate waterflowView:self marginForType:type];
    }else{
        return kWaterflowViewCellDefaultMargin;
    }
}
/**
 *  判断一个frame有无显示在屏幕上
 */
- (BOOL)isInScreen:(CGRect)frame
{
    return (CGRectGetMaxY(frame) > self.contentOffset.y) && (CGRectGetMinY(frame) < self.contentOffset.y + self.bounds.size.height);
}

#pragma mark - 系统方法
/**
 *  即将移动到某个父控件上时调用
 */
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self reloadData];
}

/**
 *  当UIScrollView滚动的时候也会调用这个方法
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //向数据源所要对应位置的cell
    NSUInteger numberOfCells = self.cellFrames.count;
    for (int i=0; i<numberOfCells; i++) {
        //取出i位置的frame
        CGRect cellFrame = [self.cellFrames[i] CGRectValue];
        
        //优先从字典中取出i位置的cell
        MYPWaterflowViewCell *cell = self.displayingCells[@(i)];
        
        //判断i位置对应的frame不在屏幕上（能否看见）
        if ([self isInScreen:cellFrame]) { //在屏幕上
            if (cell == nil) {
                cell = [self.dataSource waterflowView:self cellAtIndex:i];
                cell.frame = cellFrame;
                [self addSubview:cell];
                
                //存放到字典中
                self.displayingCells[@(i)] = cell;
            }
        }else{                             //不在屏幕上
            if (cell) {
                //从scrollView和字典中移除
                [cell removeFromSuperview];
                [self.displayingCells removeObjectForKey:@(i)];
                
                //存放进缓存池
                [self.reusableCells addObject:cell];
            }
            
        }
    }
}

#pragma mark 事件处理
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![self.delegate respondsToSelector:@selector(waterflowView:didSelectAtIndex:)]) {
        return;
        
        //获得触摸点
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        
        __block NSNumber *selectIndex = nil;
        [self.displayingCells enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, MYPWaterflowViewCell  *cell, BOOL * _Nonnull stop) {
            if (CGRectContainsPoint(cell.frame, point)) {
                selectIndex = key;
                *stop = YES;
            }
        }];
        
        if (selectIndex) {
            [self.delegate waterflowView:self didSelectAtIndex:selectIndex.unsignedIntegerValue];
        }
    }
}


#pragma mark - 懒加载
- (NSMutableArray *)cellFrames
{
    if (!_cellFrames) {
        _cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}
- (NSMutableDictionary *)displayingCells
{
    if (!_displayingCells) {
        _displayingCells = [NSMutableDictionary dictionary];
    }
    return _displayingCells;
}
- (NSMutableSet *)reusableCells
{
    if (!_reusableCells) {
        _reusableCells = [NSMutableSet set];
    }
    return _reusableCells;
}

@end
