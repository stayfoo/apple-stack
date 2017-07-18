//
//  UserModel.m
//  runtime-archive
//
//  Created by 孟跃平 on 2017/7/17.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.
//

#import "UserModel.h"
#import <objc/message.h>

@interface UserModel()
//@property (nonatomic, copy) NSString *grade;

@end
@implementation UserModel

#pragma mark - NSCoding协议
- (void)encodeWithCoder:(NSCoder *)coder
{
    [self code:YES coder:coder];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        [self code:NO coder:coder];
    }
    return self;
}
#pragma mark - 私有
/**
 归档 | 解档

 @param isEncode YES：归档  NO：解档
 */
- (void)code:(BOOL)isEncode coder:(NSCoder *)coder
{
    //1. 获取属性个数 & 属性列表
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([UserModel class], &outCount);
    
    //2. 遍历属性列表，
    for (int i = 0; i<outCount; i++) {
        //3. 获取属性名字
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value;
        if (isEncode) {
            //4. kvc获取属性值
            value = [self valueForKey:key];
            
            //5. 归档
            [coder encodeObject:value forKey:key];
        } else {
            //4. 解档
            value = [coder decodeObjectForKey:key];
            //5. kvc设置属性值
            [self setValue:value forKey:key];
        }
        NSLog(@"count: %u | const char *name: %s | NSString *name: %@ | value: %@", outCount, name, key, value);
        //c语言里面需要释放指针
    }
    free(ivars);
}
@end
