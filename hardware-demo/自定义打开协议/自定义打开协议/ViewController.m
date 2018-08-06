//
//  ViewController.m
//  自定义打开协议
//
//  Created by apple on 16/10/22.
//  Copyright © 2016年 MengYP. All rights reserved.
//

/*
 通过给自己的应用程序自定义打开协议，就可以实现从其他应用 打开到我的应用，并向我的应用传递数据。
 从A程序 -> 跳转到B程序
 
 1.B程序：在info.plist中自定义协议url  :
    URL types  ->  Item0  ->  URL Schemes   ->  Item0 : MYP_App
 
 2.B程序：在AppDelegate中，
    - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
    处理url调用。
 
 3.在A程序中
    报错：-canOpenURL: failed for URL: "mypapp://" - error: "This app is not allowed to query for scheme mypapp"
 
    iOS 9系统策略更新，限制了http协议的访问，此外应用需要在“Info.plist”中将要使用的URL Schemes列为白名单，才可正常检查其他应用是否安装。
 
    受此影响，当你的应用在iOS 9中需要使用微信SDK的相关能力（分享、收藏、支付、登录等）时，需要在“Info.plist”里配置
 
 */


#import "ViewController.h"

@interface ViewController ()

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
