//: Playground - noun: a place where people can play

/*
 统计字符串中各类字符个数
 问题描述：
     给定一个字符串，统计字符串中大小写字母、数字、空格及其他未识别类型字符的个数。
 程序设计思路：
     遍历字符串，比较字符串中每一个字符和各类字符的范围值。
 */

import UIKit

func judgeAString(theString: String) {
    var lowerCase = 0
    var upperCase = 0
    var digital = 0
    var space = 0
    var others = 0
    
    for i in theString.characters {
        if (i >= "a") && (i <= "z") {
            lowerCase += 1
        } else if (i >= "A") && (i <= "Z") {
            upperCase += 1
        } else if (i >= "0") && (i <= "9") {
            digital += 1
        } else if (i == " ") {
            space += 1
        } else {
            others += 1
        }
    }
    
    print("小写字母：\(lowerCase)")
    print("大写写字母：\(upperCase)")
    print("数字：\(digital)")
    print("空格：\(space)")
    print("其他：\(others)")
}


judgeAString(theString: " www.mengyueping.COM.110 ")



