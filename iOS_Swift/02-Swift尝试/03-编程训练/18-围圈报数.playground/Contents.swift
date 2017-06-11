//: Playground - noun: a place where people can play

/*
 围圈报数
 问题描述：
     n个人围成一圈，从第一个人开始一次报数。第1个人报1，第二个人报2，第三个人报3，第4个人再从1开始报数.....每次有人报到3，就将其剔除出圈子，直到最后只剩一个人，请问剩下的那个人在开始报数前排在第几个？
 程序设计思路：
     n个人围成圈的报数问题，建立模型，一个布尔型一维数组。
     数组下标表示每个人在报数前的位置，数组中每个元素的布尔值可以表示该人是否报到3。
     初始时，数组中的每一个元素都应该为true，表示都没有报道3.每当有人报到3，就将其标识为false。
     每次报道时，只有为true的元素才能参与，每三个数就会少一个true的元素，如此继续，最后剩下的一个为true的元素就是要求的元素，而这个元素的下标就是它在报数前的位置。
 */

import UIKit

func circle3(num: Int) {
    var theArray = [Bool]() //建立模型
    var theRestNum = num // 圈中人数
    var index = 0  //每一圈计数的位置
    var count3 = 0 // 计数
    
    for _ in 0...(num - 1) {
        theArray.append(true)
    }
    
    while theRestNum > 1 {
        if theArray[index] == true {
            count3 += 1
        }
        if count3 == 3 {
            count3 = 0
            theArray[index] = false
            theRestNum -= 1
        }
        index += 1
        if index == num { //数完一圈
            index = 0
        }
    }
    for i in 0...(num-1) {
        if theArray[i] == true {
            print(i)
        }
    }
}

circle3(num: 12)

