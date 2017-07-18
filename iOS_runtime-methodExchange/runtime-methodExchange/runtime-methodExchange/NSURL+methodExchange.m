//
//  NSURL+methodExchange.m
//  runtime-methodExchange
//
//  Created by 孟跃平 on 2017/7/18.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.
//

// 方法交换

#import "NSURL+methodExchange.h"
#import <objc/runtime.h>

@implementation NSURL (methodExchange)
/**
 当这个类被加载的时候，此方法会被调用
 */
+ (void)load
{
    //1. 拿到要交换的两个方法：系统方法和自定义的方法
    Method urlmethod = class_getClassMethod([NSURL class], @selector(URLWithString:));
    Method urlmethodmyp = class_getClassMethod([NSURL class], @selector(MYP_URLWithString:));
    
    //2.进行方法交换
    method_exchangeImplementations(urlmethod, urlmethodmyp);
}

/**
 注意：
    1. 在方法 + (void)load 中进行的方法交换，在类被加载的时候，此方法就被调用了。
    2. 在方法 + (instancetype)MYP_URLWithString: 中，此处已经进行了方法实现的交换，所有调用方法 + (instancetype)MYP_URLWithString: 相当于调用系统方法 + (instancetype)URLWithString: 的实现。
    3. 所以此处在做完判空和转码之后，需要调用 + (instancetype)MYP_URLWithString: 即为调用系统方法实现系统所做的事情。
 */
+ (instancetype)MYP_URLWithString:(NSString *)URLString
{
    //1. 转码
//    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; //iOS9不再使用
    URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    //2. 实现系统调用
    NSURL *url = [NSURL MYP_URLWithString:URLString];
    if (url == nil) { //判空
        NSAssert(NO, @"url为空");
    }
    return url;
}


@end
