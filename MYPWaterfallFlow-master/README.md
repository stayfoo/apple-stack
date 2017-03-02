# 瀑布流控件

## 一、使用
###1、文件的使用
* 直接把`WaterFallFlow-MYP`文件夹拖拽到项目中。
* `WaterFallFlow-MYP`文件夹中两个类：`MYPWaterflowView`和`MYPWaterflowViewCell`。
	* `MYPWaterflowView` ： 显示瀑布流的View。（类似：`UITableView`）
	* `MYPWaterflowViewCell`：显示Cell。（类似`UITableViewCell`）

###2、接口使用
`MYPWaterflowView`接口设计类似于`UITableView`。

* 数据源和代理

	* `MYPWaterflowViewDataSource`:


	```Objective-C
	必须实现的数据源方法：
	/**
	 *  一共有多少个数据
	 */
	- (NSUInteger)numberOfCellsInWaterflowView:(MYPWaterflowView *)waterflowView;
	/**
	 *  返回index位置对应的cell
	 */
	- (MYPWaterflowViewCell *)waterflowView:(MYPWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index;

	可选择实现的数据源方法：
	/**
	 *  一共有多少列
	 */
	- (NSUInteger)numberOfColumnsInWaterflowView:(MYPWaterflowView *)waterflowView;
	```

	* `MYPWaterflowViewDelegate`:

	```Objective-C
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
	```

	* 设置代理和数据源属性：

	```Objective-C
	/** 数据源 */
	@property (nonatomic,weak) id<MYPWaterflowViewDataSource> dataSource;
	/** 代理 */
	@property (nonatomic,weak) id<MYPWaterflowViewDelegate> delegate;
	```

	* 方法调用：刷新数据、Cell宽度、从缓存池子获取Cell

	```Objective-C
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
	```

`MYPWaterflowViewCell`接口：一个属性，循环利用标识。

```
/** 标识 */
@property (nonatomic,copy) NSString *identifier;
```


## 二、技术点

######1.跟随着父控件的尺寸（宽度、高度）而自动伸缩


```Objective-C
waterflowView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
```

######2.横屏、竖屏适配

判断竖屏、横屏:

```Objective-C
if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {//竖屏
    return 3;
}else{
    return 5;
}
```

屏幕旋转完毕时调用:

```Objective-C
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"屏幕旋转完毕");
}
```

## 三、技术思想
