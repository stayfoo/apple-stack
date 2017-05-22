//
//  Animal.swift
//  01-基础
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 KVC 是OC中的机制, 在运行时,间接给对象的属性设置值
 本质: 是在给对象发送 setValue: forKey:这个消息
 会自动检测对象的属性是否为空, 如果为空, 就会调用对象的初始化方法给对象分配内存空间
 */

import Foundation

class Animal: NSObject {
    
    //可选类型的属性在运行时,会临时的分配内存空间,延迟加载
    var name: String? //可选类型,默认是nil
    var age: Int = 0 // 基本数据类型
    
    //AnyObject 表示任意类型
    init(dict: [String : AnyObject]) {
        super.init() //先实例化self
        
        self.setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
    //能够将 "字典中键对应的属性"  "在对象中没有的属性" 过滤掉.
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("value = \(value)")
        print("key = \(key)")
        
        return;
//        super.setValue(value, forUndefinedKey: key)
    }
    
    //便利的构造方法
    convenience init?(name: String, age: Int) {
        if age > 70 || age < 12 {
            return nil //条件不符合,无法构造合法对象
        }
        
        //在便利的构造函数中,可以调用 self.init()
        self.init(dict: ["name": name as AnyObject, "age": age as AnyObject])
    }
}



