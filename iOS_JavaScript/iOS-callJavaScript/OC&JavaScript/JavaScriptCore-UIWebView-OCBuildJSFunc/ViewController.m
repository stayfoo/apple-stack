//
//  ViewController.m
//  JavaScriptCore-UIWebView-OCBuildJSFunc
//
//  Created by 孟跃平 on 2017/6/23.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

/*
 * JavaScriptCore结合UIWebView 当点击js函数时，响应OC操作
 *
     context[@"jsMethodName"] = ^(){//执行的OC代码};
     其中，
         jsMethodName是JS中触发事件的方法名字；
         ^(){//执行的OC代码} 这个block通过JSContext对象变成名字为jsMethodName的JS方法；
     所以当触发Html点击事件所监听的jsMethodName方法时，就等于触发了OC的Block中的代码。
 
 
     Block中的执行环境是子线程。可以更新部分UI：view设置背景色、调用webView执行js。弹出原生alertView会Crash子线程操作UI的错误信息。
 
     Block避免循环引用，因为block会持有外部变量，而JSContext也会强引用它所有的变量，self使用weakSelf。block内不要使用外部的JSContext对象、JSValue对象。如果要使用JSContext对象，可以使用[JSContext currentContext]，也可以把JSContext对象、JSValue对象当做block的参数传入。
 */

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic,weak) UIWebView *webView;
@end
@implementation ViewController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect webFrame = CGRectMake(30, 80, self.view.bounds.size.width-60, self.view.bounds.size.height-100);
    UIWebView *webView = [[UIWebView alloc] initWithFrame:webFrame];
    NSURL *htmlUrl = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
//    NSURL *htmlUrl = [NSURL URLWithString:@""];
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlUrl];
    
    webView.scrollView.bounces = NO; //关闭webView的回弹效果
    webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;//UIWebView滚动的比较慢，这里设置为正常速度
    
    [webView loadRequest:request];
    [self.view addSubview:webView];
    self.webView = webView;
    self.webView.delegate = self;
}
- (void)dealloc
{
    NSLog(@"%s",__func__);
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    __weak typeof (self) weakSelf = self;
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"handleJSToiOS"] = ^(){
        NSLog(@"CurrentThread: %@",[NSThread currentThread]); //此Block是子线程
        
        // 获取js函数传入的参数
        NSArray *args = [JSContext currentArguments];
        for (int i = 0; i<args.count; i++) {
            NSLog(@"args[%d]: %@",i,args[i]);
        }
        
        // 使用JSContext执行JS代码，将JS传递给OC/Swift的数据，传递回JS
        //方法一：
        NSString *jsStr = [NSString stringWithFormat:@"showAlert('%@')",args[0]];
        [[JSContext currentContext] evaluateScript:jsStr];
        
        //方法二：
        [[JSContext currentContext][@"showAlert"] callWithArguments:args];
        
        // 修改原生UI
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{  //回到主线程
            
            weakSelf.view.backgroundColor = [UIColor orangeColor];
            
            // BOM操作
//            [weakSelf.webView goBack];
//            [weakSelf.webView goForward];
//            [weakSelf.webView reload];
        });
        
        // 播放系统音效
        AudioServicesPlaySystemSound(1007); // 1007是系统声音的编号
        
        /*
         此处可以执行的任务：
             获取地理位置信息、调用相机、扫一扫二维码、调用系统分享面板、更改原生控件属性样式（回到主线程）、
             原生调用支付（JS把支付参数传递给OC/Swfit进行支付、OC/Swfit把支付结果反馈给JS）、
             摇一摇、播放系统音效、
         */
    };
}

@end
