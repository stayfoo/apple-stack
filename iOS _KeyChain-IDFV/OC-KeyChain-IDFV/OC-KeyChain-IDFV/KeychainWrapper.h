//
//  KeychainWrapper.h
//  OC-KeyChain-IDFV
//
//  Created by 孟跃平 on 2017/7/5.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeychainWrapper : NSObject
{
    NSMutableDictionary        *keychainData;         // 存储的数据
    NSMutableDictionary        *genericPasswordQuery; // 搜索字典
}

@property (nonatomic, strong) NSMutableDictionary *keychainData;
@property (nonatomic, strong) NSMutableDictionary *genericPasswordQuery;

// Designated initializer.
- (id)initWithIdentifier: (NSString *)identifier accessGroup:(NSString *) accessGroup;

- (void)mySetObject:(id)inObject forKey:(id)key;
- (id)myObjectForKey:(id)key;
- (void)resetKeychainItem;

@end
