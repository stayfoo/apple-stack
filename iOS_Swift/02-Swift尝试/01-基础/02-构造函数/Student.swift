//
//  Student.swift
//  02-构造函数
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import Foundation

class Student: Person {
    
    
    ///学号
    var no: String
    
    ///重写构造方法
    override init() {
        print("Student init")
        no = "007"
        
        super.init()
    }
    
    ///重写父类的构造方法
    override init(name: String, age: Int) {
        no = "007"
        
        super.init(name: name, age: age)
    }
    
    init(name: String, age: Int, no: String) {
        self.no = no
        
        super.init(name: name, age: age)
    }
}
