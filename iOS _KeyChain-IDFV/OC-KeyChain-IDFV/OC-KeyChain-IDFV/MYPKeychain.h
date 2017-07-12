//
//  MYPKeychain.h
//  OC-KeyChain-IDFV
//
//  Created by 孟跃平 on 2017/7/6.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kIDFVKey = @"IDFV";  // IDFV


//配置属性搜索
static NSString *const kAccessGroup = @"Group@com.mengyueping.www";  // 组
static NSString *const kSeachAttrService = @"Service@mengyueping";
static NSString *const kSeachAttrAccount = @"Account@mengyueping";


@interface MYPKeychain : NSObject

/**
 获得/存储UUID
 
 @return UUID设备标识
 */
+ (NSString *)getToPutUUID;



///增
+ (void)put:(NSString *)key data:(id)data;
///查
+ (id)get:(NSString *)key;
///删
+ (void)delete:(NSString *)key;
///改
+ (void)update:(NSString *)key data:(id)data;

@end
