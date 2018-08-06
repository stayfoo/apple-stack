//
//  ViewController.m
//  调用Safari
//
//  Created by apple on 16/10/22.
//  Copyright © 2016年 MengYP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end
@implementation ViewController

- (IBAction)clickBtnOpenUrl
{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.baidu.com"] options:@{@"urlName":@"百度"} completionHandler:^(BOOL success) {
        
        NSLog(@"Current Thread: %@",[NSThread currentThread]);  //main 主线程
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
}



@end
