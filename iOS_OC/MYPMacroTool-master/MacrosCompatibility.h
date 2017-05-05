//
//  MacrosCompatibility.h
//  
//
//  Created by 孟跃平. on 17/3/22.
//
//  包含了一些常用的兼容性相关的宏定义。Contains some common macro definition of compatibility.

#ifndef MacrosCompatibility_h
#define MacrosCompatibility_h



#pragma mark - 适配 - 手机

#define kScreenMaxLength (MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))
#define kScreenMinLength (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))



#pragma mark - 适配 - iPhone

#define kIsIphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/** iPhone5 、iPhone5s 、 iPhone5c 、iPhone5SE*/
#define kIsIphone_5_Series (kIsIphone && (MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) == 568.0)
/** iPhone6 、iPhone6s 、 iPhone7 */
#define kIsIphone_6_series (kIsIphone && (MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) == 667.0)
/** iPhone6P 、iPhone6sP 、 iPhone7P */
#define kIsIphone_6P_series (kIsIphone && (MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) == 736.0)

/** iPhone4、iPhone4s、iPhone5 、iPhone5s 、 iPhone5c 、iPhone5SE*/
#define kiPhone4_ScreenWidth  320
/** iPhone6 、iPhone6s 、 iPhone7 */
#define kiPhone6_ScreenWidth  375
/** iPhone6P 、iPhone6sP 、 iPhone7P */
#define kiPhone6P_ScreenWidth 414





#pragma mark - 适配 - 系统版本

/** 获取当前系统版本 */
#define kiOSVersion [[UIDevice currentDevice] systemVersion]
/** 是否是iOS7 及 其以上版本 */
#define kIsIOS7OrLater ([UIDevice currentDevice].systemVersion.integerValue >= 7.0 ? YES : NO)
/** 是否是iOS8.0 及 其以上版本 */
#define kIsIOS8OrLater ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)






#pragma mark - 适配 - iPad

#define kIsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)




#endif /* MacrosCompatibility_h */
