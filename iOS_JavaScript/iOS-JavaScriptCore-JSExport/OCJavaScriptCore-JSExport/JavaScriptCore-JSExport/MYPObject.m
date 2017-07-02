//
//  MYPObject.m
//  JavaScriptCore-JSExport
//
//  Created by 孟跃平 on 2017/6/27.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.
//

#import "MYPObject.h"

@implementation MYPObject
@synthesize sum = _sum;

/**
 实现协议方法
 */
- (NSInteger)add:(NSInteger)a b:(NSInteger)b
{
    return a + b;
}

/**
 重写setter方法方便打印信息
 */
- (void)setSum:(NSInteger)sum
{
    _sum = sum;
    NSLog(@"--%@", @(sum));
    NSLog(@"%@",[NSThread currentThread]); // main
}


@end
