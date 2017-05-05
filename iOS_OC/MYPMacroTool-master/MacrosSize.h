//
//  MacrosSize.h
//  
//
//  Created by 孟跃平. on 17/3/22.
//
//  包含了一些常用的尺寸相关相关的宏定义。Contains some common macro definition of size.

#ifndef MacrosSize_h
#define MacrosSize_h


#define kScreenW      ([UIScreen mainScreen].bounds.size.width)
#define kScreenH      ([UIScreen mainScreen].bounds.size.height)
#define kScreenSize   ([UIScreen mainScreen].bounds.size)
#define kScreenBounds ([UIScreen mainScreen].bounds)

//屏幕分辨率
#define kScreenResolution (kScreenW * kScreenH * ([UIScreen mainScreen].scale))





#endif /* MacrosSize_h */
