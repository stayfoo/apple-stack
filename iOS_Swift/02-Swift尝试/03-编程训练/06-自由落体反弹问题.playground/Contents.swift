//: Playground - noun: a place where people can play

/*
 自由落体反弹问题
 问题描述：
     一个球从h米高处自由落体，每次落地后都能反弹回上一次高度的一半，求第n次反弹的高度以及一共反弹的米数。
 程序设计思路：
     通过循环计算解决。
 */

import UIKit

func bounceUpCompute(h: Double, n: Int) -> (Double, Double){
    var sum = 0.0
    var theHeight = h
    var i = 0
    
    while i < n {
        theHeight = theHeight / 2
        sum += theHeight
        i += 1
    }
    return (theHeight,sum)
}

bounceUpCompute(h: 20, n: 2)

