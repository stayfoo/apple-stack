//: Playground - noun: a place where people can play

/*
 求分数数列的和
 问题描述：
     有一个分数数列： 2/1, 3/2, 5/3, 8/5, 13/8, 21/13, ..., 求这个分数数列前n项的和。
 程序设计思路：
     分析规律，求出每一项，循环将前n项的分数进行累加。
     从第二个分数开始，每一个分数的分母都是前一个分数的分子，分子是前一个分数的分子分母的和。
 */

import UIKit

func sumOfFractionSeries(n: Int) {
    var numerator = 2.0   //分子
    var denominator = 1.0 //分母
    var temp = 0.0
    var sum = 2.0
    var resultStr = "2/1"
    
    for _ in 2...n {
        temp = numerator
        numerator += denominator
        denominator = temp
        sum += numerator / temp
        resultStr = resultStr + "+ \(numerator)/\(temp)"
    }
    print("\(resultStr) = \(sum)")
}

sumOfFractionSeries(n: 8)

