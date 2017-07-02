//
//  ViewController.m
//  JavaScriptCore-JSExport
//
//  Created by 孟跃平 on 2017/6/27.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.
//
/*
 *  使用JS调用OC对象的方法，使用JS修改OC对象属性值
 */
#import "ViewController.h"
#import "MYPObject.h"

@interface ViewController ()
@property (nonatomic, strong) MYPObject *obj;   //遵守协议<MYPJSExport>的OC对象
@property (nonatomic, strong) JSContext *context;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化
    self.obj = [[MYPObject alloc] init];
    self.context = [[JSContext alloc] init];
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        [JSContext currentContext].exception = exception;
        NSLog(@"JS抛出exception: %@",exception);
    };
    
    
    //将OC对象obj添加到context中
    self.context[@"OCobj"] = self.obj;
    //使用JS调用存储在context中的OC对象obj的方法，并将结果赋值给OC对象obj的sum属性
    [self.context evaluateScript:@"OCobj.sum = OCobj.add(2,3)"]; //OC对象属性值改变是在主线程
    //更改了OC对象 self.obj 的属性值sum , 可见，都是强引用。
    NSLog(@"self.obj.sum: %ld",(long)self.obj.sum);  // self.obj.sum: 5
}

@end
