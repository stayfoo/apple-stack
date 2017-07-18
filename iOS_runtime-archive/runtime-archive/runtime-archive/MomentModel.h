//
//  MomentModel.h
//  runtime-archive
//
//  Created by 孟跃平 on 2017/7/17.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MomentModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *place;

@end
