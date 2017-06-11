//: Playground - noun: a place where people can play

/*
 求水仙花数
 问题描述：
     求指定范围的水仙花数，并打印出来。
     水仙花数：一个三位数，它的3个组成数字的立方和等于它本身。
 程序设计思路：
     分解三位数的每个数字，然后进行立方和的运算；
     三位数的范围是100~999；
     遍历给定范围内的所有三位数，立方和判断。
 */

import UIKit


/// 传入数字的各个位数字立方和
///
/// - Parameter withNumber: 传入三位数数字
/// - Returns: 立方和
func sumOfCubes(number withNumber: Int) -> Int{
    let first = withNumber / 100
    let second = withNumber / 10 % 10
    let three = withNumber % 10
    
    func cubes(_ num: Int) -> Int {
        return num * num * num
    }
    
    return (cubes(first) + cubes(second) + cubes(three))
}


/// 给定范围，确定水仙花数
///
/// - Parameters:
///   - fromNumber: 范围开始
///   - toNumber: 范围结束
func daffodil(begin fromNumber: Int, end toNumber: Int) {
    var daffodilArray = [Int]()
    for i in fromNumber...toNumber {
        if sumOfCubes(number: i) == i {
            daffodilArray.append(i)
        }
    }
    
    print("\(fromNumber)到\(toNumber)的水仙花数有\(daffodilArray.count)个：")
    for item in daffodilArray {
        print(item)
    }
}

daffodil(begin: 100, end: 999)

