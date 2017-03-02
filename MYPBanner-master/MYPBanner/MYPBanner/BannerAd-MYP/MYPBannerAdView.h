//
//  MYPBannerAdView.h
//  MYPBanner
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 MengYP. All rights reserved.
//  轮播控件整体

#import <UIKit/UIKit.h>

@interface MYPBannerAdView : UIView
/**
 轮播图图片数组
 */
@property (nonatomic,strong) NSArray *adImgs;
/**
 是否自动滚动
 */
@property (nonatomic, assign)  BOOL isAutoLoop;
/**
 自动轮播时间间隔，默认0，0表示不开启自动轮播
 */
@property (nonatomic, assign)  NSTimeInterval autoLoopDuration;
/**
 图片的填充模式
 */
@property (nonatomic, assign)  UIViewContentMode imageContentMode;
/**
 占位图片
 */
@property (strong, nonatomic) UIImage *placeholderImage;

@end
