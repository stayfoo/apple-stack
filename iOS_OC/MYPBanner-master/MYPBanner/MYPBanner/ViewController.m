//
//  ViewController.m
//  MYPBanner
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 MengYP. All rights reserved.
//

#import "ViewController.h"
#import "MYPBannerAdView.h" //引入轮播图控件头文件

@interface ViewController ()

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    MYPBannerAdView *banner = [[MYPBannerAdView alloc] init];
    banner.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150);
//    banner.adImgs = @[@"pic_0.jpg",@"pic_1.jpg",@"pic_2.jpg",@"pic_3.jpg",@"pic_4.jpg"];
    banner.adImgs = @[@"pic_0.jpg",@"pic_1.jpg",@"pic_2.jpg",@"pic_3.jpg",@"http://d.hiphotos.baidu.com/zhidao/pic/item/3b87e950352ac65c1b6a0042f9f2b21193138a97.jpg"];
    banner.imageContentMode = UIViewContentModeScaleToFill;
    banner.isAutoLoop = YES;
    banner.autoLoopDuration = 2;
    [self.view addSubview:banner];
}

@end
