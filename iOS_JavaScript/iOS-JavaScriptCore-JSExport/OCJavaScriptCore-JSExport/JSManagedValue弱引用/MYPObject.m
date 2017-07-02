//
//  MYPObject.m
//  JSManagedValue弱引用
//
//  Created by 孟跃平 on 2017/6/27.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

#import "MYPObject.h"

@implementation MYPObject
@synthesize managedValue = _managedValue;

- (void)setManagedValue:(JSManagedValue *)managedValue
{
    _managedValue = managedValue;
    
    NSLog(@"%@",[NSThread currentThread]);
}
@end
