//
//  ViewController.m
//  OC-KeyChain-IDFV
//
//  Created by 孟跃平 on 2017/7/5.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.
//

#import "ViewController.h"
//#import <Security/Security.h>
#import <AdSupport/AdSupport.h>
#import "MYPKeychain.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)btnClick:(UIButton *)sender {
//    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    NSLog(@"idfa: %@",idfa);
    
    NSString *idfV = [MYPKeychain getToPutUUID];
    NSLog(@"存储/获取IDFV: %@",idfV);
}

- (IBAction)add:(UIButton *)sender {
    
    [MYPKeychain put:@"IDFVVVVVVV" data:@"0000000000000099999"];
    NSString *str = [MYPKeychain get: @"IDFVVVVVVV"];
    NSLog(@"——存储并获取打印str: %@",str);
}


- (IBAction)update:(UIButton *)sender {
    
    [MYPKeychain update:@"IDFVVVVVVV" data:self.textField.text];
    NSString *str = [MYPKeychain get: @"IDFVVVVVVV"];
    NSLog(@"——更新并获取打印——str: %@",str);

}
- (IBAction)delete:(UIButton *)sender {
    
    [MYPKeychain delete:@"IDFVVVVVVV"];
    NSString *str =[MYPKeychain get: @"IDFVVVVVVV"];
    NSLog(@"——删除存储并获取打印——str: %@",str);

}
- (IBAction)getAndLog:(UIButton *)sender {
    
    NSString *str = [MYPKeychain get: @"IDFVVVVVVV"];
    NSLog(@"——getAndLog——获取存储并打印: %@",str);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
