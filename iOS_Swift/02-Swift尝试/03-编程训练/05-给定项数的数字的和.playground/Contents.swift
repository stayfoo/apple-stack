//: Playground - noun: a place where people can play

/*
 给定项数的数字的和
 问题描述：
     求给定项数的数字a的和，即 sum = a + aa + aaa + aaaa + ... + aaa....a 的值。
 程序设计思路：
     求给定项数的数字的和，其中项数n和数字a是外部输入的，也就是说这两项是给定的。
     求和分两步：
         一，求每一项的值； aaa = a * 100 + a * 10 + a
         二，将n项相加；
 */

import UIKit

func sumOfA(a: Int, numOfTerms: Int) {
    var numArray = [Int]()
    
    
    var sum = 0
    var curTerm = 0 //当前项
    
    var fractor = a // a  a0  a00  a000  a0000   a00000
    
    var i = 0
    while i < numOfTerms {
        curTerm = curTerm + fractor // a   aa   aaa   aaaa   aaaaa
        sum = sum + curTerm
        
        fractor = fractor * 10  // a0  a00  a000  a0000   a00000
        
        i += 1
        
        numArray.append(curTerm)
    }
    
    
    var desStr: String = ""
    
    for i in numArray {
        if i == numArray.last {
            desStr = desStr.appending("\(String(i)) = ")
        } else {
            desStr = desStr.appending("\(String(i)) + ")
        }
    }
    print("\(desStr) \(sum)")
}

sumOfA(a: 1, numOfTerms: 5)


