//
//  MYPJSExport.h
//  JSExport实现JS对系统对象的调用
//
//  Created by 孟跃平 on 2017/6/27.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//
/*
 * 自定义协议继承自 <JSExport>
 */
#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol MYPJSExport <JSExport>
@property (nonatomic, copy) NSString *text;

@end
