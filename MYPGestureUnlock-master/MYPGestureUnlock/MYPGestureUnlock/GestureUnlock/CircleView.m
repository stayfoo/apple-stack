//
//  CircleView.m
//  MYPGestureUnlock
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 MengYP. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

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
    //1.设置btn没有点击效果
    self.userInteractionEnabled = NO;
    
    //2.设置默认的背景图片
    [self setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
    
    //3.设置被选中时背景图片(selected)
    [self setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
}


@end
