//
//  ViewController.m
//  runtime-archive
//
//  Created by 孟跃平 on 2017/7/17.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.

// 归档（序列化）& 解档（反序列化）

#import "ViewController.h"
#import "UserModel.h"
#import "MomentModel.h"
#import <objc/message.h>

/*
 Runtime运行时，苹果提供了一个API，属于一个C语言的库。
 
 作用：
 利用Runtime运行时，在程序运行的过程中，
    动态创建一个类。
    动态修改一个类的属性/方法。
 遍历一个类的所有的属性和方法。
 
 Method：成员方法。
 Ivar：成员变量。
 */

NSString *const k_user_path = @"user.user";
NSString *const k_moment_path = @"moment.moment";
#define kUserPath(path) [NSTemporaryDirectory() stringByAppendingPathComponent:path]

@interface ViewController ()
@property (nonatomic, strong) UserModel *usermodel; //模型
@property (nonatomic, strong) MomentModel *momentmodel; //模型
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.momentmodel = [[MomentModel alloc] init];
    self.momentmodel.content = @"这是一条动态";
    self.momentmodel.time = @"2017.7.17";
    self.momentmodel.pic = @"http://pic.jpg";
    self.momentmodel.place = @"Beijing";
    
    
    //模型实例化
    self.usermodel = [[UserModel alloc] init];
    self.usermodel.name = @"小明";
    self.usermodel.age = @18;
    self.usermodel.avatar = @"avatar.jpg";
    
    
//    unsigned int *   ：是一个C语言指针，这个指针指向 unsigned int 类型。
//    C语言里，如果传递一个基本数据类型的指针，那么一般都是需要在函数内部修改它的值。
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([UserModel class], &outCount);
    Ivar ivar = ivars[1];
    const char * name = ivar_getName(ivar);
    NSLog(@"count: -- %u",outCount);
    NSLog(@"name: -- %s",name);
    NSLog(@"name:  %@",[NSString stringWithUTF8String:name]);
    
    
    
    // 获取属性
    unsigned int count = 0;
    objc_property_t *ps = class_copyPropertyList([UserModel class], &count);
    objc_property_t p = ps[1];
    const char * n = property_getName(p);
    NSLog(@"n: %@",[NSString stringWithUTF8String:n]);
    NSLog(@"n: -- %s",n);
    NSLog(@"count: -- %u",count);
    
}
- (IBAction)rchive:(id)sender {
    //归档
    [NSKeyedArchiver archiveRootObject:self.usermodel toFile:kUserPath(k_user_path)];
    
    [NSKeyedArchiver archiveRootObject:self.momentmodel toFile:kUserPath(k_moment_path)];
}
- (IBAction)unrchive:(id)sender {
    //解档
    UserModel *usermodel = [NSKeyedUnarchiver unarchiveObjectWithFile:kUserPath(k_user_path)];
    NSLog(@"name: %@ |age: %@ |avatar: %@",usermodel.name,usermodel.age,usermodel.avatar);
    
    MomentModel *momentmodel = [NSKeyedUnarchiver unarchiveObjectWithFile:kUserPath(k_moment_path)];
    NSLog(@"moment: %@ | %@ | %@ | %@",momentmodel.content,momentmodel.time,momentmodel.pic, momentmodel.place);

}

@end
