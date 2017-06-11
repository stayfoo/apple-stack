//: Playground - noun: a place where people can play

/*
 求5x5矩阵对角线之和
 问题描述：
     给一个任意整型数组成的5x5矩阵，求对角线上的整数的和。
         1  2  3  4  5
         6  7  8  9  10
         11 12 13 14 15
         16 17 18 19 20
         21 22 23 24 25
     对角线：1 7 13 19 25
 程序设计思路：
     第一，如何保存这个5x5的矩阵；  二维整型数组
     第二，怎么找到对角线上的整数。 对角线上的整数的下标中行数和列数都相等。
 */

import UIKit

func sumOfDiagonal(rectangle: [[Int]]) {
    var sum = 0
    let rect = rectangle
    for i in 0...4 {
        for j in 0...4 {
            if i == j {
                sum += rect[i][j]
            }
        }
    }
    print("对角线和：\(sum)")
}

let rect = [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15],[16,17,18,19,20],[21,22,23,24,25]]

sumOfDiagonal(rectangle: rect)
