//
//  MYPJSExport.h
//  JavaScriptCore-JSExport
//
//  Created by 孟跃平 on 2017/6/27.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.
//

/*
 * 自定义协议继承自 <JSExport>
 */

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol MYPJSExport <JSExport>
@property (nonatomic, assign) NSInteger sum;
JSExportAs(add, - (NSInteger)add:(NSInteger)a b:(NSInteger)b);

@end
