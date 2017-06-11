//: Playground - noun: a place where people can play

/*
 求完全平方数
 问题描述：
     求一定范围内的数，它满足加上100和268均为完全平方数。
     完全平方数就是一个数正好是别的数的平方。
 程序设计思路：
     判断一个数是否为平方数，可以对其开方后再对1取模，如果为0，说明正好是一个数的平方，开方后没有小数部分。
 */

import UIKit

func squareNumber(scope: Double) {
    var r1: Double
    var r2: Double
    var strArr1: [String.SubSequence]
    var strArr2: [String.SubSequence]
    var i = 0.0
    
    while i < scope {
        r1 = sqrt(i + 100)
        r2 = sqrt(i + 268)
        strArr1 = String(format: "%f", r1).split(separator: ".")
        strArr2 = String(format: "%f", r2).split(separator: ".")
        
        
//        print("\(strArr1[1])   \(strArr2[1])")
        if (strArr1[1] == "000000") && (strArr2[1] == "000000") {
            print(i)
        }
        i += 1
    }
}

squareNumber(scope: 1000.0)
