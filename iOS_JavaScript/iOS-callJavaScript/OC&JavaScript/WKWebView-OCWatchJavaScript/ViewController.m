//
//  ViewController.m
//  WKWebView-OCWatchJavaScript
//
//  Created by 孟跃平 on 2017/6/15.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

/*
 *  OC利用WKWebView监听JavaScript函数的触发
 */

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKNavigationDelegate, WKUIDelegate>

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // app注册方法，供JS调用
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    webView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:webView];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

// 代理 WKNavigationDelegate
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{ //页面重定向时调用，不是每次都调用，不准确
    NSLog(@"navigation: %@",navigation);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{//在发送请求之前，决定是否跳转，可以截获发送的请求
    
    NSString *url = navigationAction.request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"mengyueping.com://"]; //自定义协议
    NSUInteger location = range.location;
    
    if (location != NSNotFound) {
        NSString *str = [url substringFromIndex:(location + range.length)];
        SEL selector = NSSelectorFromString(str);
        //警告：PerformSelector may cause a leak because its selector is unknown
        //[self performSelector:selector];
        [self performSelector:selector withObject:nil afterDelay:0.0];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{// 在收到响应后，决定是否跳转，可以截获服务器的响应数据
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}


// iOS原生方法访问相册
- (void)openCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
    
}
@end
