//: Playground - noun: a place where people can play

/*
 求质数
 问题描述：
     质数定义：在大于1自然数中，除了1和它本身以外，不再有其他因数的数。
     要求：计算一个数值范围内有多少质数，并将其打印出来。
 程序设计思路：
     求一个数值范围内的质数可以分两步：
         第一步，判断一个数是否为质数；
             用1到这个数之间的所有数（不包括1和这个数本身），作为除数与这个数相除，
             如果余数为0，说明该数有因数；如果没有因数，说明该数为质数。
         第二步，遍历范围，一一判断是否为质数。
 */

import UIKit

/// 判断一个数是否为质数
///
/// - Parameter number: 输入数字
/// - Returns: false：不是质数。ture：是质数
func primeNumber(number: Int) -> Bool {
    var flag = true
    
    if number == 1 || number == 2 {
        return true
    }
    
    for i in 2..<number {
        if number % i == 0 { // 不是质数
            flag = false
            return flag
        } else {
            flag = true
        }
    }
    
    return flag
}

/// 列出一个范围内的质数
///
/// - Parameters:
///   - startNumber: 范围开始
///   - endNumber:   范围结束
func primeList(startNumber: Int, endNumber: Int) {
    var primeArray = [Int]()
    
    for item in startNumber...endNumber {
        if primeNumber(number: item) {
            primeArray.append(item)
        }
    }
    print("\(startNumber)和\(endNumber)之间质数有\(primeArray.count)个：")
    for item in primeArray {
        print(item)
    }
}
primeList(startNumber: 3, endNumber: 15)


