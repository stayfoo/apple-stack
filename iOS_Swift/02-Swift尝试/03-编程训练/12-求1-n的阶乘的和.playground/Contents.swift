//: Playground - noun: a place where people can play

/*
 求1-n的阶乘的和
 问题描述：
     求：1! + 2! + ...+ n!
 程序设计思路：
     一个正整数的阶乘，所有小于等于这个数的正整数的乘积。
     先求每一项阶乘的值，再累加。
 
 递归方法求阶乘：
     递归：自己调用自己。第一，子问题和原问题是相同的事情，且更加简单；第二，不能无限制地调用自己，必须有一个递归出口。
     求出某一项的阶乘，n!, 转化(n-1)!, 往前推。出口： 1! = 1
 */

import UIKit

func sumOfFactorial(n: Int) {
    var sum = 1
    var f = 1   // 每一项阶乘的值
    var str = "1!"
    
    for i in 2...n {
        f *= i
        sum += f
        str = "\(str) + \(i)!"
    }
    print(str + "=\(sum)")
}

sumOfFactorial(n: 3)



/// 递归调用
func factorial(n: Int) -> Int {
    var result = 0
    if n == 1 {
        result = 1
    } else {
        result = n * factorial(n: n-1)
    }
    print("\(n)! = \(result)")
    return result
}

factorial(n: 3)



