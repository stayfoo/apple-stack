//
//  MomentModel.m
//  runtime-archive
//
//  Created by 孟跃平 on 2017/7/17.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.
//

#import "MomentModel.h"

@implementation MomentModel
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_content forKey:@"_content"];
    [coder encodeObject:_time forKey:@"_time"];
    [coder encodeObject:_pic forKey:@"_pic"];
    [coder encodeObject:_place forKey:@"_place"];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _content = [coder decodeObjectForKey:@"_content"];
        _time = [coder decodeObjectForKey:@"_time"];
        _pic = [coder decodeObjectForKey:@"_pic"];
        _place = [coder decodeObjectForKey:@"_place"];
    }
    return self;
}
@end
