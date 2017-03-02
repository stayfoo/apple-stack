//
//  MYPBannerAdView.m
//  MYPBanner
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 MengYP. All rights reserved.
//

#import "MYPBannerAdView.h"
#import "UIImageView+WebCache.h"

#define CELLReuseIdentifier @"BannerAdCell"
#define kPageControlW 80
#define kPageControlH 44
#define kPageControlX ([UIScreen mainScreen].bounds.size.width - kPageControlW)
#define kPageControlY (self.bounds.size.height - kPageControlH)

#pragma mark - adViewcell
@interface adViewCell : UICollectionViewCell
/** 图片名称 */
@property (copy, nonatomic) NSString *imageName;
/** 网络图片路径 */
@property (copy, nonatomic) NSString *imageUrl;
/** 图片控件 */
@property (weak, nonatomic) UIImageView *imageView;
/** 占位图片 */
@property (strong, nonatomic) UIImage *placeholderImage;
@end
@implementation adViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //初始化子控件
        [self setupSubviews];
        
    }
    return self;
}

- (void)setupSubviews
{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.contentMode = UIViewContentModeCenter;
    self.imageView = imgView;
    [self.contentView addSubview:self.imageView];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    UIImage *img = [UIImage imageNamed:_imageName];
    self.imageView.image = img ? img : self.placeholderImage;
}
- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    //网络请求图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"img.jpg"]];
}
@end


#pragma mark - MYPBannerAdView
@interface MYPBannerAdView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
/**
 轮播图控件
 */
@property (weak,nonatomic) UICollectionView *adView;
/**
 布局
 */
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
/**
 轮播图图片数组 （重新构造的Ad图片数组）
 可以是：图片名字 或者 图片网络地址URL
 */
@property (nonatomic,strong) NSMutableArray *imgs;
/**
 自动轮播定时器
 */
@property (nonatomic, strong) NSTimer *timer;
/**
 当前滚动的位置
 */
@property (nonatomic, assign) NSInteger currentIndex;
/**
 上次滚动的位置
 */
@property (nonatomic, assign) NSInteger lastIndex;
/**
 翻页指示器
 */
@property (weak, nonatomic) UIPageControl *pageControl;
@end
@implementation MYPBannerAdView

#pragma mark - 初始化MYPBannerAdView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //初始化CollectionView
        [self setupCollectionViewWithFrame:frame];
        
        self.isAutoLoop = NO;
        self.autoLoopDuration = 0;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.adView.frame = self.bounds;
    
    //默认从展示第一张开始
    if (self.isAutoLoop && 0 == self.adView.contentOffset.x) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.adView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        self.currentIndex = 1;
    }
}


#pragma mark 私有方法

- (void)setupCollectionViewWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout = flowLayout;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *adView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    adView.showsHorizontalScrollIndicator = NO;
    adView.pagingEnabled = YES;
    adView.delegate = self;
    adView.dataSource = self;
    [adView registerClass:[adViewCell class] forCellWithReuseIdentifier:CELLReuseIdentifier];
    self.adView = adView;
    [self addSubview:adView];
}

- (void)setAutoLoopDuration:(NSTimeInterval)autoLoopDuration
{
    _autoLoopDuration = autoLoopDuration;
    
    if (_autoLoopDuration > 0) {
        [self removeTimer];
        [self addTimer];
    }else{
        [self.timer invalidate];
    }
}
//设置自动滚动
- (void)runAutoLoop
{
    NSInteger currentIndex = self.currentIndex + 1;
    currentIndex = (currentIndex == self.imgs.count) ? 1 : currentIndex;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentIndex inSection:0];
    BOOL isAnimated = self.autoLoopDuration <= 0.3 ? NO : YES;
    [self.adView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:isAnimated];
}
/**
 *  添加定时器
 */
- (void)addTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoLoopDuration target:self selector:@selector(runAutoLoop) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes]; //NSDefaultRunLoopMode
    self.timer = timer;
}
/**
 *  移除定时器
 */
- (void)removeTimer
{
    //停止定时器
    [self.timer invalidate]; //将定时器从循环池中移除
    self.timer = nil;
}
#pragma mark 代理 & 数据源（UICollectionViewDataSource & UICollectionViewDelegate & UIScrollViewDelegate）
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    adViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLReuseIdentifier forIndexPath:indexPath];
    cell.imageView.contentMode = self.imageContentMode;
    cell.placeholderImage = self.placeholderImage;
    
    NSString *imgName = self.imgs[indexPath.row];
    if ([imgName hasPrefix:@"http://"] || [imgName hasPrefix:@"https://"]) {
        cell.imageUrl = imgName;
    }else{
        cell.imageName = imgName;
    }
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imgs.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size;
}

#pragma mark 技术核心地带
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.bounds.size.width;
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger page = offsetX / width; //在最后一张转换第一张，判断页面是否展示完全，等完全展示后，再切换。
    
    int index = (int)(offsetX / width + 0.5) % self.imgs.count;
    
    if (self.isAutoLoop) {
        
        //在最后一张和第一张单独处理pageControl
        if (index == self.adImgs.count + 1 ) { //最后一张
            self.pageControl.currentPage = 0;
        }
        if (index == 0) {//第0张
            self.pageControl.currentPage = self.adImgs.count;
        }
        
        
        if (index == self.adImgs.count + 1  && page == index) {//到最后一张图片时，向后滚时，跳到第一张
            self.currentIndex = 1;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
            
            [self.adView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            
            return; //scrollView.contentOffset.x < width * 0.5
        }else if (index == 0 && offsetX == 0) { //到第一张时，向前滚时，跳到最后一张
            self.currentIndex = self.adImgs.count;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
            
            [self.adView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            
            return;
        }else{
            //避免多次调用currentIndex的setter方法
            if (self.currentIndex != self.lastIndex) {
                self.currentIndex = index;
            }
            self.lastIndex = index;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.timer != nil) {
        [self removeTimer];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (self.autoLoopDuration > 0) {
        [self addTimer];
    }
}

#pragma mark - 赋值处理
- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    
    if (_currentIndex < self.adImgs.count + 1) {
        NSInteger index = _currentIndex > 0 ? _currentIndex - 1 : 0;
        self.pageControl.currentPage = index;
    }
}

- (void)setAdImgs:(NSArray *)adImgs
{
    _adImgs = adImgs;
    
    self.pageControl.hidden = !adImgs.count;
    self.pageControl.numberOfPages = adImgs.count;
}

#pragma mark - 懒加载
- (NSMutableArray *)imgs
{
    if (!_imgs) {
        _imgs = [NSMutableArray arrayWithArray:self.adImgs];
        
        if (self.isAutoLoop && self.imgs.count > 0) {//构造新的图片数组
            /*
             adImgs传入:  [@"pic_0",@"pic_1",@"pic_2"]
             _imgs处理后: [@"pic_2",@"pic_0",@"pic_1",@"pic_2",@"pic_0"]
             */
            [_imgs insertObject:[self.adImgs lastObject] atIndex:0];
            [_imgs addObject:self.adImgs[0]];
        }
    }
    return _imgs;
}
- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        [self addSubview:pageControl];
        pageControl.frame = CGRectMake(kPageControlX, kPageControlY, kPageControlW, kPageControlH);
        _pageControl = pageControl;
    }
    return _pageControl;
}

@end


