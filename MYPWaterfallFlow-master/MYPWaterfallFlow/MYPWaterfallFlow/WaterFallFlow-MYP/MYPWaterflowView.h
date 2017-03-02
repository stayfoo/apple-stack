//
//  MYPWaterflowView.h
//  MYPWaterfallFlow
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 MengYP. All rights reserved.
//  自定义瀑布流控件 -- 展示View （类似于UITableView UITableViewCell）

#import <UIKit/UIKit.h>
@class MYPWaterflowView,MYPWaterflowViewCell;

typedef enum{
    MYPWaterflowViewCellMarginTypeTop,
    MYPWaterflowViewCellMarginTypeBottom,
    MYPWaterflowViewCellMarginTypeLeft,
    MYPWaterflowViewCellMarginTypeRight,
    MYPWaterflowViewCellMarginTypeColumn, //每一列
    MYPWaterflowViewCellMarginTypeRow //每一行
    
} MYPWaterflowViewMarginType;

#pragma mark - 数据源接口
@protocol MYPWaterflowViewDataSource <NSObject>
@required
/**
 *  一共有多少个数据
 */
- (NSUInteger)numberOfCellsInWaterflowView:(MYPWaterflowView *)waterflowView;
/**
 *  返回index位置对应的cell
 */
- (MYPWaterflowViewCell *)waterflowView:(MYPWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index;

@optional
/**
 *  一共有多少列
 */
- (NSUInteger)numberOfColumnsInWaterflowView:(MYPWaterflowView *)waterflowView;
@end

#pragma mark - 代理接口
@protocol MYPWaterflowViewDelegate <UIScrollViewDelegate>
@optional
/**
 *  第index位置对应的高度
 */
- (CGFloat)waterflowView:(MYPWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index;
/**
 *  选中第index位置的cell
 */
- (void)waterflowView:(MYPWaterflowView *)waterflowView didSelectAtIndex:(NSUInteger)index;
/**
 *  返回间距
 */
- (CGFloat)waterflowView:(MYPWaterflowView *)waterflowView marginForType:(MYPWaterflowViewMarginType)type;

@end


@interface MYPWaterflowView : UIScrollView
/** 数据源 */
@property (nonatomic,weak) id<MYPWaterflowViewDataSource> dataSource;
/** 代理 */
@property (nonatomic,weak) id<MYPWaterflowViewDelegate> delegate;
/**
 *  刷新数据（只要调用这个方法，会重新向数据源和代理发送请求，请求数据）
 */
- (void)reloadData;
/**
 *  cell的宽度
 */
- (CGFloat)cellWidth;
/**
 *  根据标识去缓存池查找可循环利用的cell
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
@end


