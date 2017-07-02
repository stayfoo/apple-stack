//
//  ViewController.m
//  WKWebView-use
//
//  Created by 孟跃平 on 2017/6/13.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKNavigationDelegate, WKUIDelegate>

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // app注册方法，供JS调用
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"messageHandler"];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
//    configuration.userContentController = userContentController;
    
    
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}


// WKNavigationDelegate
//首次载入调用顺序：didStartProvisionalNavigation -> didCommitNavigation -> didFinishNavigation
//重定向：didStartProvisionalNavigation -> didReceiveServerRedirectForProvisionalNavigation -> didCommitNavigation -> didFinishNavigation
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"--%s",__func__);
    //页面开始加载时调用
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"--%s",__func__);
    //当内容开始返回时调用
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"--%s",__func__);
    //页面加载完成之后调用
}


- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"--%s",__func__);
    //服务器重定向页面时调用,并且在 didStartProvisionalNavigation 之后，didCommitNavigation之前调用。
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"--%s",__func__);
    //页面加载失败时调用
}



@end
