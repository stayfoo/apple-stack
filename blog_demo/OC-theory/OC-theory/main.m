//
//  main.m
//  OC-theory
//
//  Created by 孟跃平 on 2018/8/4.
//  Copyright © 2018年 孟跃平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

//@interface NSObject <NSObject> {
//    Class isa  OBJC_ISA_AVAILABILITY;
//}

// NSObject Implementation
struct NSObject_IMPL {
    Class isa;
};

// Class是一个指向结构体的指针
//typedef struct objc_class *Class;


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSObject *obj = [[NSObject alloc] init];
        
        // 获取 NSObject 对象成员变量所占的内存空间大小，也就是 isa 指针所占空间的大小： 8
        NSLog(@"%zu", class_getInstanceSize([NSObject class]));
        
        // 获得 obj 指针所指向内存的大小。NSObject 对象分配的内存空间大小： 16
        NSLog(@"%zu",malloc_size((__bridge const void *)obj));
        
    }
    return 0;
}
