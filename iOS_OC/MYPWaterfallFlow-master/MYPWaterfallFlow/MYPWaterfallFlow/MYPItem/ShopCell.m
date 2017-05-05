//
//  ShopCell.m
//  MYPWaterfallFlow
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 MengYP. All rights reserved.
//

#import "ShopCell.h"
#import "Shop.h"
#import "MYPWaterflowView.h"
#import "UIImageView+WebCache.h"

@interface ShopCell()
/** pictureView图片 */
@property (nonatomic,weak)  UIImageView *imgView;
/** 价格 */
@property (nonatomic,weak)  UILabel *priceLabel;
@end
@implementation ShopCell
+ (instancetype)cellWithWaterflowView:(MYPWaterflowView *)waterflowView
{
    static NSString *ID = @"SHOP";
    ShopCell *cell = [waterflowView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ShopCell alloc] init];
        cell.identifier = ID;
    }
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        self.imgView = imageView;
        
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.textColor = [UIColor whiteColor];
        [self addSubview:priceLabel];
        self.priceLabel = priceLabel;
    }
    return self;
}
- (void)setShop:(Shop *)shop
{
    _shop = shop;
    
    self.priceLabel.text = shop.price;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imgView.frame = self.bounds;
    
    CGFloat priceX = 0;
    CGFloat priceH = 25;
    CGFloat priceY = self.bounds.size.height - priceH;
    CGFloat priceW = self.bounds.size.width;
    self.priceLabel.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
}

@end
