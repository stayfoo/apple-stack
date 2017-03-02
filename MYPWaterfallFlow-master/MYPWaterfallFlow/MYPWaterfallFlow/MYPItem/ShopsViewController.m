//
//  ShopsViewController.m
//  MYPWaterfallFlow
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 MengYP. All rights reserved.
//

#import "ShopsViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"

#import "MYPWaterflowView.h"
#import "MYPWaterflowViewCell.h"

#import "ShopCell.h"
#import "Shop.h"

@interface ShopsViewController ()<MYPWaterflowViewDelegate,MYPWaterflowViewDataSource>
/** 模型数组 */
@property (nonatomic,strong) NSMutableArray *shops;
/** 瀑布流控件 */
@property (nonatomic,weak)  MYPWaterflowView *waterflowView;

@end
@implementation ShopsViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //0.初始化数据
    NSArray *newShops = [Shop objectArrayWithFilename:@"1.plist"];
    [self.shops addObjectsFromArray:newShops];
    
    //1.瀑布流控件
    MYPWaterflowView *waterflowView = [[MYPWaterflowView alloc] init];
    //跟随着父控件的尺寸（宽度、高度）而自动伸缩
    waterflowView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    waterflowView.frame = self.view.bounds;
    waterflowView.dataSource = self;
    waterflowView.delegate = self;
    [self.view addSubview:waterflowView];
    self.waterflowView = waterflowView;
    
    //2.集成刷新控件
    waterflowView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    waterflowView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
}

/**
 *  屏幕旋转完毕时调用
 */
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"屏幕旋转完毕");
    [self.waterflowView reloadData];
}

#pragma mark - 刷新网络请求
/**
 *  下拉刷新加载数据
 */
- (void)loadNewShops
{
    //加上 dispatch_once_t 只加载一次，模拟数据，如果实际开发去除
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //加载1.plist
        NSArray *newShops = [Shop objectArrayWithFilename:@"1.plist"];
        [self.shops insertObjects:newShops atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newShops.count)]];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //刷新瀑布流控件
        [self.waterflowView reloadData];
        
        //停止刷新
        [self.waterflowView.header endRefreshing];
    });
}
/**
 *  上拉刷新加载数据
 */
- (void)loadMoreShops
{
    //加上 dispatch_once_t 只加载一次，模拟数据，如果实际开发去除
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //加载3.plist
        NSArray *newShops = [Shop objectArrayWithFilename:@"3.plist"];
        [self.shops addObjectsFromArray:newShops];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //刷新瀑布流控件
        [self.waterflowView reloadData];
        
        //停止刷新
        [self.waterflowView.footer endRefreshing];
    });
}


#pragma mark - MWaterflowView数据源方法
//cell个数
- (NSUInteger)numberOfCellsInWaterflowView:(MYPWaterflowView *)waterflowView
{
    return self.shops.count;
}
//columns列数
- (NSUInteger)numberOfColumnsInWaterflowView:(MYPWaterflowView *)waterflowView
{
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {//竖屏
        return 3;
    }else{
        return 5;
    }
}
//cell
- (MYPWaterflowViewCell *)waterflowView:(MYPWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index
{
    ShopCell *cell = [ShopCell cellWithWaterflowView:waterflowView];
    cell.shop = self.shops[index];
    return cell;
}

#pragma mark - MWaterflowView代理方法
- (CGFloat)waterflowView:(MYPWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index
{
    Shop *shop = self.shops[index];
    //根据cell的宽度 和 图片的宽高比  算出 cell的高度
    return waterflowView.cellWidth * shop.h / shop.w;
}

#pragma mark - 懒加载
- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [[NSMutableArray alloc] init];
    }
    return _shops;
}

@end
