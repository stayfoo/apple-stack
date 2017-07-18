//
//  ViewController.m
//  runtime-methodExchange
//
//  Created by 孟跃平 on 2017/7/18.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [UIImage imageNamed:@""]
//    UIButton *btn ;
//    [btn addTarget:self action:@selector(did) forControlEvents:(UIControlEventTouchUpInside)];
//    [btn sendAction:<#(nonnull SEL)#> to:<#(nullable id)#> forEvent:<#(nullable UIEvent *)#>];
    
    NSURL *url = [NSURL URLWithString:@"http://www.mengyueping.com/孟跃平"];
    NSLog(@"url: %@",url);
    //没有进行方法交换之前打印： url: (null)
    //交换方法之后： url: http://www.mengyueping.com/%E5%AD%9F%E8%B7%83%E5%B9%B3
}



@end
