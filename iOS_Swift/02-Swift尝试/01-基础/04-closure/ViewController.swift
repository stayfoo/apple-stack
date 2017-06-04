//
//  ViewController.swift
//  closure
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p = someFunction(op: "+")  //类型推断为函数类型: (Int, Int) -> Int
        print("p(a: 1, b: 2): \(p(1, 2))") // p(a: 1, b: 2): 3
        
        let m = someFunction(op: "*")  //类型推断为函数类型: (Int, Int) -> Int
        print("m(1, 2): \(m(1, 2))")   //m(1, 2): 2
        
        
        
        let p1 = someFunction1(op: "+") // (Int, Int) -> Int
        print("p1(1,2): \(p1(1,2))")    // p1(1,2): 3
        
        let m1 = someFunction1(op: "*") // (Int, Int) -> Int
        print("m1(1,2): \(m1(1,2))")    // m1(1,2): 2
        
        
        let p2 = someFunction2(op: "+")
        print("p2(1,2): \(p2(1,2))")  //p2(1,2): 3
        
        let m2 = someFunction2(op: "*")
        print("m2(1,2): \(m2(1,2))") //m2(1,2): 2
        
        
        let p3 = someFunction3(op: "+")
        print("p3(1,2): \(p3(1,2))")  //p3(1,2): 3
        
        let m3 = someFunction3(op: "*")
        print("m3(1,2): \(m3(1,2))") //m3(1,2): 2
        
        
        let p4 = someFunction4(op: "+")
        print("p4(1,2): \(p4(1,2))")  //p4(1,2): 3
        
        let m4 = someFunction4(op: "*")
        print("m4(1,2): \(m4(1,2))") //m4(1,2): 2
        
    }
    
    
    /*
     一个函数的返回值类型是：函数类型。
     函数嵌套
     */
    func someFunction(op: String) -> (Int, Int) -> Int {
        
        func plus(a: Int, b: Int) -> Int {
            return a + b
        }
        
        func mult(a: Int, b: Int) -> Int {
            return a * b
        }
        
        var result: (Int, Int) -> Int
        
        switch op {
        case "+":
            result = plus(a:b:)
        case "*":
            result = mult(a:b:)
        default:
            result = plus(a:b:)
        }
        
        return result
    }
    
    /*
     使用了闭包形式简化嵌套函数。
     闭包表达式运算结果是：函数类型。
     函数类型可以作为：参数、返回值、表达式。闭包也可以。
     */
    func someFunction1(op: String) -> (Int, Int) -> Int {
        var result: (Int, Int) -> Int
        
        switch op {
        case "+":
            result = { (a: Int, b: Int) in
                return a + b
            }
        case "*":
            result = { (a: Int, b: Int) in
                return a * b
            }
        default:
            result = { (a: Int, b: Int) in
                return a - b
            }
        }
        
        return result
    }
    
    
    /*
     借助Swift的类型推断，进行简化闭包，省去参数和返回值类型声明。
     */
    func someFunction2(op: String) -> (Int, Int) -> Int {
        var result: (Int, Int) -> Int
        
        switch op {
        case "+":
            result = { (a, b) in
                return a + b
            }
        case "*":
            result = { (a, b) in
                return a * b
            }
        default:
            result = { (a, b) in
                return a - b
            }
        }
        
        return result
    }
    
    /*
     简化闭包：闭包中只有一条语句，那么此语句只能是返回语句，可以省略return。
     */
    func someFunction3(op: String) -> (Int, Int) -> Int {
        var result: (Int, Int) -> Int
        
        switch op {
        case "+":
            result = { (a,b) in
                a + b
            }
            
        case "*":
            result = { (a, b) in
                a * b
            }
        default:
            result = { (a, b) in
                a - b
            }
        }
        
        return result
    }
    
    
    /*
     简化闭包：参数名称缩写功能。省略参数列表的定义。
     $0代表第一个参数，$1代表第二个参数。
     */
    func someFunction4(op: String) -> (Int, Int) -> Int {
        var result: (Int, Int) -> Int
        
        switch op {
        case "+":
            result = {
                $0 + $1
            }
            
        case "*":
            result = {
                $0 * $1
            }
            
        default:
            result = {
                $0 - $1
            }
        }
        
        return result
    }
}

