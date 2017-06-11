//: Playground - noun: a place where people can play

/*
 问题描述：
     用1-6的数字可以组成多少个不同且不含重复数字的三位数？
 程序设计思路：
     从1-6的6个数字中，取出3个数字来组成三位数，这3个数不重复即可。
     可以通过3层循环穷举各种组合情况，并通过判断语句剔除重复的情况。
 */

import UIKit

func threeBitsNumber(){
    var threeNumber: Int
    var numbers = [Int]()
    
    for i in 1...6 {
        for j in 1...6 {
            for k in 1...6 {
                if (i != j) && (i != k) && (k != j) {
                    threeNumber = i * 100 + j * 10 + k
                    numbers.append(threeNumber)
                }
            }
        }
    }
    
    print("共有：\(numbers.count)个")
    
    var tempstr: String = ""
    var i = 0
    for item in numbers {
        i += 1
        tempstr = "\(tempstr) \(item) "
        if i == 5 {
            print(tempstr)
            tempstr = ""
            i = 0
        }
    }
}

threeBitsNumber()

