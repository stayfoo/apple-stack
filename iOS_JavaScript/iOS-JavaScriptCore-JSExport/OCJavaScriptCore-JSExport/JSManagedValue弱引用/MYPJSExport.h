//
//  MYPJSExport.h
//  JSManagedValue弱引用
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
//注意：在OC中，保存JS的对象，不要使用JSValue对象作为属性，容易循环引用，替代使用JSManagedValue对象。
//@property (nonatomic, strong) JSValue *jsValue;

//JSManagedValue对象本身是弱引用，来打破强引用，可以用来保存JSValue对象（JS对象）
@property (nonatomic, strong) JSManagedValue *managedValue;

@end
