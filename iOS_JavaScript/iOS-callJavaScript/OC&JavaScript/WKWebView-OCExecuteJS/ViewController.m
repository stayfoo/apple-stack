//
//  ViewController.m
//  WKWebView-OCExecuteJS
//
//  Created by 孟跃平 on 2017/6/15.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKNavigationDelegate, WKUIDelegate>
@property(nonatomic, weak) UIActivityIndicatorView *indicatorView;
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // app注册方法，供JS调用
//    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
//    [userContentController addScriptMessageHandler:self name:@"messageHandler"];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
//        configuration.userContentController = userContentController;
    
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    webView.scrollView.hidden = YES;
    webView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:webView];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    //添加网络加载指示器
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.center = CGPointMake(200, 200);
    [self.view addSubview:indicatorView];
    self.indicatorView = indicatorView;
}

// WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{//页面开始加载时调用
    //指示器开始显示动画
    [self.indicatorView startAnimating];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{ //页面加载完成之后调用
    //指示器结束显示动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        webView.scrollView.hidden = NO;
        [self.indicatorView stopAnimating];
    });
    
    //注意：JavaScript脚本字符串中不需要添加<script></script>标签
//    NSString *jsStr_1 = @"alert('JS弹框')";
//    [webView evaluateJavaScript:jsStr_1 completionHandler:nil];
    
    NSString *jsStr_1 = @"var p = document.getElementsByTagName('p')[0];";
    NSString *jsStr_2 = @"p.innerHTML = '使用JavaScript很🐂';";
    NSString *jsStr_3 = @"p.style.background = 'red';document.body.appendChild(p);";
    [webView evaluateJavaScript:jsStr_1 completionHandler:nil];
    [webView evaluateJavaScript:jsStr_2 completionHandler:^(id _Nullable value, NSError * _Nullable error) {
        NSLog(@"value: %@",value); //打印出插入的内容：使用JavaScript很🐂
    }];
    [webView evaluateJavaScript:jsStr_3 completionHandler:nil];
    
    NSString *jsStr_4 = @"var li = document.createElement('li');li.innerHTML='执行js代码，dom操作元素';li.style.background = 'gray';document.body.appendChild(li);";
    [webView evaluateJavaScript:jsStr_4 completionHandler:nil];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"error: %@",error);
}



@end
