//
//  UserModel.h
//  runtime-archive
//
//  Created by 孟跃平 on 2017/7/17.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.
//

/*
 * 用户模型类
 */

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, copy) NSString *avatar;

@end
