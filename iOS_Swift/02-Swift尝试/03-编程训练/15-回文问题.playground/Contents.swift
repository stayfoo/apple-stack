//: Playground - noun: a place where people can play

/*
 回文问题
 问题描述：
     回文就是正着读和反着读都一样的字符串。
     给定一个整数，判断该整数是否为回文。
 程序设计思路：
     第一，将整数转换为字符串；
     第二，将字符串转为字符数组，通过字符数组来判断是否符合回文的特点，假定数组长度为n，实际就是比较数组的第i个元素和第n-i个元素是否相等。比较数组第一个和最后一个元素是否相等，如果相等，就去除第一个和最后一个元素，继续比较。
 */

import UIKit

func judgePalindrome(number: Int) {
    let str = String(number)
    let halfCount = str.characters.count / 2
    var charArray = [Character]()
    var palindrome = true
    
    for char in str.characters {
        charArray.append(char)
    }
    
    for _ in 1...halfCount {
        if charArray.first != charArray.last {
            palindrome = false
            break
        }
        charArray.removeLast()
        charArray.removeFirst()
        if charArray.count == 1 {
            break
        }
    }
    
    if palindrome {
        print("\(number)是回文")
    }else {
        print("\(number)不是回文")
    }
}

judgePalindrome(number: 12321)
judgePalindrome(number: 12320)
judgePalindrome(number: 1221)
