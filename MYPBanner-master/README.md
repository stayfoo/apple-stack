# 轮播图控件

##一、使用
###1、文件的使用
* 直接把`BannerAd-MYP`文件夹拖拽到项目中。
* `BannerAd-MYP`文件夹中一个类：`MYPBannerAdView`
    * `MYPBannerAdView` ： 显示轮播图的View。

###2、使用

直接在需要使用的控制器中创建，添加到父类View上面：

```Objective-C
MYPBannerAdView *banner = [[MYPBannerAdView alloc] init];
   banner.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150);

   //设置图片数组，可以是图片名字 或 图片的网络URL
   banner.adImgs = @[@"pic_0.jpg",@"pic_1.jpg",@"pic_2.jpg",@"pic_3.jpg",@"http://d.hiphotos.baidu.com/zhidao/pic/item/3b87e950352ac65c1b6a0042f9f2b21193138a97.jpg"];

   banner.imageContentMode = UIViewContentModeScaleToFill; //设置图片显示模式
   banner.isAutoLoop = YES;  //设置无限轮播
   banner.autoLoopDuration = 2; //设置两张图片轮播速度 2秒
   [self.view addSubview:banner];
```

###3、接口


```Objective-C
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
```

* 添加图片资源：
`@property (nonatomic,strong) NSArray *adImgs;`使用：

```Objective-C
banner.adImgs = @[@"pic_0.jpg",@"pic_1.jpg",@"pic_2.jpg",@"pic_3.jpg",@"pic_4.jpg"];
```

##二、核心技术点

* 思想：
    * 1、通过图片资源数组 `@property (nonatomic,strong) NSArray *adImgs;`，设置要显示的图片。

    * 2、转换图片资源数组为：`@property (nonatomic,strong) NSMutableArray *imgs;` 。
    给原数组首尾各增加一个元素，首位置：插入原数组最后一个元素，尾位置：插入原数组第0个元素。
    ```
    eg:
    _adImgs传入:  [@"pic_0",@"pic_1",@"pic_2"]
    _imgs处理后: [@"pic_2",@"pic_0",@"pic_1",@"pic_2",@"pic_0"]
    ```
    转换代码在`@property (nonatomic,strong) NSMutableArray *imgs;`的懒加载中进行。

    * 3、操作：
        * 传入图片数组中元素为5个（从0~4），处理后数组元素个数是7个（从0~6，使用的是第1~5。第0个和第5个相同，第6个和第1个相同）；

        * 当图片滚动到第5张时，继续滚动到第6张，当第6张完全显示出来的时候，转成第1张（不要动画，神不知鬼不觉，偷龙转凤）；此处需要对`pageControl`进行单独处理。

        * 同样，当图片从第1张，往前滚动到第0张，当第0张完全显示出来的时候，转成第5张（不要动画），对`pageControl`进行单独处理。

* 代码：

```Objective-C
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.bounds.size.width;
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger page = offsetX / width; //在最后一张转换第一张，判断页面是否展示完全，等完全展示后，再切换。

    int index = (int)(offsetX / width + 0.5) % self.imgs.count;

    if (self.isAutoLoop) {

        //在最后一张和第一张单独处理pageControl
        if (index == self.adImgs.count + 1 ) {
          //最后一张
            self.pageControl.currentPage = 0;
        }
        if (index == 0) {
          //第0张
            self.pageControl.currentPage = self.adImgs.count;
        }

        //到最后一张图片时，向后滚时，跳到第一张
        if (index == self.adImgs.count + 1  && page == index) {
            self.currentIndex = 1;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];

            [self.adView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];

            return; //scrollView.contentOffset.x < width * 0.5
        }else if (index == 0 && offsetX == 0) {
          //到第一张时，向前滚时，跳到最后一张
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
```
