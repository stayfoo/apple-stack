//
//  ShopCell.h
//  MYPWaterfallFlow
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 MengYP. All rights reserved.
//

#import "MYPWaterflowViewCell.h"
@class Shop,MYPWaterflowView;


@interface ShopCell : MYPWaterflowViewCell
/** MShop模型属性 */
@property (nonatomic,strong) Shop *shop;

+ (instancetype)cellWithWaterflowView:(MYPWaterflowView *)waterflowView;
@end
