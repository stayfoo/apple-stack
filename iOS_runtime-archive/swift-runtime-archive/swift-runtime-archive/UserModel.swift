//
//  UserModel.swift
//  swift-runtime-archive
//
//  Created by 孟跃平 on 2017/7/17.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.
//
// 使用runtime归档

import UIKit

class UserModel: NSObject, NSCoding {
    var name: String?
    var age: String?
    var avatar: String?
    
    override init() {
        super.init()
    }
    
    // MARK: - 归档
    func encode(with aCoder: NSCoder) {
        
        //1. 获取属性列表 & 属性数量
        var outCount: UInt32 = 0
        let ivars = class_copyIvarList(UserModel.self, &outCount)
        
        //2. 遍历属性列表
        var i = 0
        for _ in Array(repeating: 1, count: Int(outCount)) {
            //3. 获取属性名
            let key = String(cString: ivar_getName(ivars?[i]), encoding: String.Encoding.utf8)!
            //4. kvc获取属性值
            let v = value(forKey: key)
            
            //5. 归档
            aCoder.encode(v, forKey: key)
            
            i += 1
        }
        
        print(String(cString: ivar_getName(ivars?[0]), encoding: String.Encoding.utf8)!)
        
        //6. 释放内存
        free(ivars)
        
    }
    
    // MARK: - 解档
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        //1. 获取属性列表 & 属性数量
        var outCount: UInt32 = 0
        let ivars = class_copyIvarList(UserModel.self, &outCount)
        
        //2. 遍历属性列表
        var i = 0
        for _ in Array(repeating: 1, count: Int(outCount)) {
            //3. 获取属性名
            let key = String(cString: ivar_getName(ivars?[i]), encoding: String.Encoding.utf8)!
            
            //4. 解档
            let v = aDecoder.decodeObject(forKey: key)
            
            //5. kvc获取属性值
            setValue(v, forKey: key)
            
            i += 1
        }
        
        print(String(cString: ivar_getName(ivars?[0]), encoding: String.Encoding.utf8)!)
        
        //6. 释放内存
        free(ivars)
    }
    
}
