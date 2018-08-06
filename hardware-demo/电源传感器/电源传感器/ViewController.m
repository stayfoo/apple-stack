//
//  ViewController.m
//  电源传感器
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
    
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(batteryMonitoringLevelChange) name:UIDeviceBatteryLevelDidChangeNotification object:nil];
    
    
    float batteryLevel = [UIDevice currentDevice].batteryLevel;
    NSLog(@"初始值batteryLevel: %f",batteryLevel);
    
    
}

- (void)batteryMonitoringLevelChange
{
    float batteryLevel = [UIDevice currentDevice].batteryLevel;
    NSLog(@"%f",batteryLevel);
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceBatteryLevelDidChangeNotification object:nil];
    
    [super viewWillDisappear:animated];
}


@end
