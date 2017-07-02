//
//  ViewController.m
//  JavaScriptCore-OCExecuteJS
//
//  Created by 孟跃平 on 2017/6/18.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//
/*
 * 使用JavaScriptCore执行一段JavaScript代码
 *
 * 使用OC的Block定义js函数。
 */

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()

@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
#pragma mark 初始化 JSContext 对象
    
    JSContext *context = [[JSContext alloc] init];
    // 异常处理回调
    context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSLog(@"%@", exception);
        context.exception = exception;
        /*
         此处打印js异常错误，JSContext不会主动抛出js异常。
         常见异常：
             ReferenceError: Can't find variable:
             TypeError: undefined is not an object
         */
    };
    
#pragma mark 执行js脚本，返回执行结果
    
    NSString *jsStr1 = @"1+2";
    JSValue *value1 = [context evaluateScript:jsStr1]; // 返回的JSValue对象，存储的是js计算的返回结果。不存储定义的变量。
    NSLog(@"value1 JS: %@  -> OC: %@",value1, value1.toNumber);
    
#pragma mark 执行js脚本，存储js脚本中定义的变量到 JSContext 对象，并key-value方法取出
    
    NSString *jsStr2 = @"var a = 1; var b = 2;";
    JSValue *value2 = [context evaluateScript:jsStr2];
    JSValue *jsValueA = context[@"a"];  // 运行js，定义的变量，存储在context中。
    JSValue *jsValueB = context[@"b"];
    NSLog(@"value2 JS: %@  -> OC: %@",value2, value2.toObject); // value2 JS: undefined  -> OC: (null)
    NSLog(@"JS a: %@;  JS a: %@", jsValueA, jsValueB); // JS a: 1;  JS a: 2
    
#pragma mark 使用key-value方法“取出”并“修改”js对象集合类型的元素值
    
    NSString *jsStr3 = @"var arr = [88, 'mengyueping', 66];";
    JSValue *value3 = [context evaluateScript:jsStr3];
    JSValue *jsArr = context[@"arr"];
    NSLog(@"value3 JS: %@  -> OC: %@",value3, value3.toObject); // value2 JS: undefined  -> OC: (null)
    NSLog(@"JS Array: %@;  Length: %@; jsArr[0]：%@", jsArr, jsArr[@"length"], jsArr[0]); // JS Array: 20,10,www.mengyueping.com;  Length: 3; jsArr[0]：20
    jsArr[0] = @"www.";
    jsArr[2] = @".com";
    NSLog(@"通过下标对js取值赋值：JS Array: %@;  Length: %@; jsArr[0]：%@", jsArr, jsArr[@"length"], jsArr[0]); // JS Array: 20,10,www.mengyueping.com;  Length: 3; jsArr[0]：20
    
#pragma mark 执行js脚本，存储的js集合对象，转换为OC数组对象
    
    NSArray *ocArr = jsArr.toArray;
    NSLog(@"js Arr -> OC Arr: %@", ocArr);
    /*
     js Arr -> OC Arr: (
     "www.",
     mengyueping,
     ".com"
     )
     */
    
#pragma mark 赋值js集合对象的值，没有此元素自动添加补齐
    
    jsArr[8] = @8;
    NSLog(@"通过下标对js取值赋值：JS Array: %@;  Length: %@; jsArr[0]：%@", jsArr, jsArr[@"length"], jsArr[0]);
    // 通过下标对js取值赋值：JS Array: www.,mengyueping,.com,,,,,,8;  Length: 9; jsArr[0]：www.
    NSLog(@"js Arr -> OC Arr: %@", jsArr.toArray);
    /*
     js Arr -> OC Arr: (
     "www.",
     mengyueping,
     ".com",
     "<null>",
     "<null>",
     "<null>",
     "<null>",
     "<null>",
     8
     )
     */
    
#pragma mark 使用js语法创建函数，并执行js，把函数存储到JSContext 对象, 调用js函数传参
    
    [context evaluateScript:@"function add(a, b){ return a + b; }"];
    JSValue *addValue = context[@"add"]; // js函数
    NSLog(@"Func: %@", addValue);  // Func: function add(a, b){ return a + b; }
    
    // 取出js函数，调用函数 - (JSValue *)callWithArguments:(NSArray *)arguments;
    JSValue *sum = [addValue callWithArguments:@[@1,@2]];
    NSLog(@"Sum: %d", sum.toInt32); // Sum: 3
    
    
#pragma mark 另一种简单的调用js函数的方法
    
    JSValue *jsValue = [context evaluateScript:@"function multiply(a, b){ return a * b; }"];
    JSValue *multiplyValue = [jsValue.context.globalObject invokeMethod:@"multiply" withArguments:@[@3,@6]];
//    JSValue *multiplyValue = [context.globalObject invokeMethod:@"multiply" withArguments:@[@3,@6]];
    NSLog(@"multiplyValue: %d",multiplyValue.toInt32); // multiplyValue: 18
    
#pragma mark 使用OC中的Block定义js函数，并存储到JSContext 对象
    
    context[@"log"] = ^(){
        NSLog(@"++++++Begin Log++++++");
        
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@",jsVal);
        }
        
        JSValue *this = [JSContext currentThis];
        NSLog(@"this: %@", this);
        
        NSLog(@"---End Log------");
    };
    // 执行js，调用使用Block自定义的js函数
    [context evaluateScript:@"log('mengyueping', [10,20], {'hello': 'world', 'number': '100'})"];
    /*
     ++++++Begin Log++++++
     mengyueping
     10,20
     [object Object]
     this: [object GlobalObject]
     ---End Log------
     */
}

@end
