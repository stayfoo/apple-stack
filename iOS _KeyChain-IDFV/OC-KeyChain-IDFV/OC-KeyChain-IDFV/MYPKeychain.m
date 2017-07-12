//
//  MYPKeychain.m
//  OC-KeyChain-IDFV
//
//  Created by 孟跃平 on 2017/7/6.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.
//

#import "MYPKeychain.h"
#import <UIKit/UIKit.h>

@implementation MYPKeychain
#pragma mark - 接口
/**
 获得/存储IDFV
 
 @return IDFV设备标识
 */
+ (NSString *)getToPutUUID
{
    NSString *idfv = [self get:kIDFVKey];
    
    if (!idfv) {
        idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [self put:kIDFVKey data:idfv];  //存储到Keychain
    }
    
    return idfv;
}

#pragma mark 增
+ (void)put:(NSString *)key data:(id)data
{
    NSMutableDictionary *keychainData = [self getKeychainBaseDict];
    if ([self get:key]) {
        [self update:key data:data]; //更新
        return;
    }
    [keychainData setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
    
    OSStatus result = SecItemAdd((__bridge CFDictionaryRef)keychainData, NULL);
    if (result == noErr) {
        NSLog(@"SecItemAdd Success.\n");
    }else if(result == -34018) {
        NSAssert(NO, @"add Failure,Internal error when a required entitlement isn't present..\n");
    }else {
        
    }
}

#pragma mark 查
/**
 获得存储的数据
 */
+ (id)get:(NSString *)key
{
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQueryDict];
    
    CFDataRef keyData = NULL;
    OSStatus keychainErr = SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData);
    if (keychainErr == noErr) {
        ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
    }
    if (keyData) {
        CFRelease(keyData);
    }
    return ret;
}
#pragma mark 删
+ (void)delete:(NSString *)key
{
    NSMutableDictionary *keychainQuery = [self getKeychainBaseDict];
    
    OSStatus result = SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    if (result == noErr) {
        NSLog(@"SecItemDelete Success.\n");
    }else if(result == -34018) {
        NSAssert(NO, @"add Failure,Internal error when a required entitlement isn't present..\n");
    }
}
#pragma mark 改
+ (void)update:(NSString *)key data:(id)data
{
    NSMutableDictionary *keychainDict = [self getKeychainBaseDict];
    
    CFDictionaryRef attributes = nil;
    OSStatus keychainErr = SecItemCopyMatching((__bridge CFDictionaryRef)keychainDict, (CFTypeRef *)&attributes);
    if (keychainErr == noErr){
        
        NSMutableDictionary *updateData = [NSMutableDictionary dictionaryWithDictionary:keychainDict];
        [updateData setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
        [updateData removeObjectForKey:(__bridge id)kSecClass];
        [self updateWithData:updateData keychainQuery:keychainDict];
        
    }else if (keychainErr == errSecItemNotFound) { //如果在Keychain中没有找到，就创建
        
        [self put:key data:data];
    } else {
        NSAssert(NO, @"Serious error.\n");
    }
    if (attributes) CFRelease(attributes);
}

#pragma mark - 私有方法
+ (void)updateWithData:(NSMutableDictionary *)updateData keychainQuery: (NSMutableDictionary *)query {
    //#if TARGET_IPHONE_SIMULATOR
    //        // 模拟器的都有个默认的组“test”，删了，不然会出错
    //        [updateData removeObjectForKey:(id)kSecAttrAccessGroup];
    //#endif
    
    OSStatus result = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)updateData);
    
    if (result == noErr) {
        NSLog(@"SecItemUpdate Success.\n");
    }else if(result == -34018) {
        NSAssert(NO, @"add Failure,Internal error when a required entitlement isn't present..\n");
    }
}

/**
 keychain item的搜索属性配置
 */
+ (NSMutableDictionary *)getKeychainQueryDict
{
    NSMutableDictionary *dict = [self getKeychainBaseDict];
    [dict setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [dict setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    
    return dict;
}

/**
 keychain item的存储数据配置
 */
+ (NSMutableDictionary *)getKeychainBaseDict
{
    NSDictionary *dict =
    @{
      (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
      (__bridge id)kSecAttrService: kSeachAttrService,
      (__bridge id)kSecAttrAccount: kSeachAttrAccount,
      (__bridge id)kSecAttrAccessible: (__bridge id)kSecAttrAccessibleAfterFirstUnlock,
      (__bridge id)kSecAttrAccessGroup: kAccessGroup
      };
    
    return [NSMutableDictionary dictionaryWithDictionary:dict];
}

@end
