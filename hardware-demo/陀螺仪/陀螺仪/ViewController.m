//
//  ViewController.m
//  陀螺仪
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 MengYP. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
@property (nonatomic,strong) CMMotionManager *motionManager;
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 1;
    self.motionManager = motionManager;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //加速传感器（accelerometer）
    if (motionManager.accelerometerAvailable) { //可用
        [motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            
            if (!error) {
                NSLog(@"Accelerometer  Data: %@",accelerometerData);
            }else{
                NSLog(@"Error: %@",error);
            }
        }];
    }else{
        NSLog(@"加速传感器不可用");
    }
    
    //陀螺仪（gyro）
    self.motionManager.gyroUpdateInterval = 1;
    if (self.motionManager.gyroAvailable) { //可用
        [motionManager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            
            if (!error) {
                NSLog(@"Gyro Data: %@",gyroData);
            }else{
                NSLog(@"Error: %@",error);
            }
        }];
    }else{
        NSLog(@"陀螺仪不可用");
    }
    
    //设备运动（deviceMotion）
    self.motionManager.deviceMotionUpdateInterval = 1;
    if (self.motionManager.deviceMotionAvailable) { //可用
        [self.
         motionManager startDeviceMotionUpdatesToQueue:queue withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            
            if (!error) {
                NSLog(@"DeviceMotion %@", motion);
            }else{
                NSLog(@"Error: %@",error);
            }
        }];
    }else{
        NSLog(@"设备运动 不可用");
    }

}
- (IBAction)didClickBtn:(id)sender {
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.motionManager.accelerometerActive) {
        [self.motionManager stopAccelerometerUpdates]; //停止
    }
    
    if (self.motionManager.isGyroActive) {
        [self.motionManager stopGyroUpdates]; //停止
    }
    
    if (self.motionManager.isDeviceMotionActive) {
        [self.motionManager stopDeviceMotionUpdates]; //停止
    }
}


@end
