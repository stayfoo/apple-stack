//
//  ViewController.m
//  磁场传感器
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 MengYP. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIImageView *pointImageView;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    self.locationManager = locationManager;
    
    [locationManager startUpdatingHeading]; //开始更新指向（磁场方向）
}


- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"newHeading: %@",newHeading);
    
    //magneticHeading = 0 手机头部 正向 正北方向
    //magneticHeading = 180  手机头部 正向 正南方向
    
    self.pointImageView.transform = CGAffineTransformMakeRotation((1 - newHeading.magneticHeading/180.0) * M_PI);
    
}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager
{
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


@end
