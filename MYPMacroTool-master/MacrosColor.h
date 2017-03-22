//
//  MacrosColor.h
//  
//
//  Created by 孟跃平. on 17/3/22.
//
//  包含了一些常用的颜色相关相关的宏定义。Contains some common macro definition of color.

#ifndef MacrosColor_h
#define MacrosColor_h


/** 根据16进制颜色 */
#define kUIColorRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/** 随机色（带有透明度）*/
#define kUIColorRandomRGBA [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:arc4random_uniform(256)/255.0]
/** 随机色 */
#define kUIColorRandomRGB [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:(255.0)/255.0]
/** RGB-颜色 */
#define kUIColorRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/** RGBA-颜色 */
#define kUIColorRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]



#endif /* MacrosColor_h */
