//
//  ViewController.m
//  OCExecuteJavaScript
//
//  Created by 孟跃平 on 2017/6/14.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

/*
 * 使用UIWebView执行JavaScript代码
 */

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property(nonatomic, weak) UIActivityIndicatorView *indicatorView;
@end
@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    webView.scrollView.hidden = YES;
    webView.backgroundColor = [UIColor grayColor];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    NSURL *htmlUrl = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlUrl];
    [webView loadRequest:request];
    
    
    //添加网络加载指示器
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.center = CGPointMake(200, 200);
    [self.view addSubview:indicatorView];
    self.indicatorView = indicatorView;
}

#pragma mark - 代理
- (void)webViewDidStartLoad:(UIWebView *)webView
{//网页开始加载时调用
    //指示器开始显示动画
    [self.indicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{//网页加载完成时调用
    
    //指示器结束显示动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        webView.scrollView.hidden = NO;
        [self.indicatorView stopAnimating];
    });
    
    
    //注意：JavaScript脚本字符串中不需要添加<script></script>标签
    NSString *jsStr_1 = @"alert('JS弹框')";
    [webView stringByEvaluatingJavaScriptFromString:jsStr_1];
    
    NSString *jsStr_2 = @"var p = document.getElementsByTagName('p')[0];";
    NSString *jsStr_3 = @"p.innerHTML = '使用JavaScript很🐂';";
    NSString *jsStr_4 = @"p.style.background = 'red';document.body.appendChild(p);";
    [webView stringByEvaluatingJavaScriptFromString:jsStr_2];
    [webView stringByEvaluatingJavaScriptFromString:jsStr_3];
    [webView stringByEvaluatingJavaScriptFromString:jsStr_4];
    
    NSString *jsStr_5 = @"var li = document.createElement('li');li.innerHTML='执行js代码，dom操作元素';li.style.background = 'gray';document.body.appendChild(li);";
    [webView stringByEvaluatingJavaScriptFromString:jsStr_5];
}



@end

