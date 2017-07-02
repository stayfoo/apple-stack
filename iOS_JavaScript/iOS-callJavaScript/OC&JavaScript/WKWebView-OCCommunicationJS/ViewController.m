//
//  ViewController.m
//  WKWebView-OCCommunicationJS
//
//  Created by 孟跃平 on 2017/6/17.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//
/*
 *  OC与JS之间的通信
 */

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKNavigationDelegate, WKUIDelegate,WKScriptMessageHandler>

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 为JS提供了一个发送消息的通道，且可以向页面注入JS的类。
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"JSMessageToIOS"];
    // 添加一个脚本信息处理器。self遵守协议WKScriptMessageHandler
    // 脚本信息处理器，可以接收JS脚本发送过来的消息。JS脚本通过`window.webkit.messageHandlers.<name>.postMessage(<messageBody>)`发送消息。
    // 脚本处理器中监听的名字是js脚本里面消息发送的名字。                 window.webkit.messageHandlers.JSMessageToIOS.postMessage(message);
    
    
    // 配置
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController; //配置消息通道
    
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    webView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:webView];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - 协议 WKScriptMessageHandler
// 当JS给OC发送消息时，此回调中执行消息处理
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"JS传递过来的消息-message.body: %@",message.body);
    
    //收到JS传递过来的消息回调，可以做一些原生想要做的事情。--> JS向原生OC传递消息。
    //发送网络请求，页面跳转，打开相机等
    
    [self openCamera];
}

// iOS原生方法访问相册
- (void)openCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

@end
