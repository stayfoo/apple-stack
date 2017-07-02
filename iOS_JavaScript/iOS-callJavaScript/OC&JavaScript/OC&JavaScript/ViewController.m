//
//  ViewController.m
//  OC&JavaScript
//
//  Created by 孟跃平 on 2017/6/13.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

/*
 * 使用UIWebView加载HTML
 */

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UI控件设置
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    NSURL *htmlUrl = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlUrl];
    [webView loadRequest:request];
}

// 实现代理 UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //网页开始加载时调用
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //网页加载完成时调用
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //网页加载失败时调用
}

@end
