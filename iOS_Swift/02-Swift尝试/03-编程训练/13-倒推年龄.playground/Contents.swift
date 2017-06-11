//: Playground - noun: a place where people can play

/*
 倒推年龄
 问题描述：
     有n个人坐一起。问第n个人多少岁，他说比第n-1个人大2岁。问第n-1个人岁数，他说比第n-2个人大2岁。....
     一直问到第一个人，第一个人说他今年m岁。 请根据 n 和 m 的值计算出第n个人的岁数。
 程序设计思路：
     第n个人和第n-1个人的年龄差总是2岁。
     从第一个人的岁数，通过不断加2的方式，就能不断往前推断前面的人的岁数，一直推断到第n个人的岁数。
 */

import UIKit

func ageProblem(age: Int, n: Int) {
    var lastOne = age
    for _ in 2...n {
        lastOne += 2
    }
    print("最后一个人的年龄是：\(lastOne)")
}

ageProblem(age: 18, n: 10)
