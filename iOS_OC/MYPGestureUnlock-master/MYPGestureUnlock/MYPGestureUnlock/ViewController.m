//
//  ViewController.m
//  MYPGestureUnlock
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 MengYP. All rights reserved.
//

#import "ViewController.h"
#import "LockView.h"

@interface ViewController ()<LockViewDelegate>

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //直接使用Storyboard进行初始化，代理设置
    
}

#pragma - LockView 代理方法
- (void)lockView:(LockView *)lockView didFinshPath:(NSString *)path
{
    NSLog(@"获得用户轨迹路径:%@",path);
}


@end
