//: Playground - noun: a place where people can play

/*
 倒序打印一个正整数
 问题描述：
     给定一个正整数，逆序打印出来。
 程序设计思路：
     第一，将这个正整数转化为一个字符串；
     第二，遍历这个字符串，对其出现的顺序进行调整。
 */

import UIKit

func numberReversed(number: Int) {
    var numStr: String
    var reversedStr = ""
    
    numStr = String(number)
    for i in numStr.characters {
        reversedStr = String(i) + reversedStr
    }
    print("输入：\(number)")
    print("输出：\(reversedStr)")
}

numberReversed(number: 987654)

