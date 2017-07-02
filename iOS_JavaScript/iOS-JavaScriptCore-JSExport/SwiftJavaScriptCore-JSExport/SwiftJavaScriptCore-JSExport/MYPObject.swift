//
//  MYPObject.swift
//  SwiftJavaScriptCore-JSExport
//
//  Created by 孟跃平 on 2017/6/28.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

import UIKit
import JavaScriptCore

/// 自定义协议继承自 <JSExport>

//注意：@objc
@objc protocol MYPJSExport: JSExport {
    var sum: Int {get set}
    
    func doNothing()
    
    func squared(_ num: Int) -> Int
    func add(_ a: Int, _ b: Int) -> Int
    
    func add(num: Int) -> Int
    func add(num1: Int, num2: Int) -> Int
    func add(num1: Int, _ num2: Int) -> Int
//    func add(_ num1: Int, num2: Int) -> Int //第一个外部参数省略，是没办法使用JS方法表达
    
}

//注意：@objc
@objc class MYPObject: NSObject, MYPJSExport {
    var sum: Int = 0 {
        willSet{
            print("newValue: \(newValue)  |CurrentThread: \(Thread.current)")
        }
        didSet{
            print("oldValue: \(oldValue)  |CurrentThread: \(Thread.current)")
        }
    }
    
    func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    func doNothing(){
        print("doNothing--")
    }
    func squared(_ num: Int) -> Int {
        return num * num
    }
    
    func add(num: Int) -> Int {
        return num + 10
    }
    func add(num1: Int, num2: Int) -> Int {
        return num1 + num2
    }
    func add(num1: Int, _ num2: Int) -> Int {
        return num1 * num2
    }
    
    //不成立
//    func add(_ num1: Int, num2: Int) -> Int {
//        return (num1 + num2) * 2
//    }
}
