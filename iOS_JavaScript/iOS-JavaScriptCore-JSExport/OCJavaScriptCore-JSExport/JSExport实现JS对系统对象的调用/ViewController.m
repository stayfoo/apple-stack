//
//  ViewController.m
//  JSExport实现JS对系统对象的调用
//
//  Created by 孟跃平 on 2017/6/27.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

#import "ViewController.h"
#import "MYPJSExport.h"
#import <objc/runtime.h>

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) JSContext *context;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
    //为UITextField类动态添加协议
    class_addProtocol([UITextField class], @protocol(MYPJSExport));
    
    
    // 注意：不能在JS脚本中更改UI控件类的UI属性，因为JS的运行是在子线程，不能对UI进行更新。
}

- (IBAction)btnClick:(UIButton *)sender
{
    self.context = [[JSContext alloc] init];
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception = exception;
        NSLog(@"JS抛出exception: %@",exception);
    };
    
    
    self.context[@"log"] = ^() {
        NSLog(@"---Begin Log---");
        NSArray *arr= JSContext.currentArguments;
        for (int i=0; i<arr.count; i++) {
            NSLog(@"arr[%d] = %@",i, arr[i]);
        }
        
        NSLog(@"%@",[NSThread currentThread]); // 主线程
        NSLog(@"---End Log---");
    };
    
    // 实现：可以在JS中拿到原生控件的属性值。
    self.context[@"textField"] = self.textField;
    NSString *script = @"var text = textField.text;";
    [self.context evaluateScript:script];
    [self.context evaluateScript:@"log(text)"]; // 此处执行log函数，log内部依然是主线程。
    
}

- (IBAction)addBtnClick:(UIButton *)sender
{
    NSString *script = @"var num = parseInt(textField.text, 10);"
    "++num;"
    "textField.text = num;";
    [self.context evaluateScript: script];
    
    //问题：JS执行环境都是在子线程，修改UITextField的text属性值是更新UI，子线程更新UI会Crash。为什么此处更新成功了？
    //猜想：JS调用OC，OC执行依然在主线程。
    //证实：使用OC执行JS脚本，JS脚本调用OC，对OC对象属性值改变，是在主线程发生的。
}

// 通过-evaluateScript: 方法，OC执行JS脚本，此时JS脚本的执行是在主线程，可以通过JS更新原生控件UI。
// JS 直接在Html中调用OC定义的JS函数，运行是在子线程。

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception = exception;
        NSLog(@"JS抛出exception: %@",exception);
    };
    self.context[@"log"] = ^() {
        NSLog(@"---Begin Log---");
        
        NSArray *arr= JSContext.currentArguments;
        for (int i=0; i<arr.count; i++) {
            NSLog(@"arr[%d] = %@",i, arr[i]);
        }
        
        NSLog(@"%@",[NSThread currentThread]); //子线程
        NSLog(@"---End Log---");
    };
    //注意：直接在Html中调用OC定义的JS函数，运行是在子线程。
    
    
    
    
    // 存储OC对象，JS调用OC，JS脚本中获得OC对象的属性值。
    JSValue *jsObj = [JSValue valueWithObject:self.textField inContext:self.context]; //把OC对象转为JS对象
    JSManagedValue *managedValue = [JSManagedValue managedValueWithValue:jsObj];
    [self.context.virtualMachine addManagedReference:managedValue withOwner:self];
    self.context[@"jsObj"] = jsObj; // 存储JS对象
    
}

@end
