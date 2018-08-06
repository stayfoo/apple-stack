//
//  ViewController.m
//  距离传感器
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 MengYP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end
@implementation ViewController

- (IBAction)clickBtn:(id)sender {
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityChanged) name:UIDeviceProximityStateDidChangeNotification object:nil];
    
}

- (void)proximityChanged
{
    NSLog(@"距离传感器通知监听");
    
    BOOL isProximity = [UIDevice currentDevice].proximityState; //YES : 有物体在手机屏幕上面  NO：没有
    NSLog(@"isProximity: %d",isProximity);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceProximityStateDidChangeNotification object:nil];//移除通知
}


@end
