//
//  ViewController.m
//  OCWatchJavaScript
//
//  Created by 孟跃平 on 2017/6/15.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

/*
 *  OC利用UIWebView监听JavaScript函数的触发
 */

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    webView.backgroundColor = [UIColor grayColor];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
    NSURL *htmlUrl = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    [webView loadRequest:[NSURLRequest requestWithURL:htmlUrl]];
}

//代理 UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"mengyueping.com://"]; //自定义协议
    NSUInteger location = range.location;
    
    if (location != NSNotFound) {
        NSString *str = [url substringFromIndex:(location + range.length)];
        SEL selector = NSSelectorFromString(str);
        //警告：PerformSelector may cause a leak because its selector is unknown
        //http://www.tuicool.com/articles/iu6zuu
        //[self performSelector:selector];
        [self performSelector:selector withObject:nil afterDelay:0.0];
    }
    
    return YES;
}

// iOS原生方法访问相册
- (void)openCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
    
}



@end
