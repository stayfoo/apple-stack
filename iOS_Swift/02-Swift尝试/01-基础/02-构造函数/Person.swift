//
//  Person.swift
//  02-构造函数
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 构造方法是一个特殊的函数, 没有返回值
 当构造完毕之后, 就可以访问 self
 
 函数的重载:
 函数名相同, 函数的“参数个数”以及函数“参数的类型”不同就形成函数的重载。
 方便程序员做函数的查找, 便于对功能相近的函数做扩充。
 
 */

import Foundation

class Person: NSObject {
    var name: String
    var age: Int
    
    
    //构造方法
    //override  重写
    override init() {
        print("person init")
        name = "梦一场"
        age = 18
        
        super.init()
    }
    
    //构造方法
    init(name: String, age: Int) {
        self.name = name //当函数的参数和属性名相同时,需要加self. 来区分
        self.age = age
        super.init()
    }
    
}

