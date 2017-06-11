//: Playground - noun: a place where people can play

/*
 求完全平方数
 问题描述：
     根据给定的年月日信息，判断这一天为一年中的第几天。
 程序设计思路:
     第一，根据年来确定该年是否为润年。能被400整除或者被4整除但不能被100整除的年份都是闰年。
         闰年2月29天。
     第二，根据月份来计算已经过去的几个月中的天数和。已经过去的月份，给定的月份减1。
 */

import UIKit

func theDayOfTheYear(year: Int, month: Int, day: Int) -> Int {
    var leapYear = false // 不是闰年
    var thedays = day
    var totalday = 0 //一年总共多少天
    if month < 1 && month > 12 {
        print("month输入错误")
        return 0
    }
    if day > 31 && day < 1 {
        print("day输入错误")
    }
    if (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0) {
        leapYear = true // 闰年
    }
    for i in 1...month-1 {
        switch i {
        case 1,3,5,7,8,10,12:
            thedays += 31
        case 4,6,9,11:
            thedays += 30
        case 2:
            if leapYear {
                thedays += 29
            } else {
                thedays += 28
            }
        default:
            print("错误选择")
        }
    }
    
    if leapYear {
        totalday = 7 * 31 + 4 * 30 + 29
    }else{
        totalday = 7 * 31 + 4 * 30 + 28
    }
    
    print("\(year)年总共\(totalday)天,\(year)年\(month)月\(day)日是\(year)年的第\(thedays)天")
    
    return thedays
}

theDayOfTheYear(year: 2017, month: 6, day: 11)
