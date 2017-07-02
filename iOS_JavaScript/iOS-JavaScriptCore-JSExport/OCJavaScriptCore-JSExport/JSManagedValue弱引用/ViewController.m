//
//  ViewController.m
//  JSManagedValue弱引用
//
//  Created by 孟跃平 on 2017/6/27.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

#import "ViewController.h"
#import "MYPObject.h"

@interface ViewController ()
@property (nonatomic, strong) MYPObject *obj;
@property (nonatomic, strong) JSContext *context;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化
    self.obj = [[MYPObject alloc] init];
    self.context = [[JSContext alloc] init];
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception = exception;
        NSLog(@"JS抛出exception: %@",exception);
    };
    
    
    self.context[@"OCobj"] = self.obj;
    [self.context evaluateScript: @"function callback(){};"];
    

    //把JS对象存储为全局属性，方便OC下次调用JS
    self.obj.managedValue = [JSManagedValue managedValueWithValue:self.context[@"callback"]];
    [JSContext.currentContext.virtualMachine addManagedReference:self.obj.managedValue withOwner:self];
    NSLog(@"self.obj.managedValue.value: %@", self.obj.managedValue.value); // function callback(){}
    // 用 JSManagedValue来保存 JSValue
    
    
    // 如果直接使用JSValue对象作为属性，调用JS方法，进行赋值，JS对象保留了传进来的obj，最后，JS将自己的回调callback赋值给了obj，方便obj下次回调给JS；由于JS那边保存了obj，而且obj这边也保留了JS的回调。这样就形成了循环引用。
    
    
    
    //注意：只有在协议中定义的方法和属性才能够在JS中被调用。
    [self.context evaluateScript:@"OCobj.text = '测试';"];
    NSLog(@"self.obj.text: %@",self.obj.text);
}



@end
