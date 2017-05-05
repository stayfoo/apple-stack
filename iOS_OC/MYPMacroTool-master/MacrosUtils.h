//
//  MacrosUtils.h
//  
//
//  Created by 孟跃平. on 17/3/22.
//
//  包含了一些常用的工具相关的宏定义。Contains some common macro definition of utils.

#ifndef MacrosUtils_h
#define MacrosUtils_h


//角度转弧度
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)






#pragma mark 通知中心
#define kNotificationCenter [NSNotificationCenter defaultCenter]


#pragma mark MainBundle
#define kMainBundle [NSBundle mainBundle]



#pragma mark - 弱对象定义

#define kWeakSelf __weak __typeof(self) weakSelf = self;
#define kWeak(caller, object) __weak __typeof(object) caller = object;






#pragma mark - 控制台打印定义

#ifdef DEBUG
#define kLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt),__FILE__,__FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define kLog(...);
#endif




#endif /* MacrosUtils_h */
