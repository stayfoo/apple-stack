//
//  ViewController.m
//  加速度传感器
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 MengYP. All rights reserved.
//

//iOS平台加速度传感器的使用方式

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
@property(nonatomic,strong) CMMotionManager *motionManager;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 1;    //获取频率
    self.motionManager = motionManager;
    
    if (motionManager.accelerometerAvailable) { //如果传感器可用
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            
            if (!error) {
                
                double x = accelerometerData.acceleration.x;
                double y = accelerometerData.acceleration.y;
                double z = accelerometerData.acceleration.z;
                
                NSLog(@"Data: %@ ",accelerometerData);  //获取x、y、z三个方向上的加速度
                NSLog(@"x: %f  y: %f   z:%f",x,y,z);
            }else{
                NSLog(@"Error: %@", error);
            }
        }];
        
    }else{ //传感器不可用
        NSLog(@"加速度传感器不可用！"); //当使用模拟器时，打印
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.motionManager.isAccelerometerActive) {
        [self.motionManager stopAccelerometerUpdates]; //停止加速度传感器
    }
}


@end
