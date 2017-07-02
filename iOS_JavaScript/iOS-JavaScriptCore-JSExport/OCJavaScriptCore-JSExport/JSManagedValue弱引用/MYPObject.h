//
//  MYPObject.h
//  JSManagedValue弱引用
//
//  Created by 孟跃平 on 2017/6/27.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//
/*
 * 自定义对象，遵守自定义协议 <MYPJSExport>
 */

#import <Foundation/Foundation.h>
#import "MYPJSExport.h"

@interface MYPObject : NSObject<MYPJSExport>
@property (nonatomic, copy) NSString *text;

@end
