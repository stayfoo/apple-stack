//
//  ViewController.m
//  发邮件and打电话and发短信
//
//  Created by apple on 16/10/22.
//  Copyright © 2016年 MengYP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//发送短信
- (IBAction)sendSMSBtn
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://10086"] options:@{@"urlName":@"sms"} completionHandler:^(BOOL success) {
        
    }];
}

//打电话
- (IBAction)makeCallBtn
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"] options:@{@"urlName":@"tel"} completionHandler:^(BOOL success) {
        
    }];
}

//发送邮件
- (IBAction)sendEmailBtn
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://1134471523@qq.com"] options:@{@"urlName":@"mailto"} completionHandler:^(BOOL success) {
        
    }];
}


- (IBAction)openOtherAppMYP_AppBtn
{
    
    NSString *customUrl = @"mypapp://";
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:customUrl]]) {
        
        /**
         -canOpenURL: failed for URL: "mypapp://" - error: "This app is not allowed to query for scheme mypapp"
         */
        
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customUrl] options:@{@"urlName":@"mypapp"} completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"成功");
            }else{
                NSLog(@"失败");
            }
        }];
        
    }else{
        NSLog(@"不能打开URLScheme: %@",customUrl);
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
