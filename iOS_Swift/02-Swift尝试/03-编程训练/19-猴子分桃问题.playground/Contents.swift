//: Playground - noun: a place where people can play

/*
 猴子分桃问题
 问题描述：
     树底下有一堆桃子，有n（n>1）只猴子。第一只猴子把这堆桃子平均分为n份，多了一个，这只猴子把多的一个扔掉，拿走其中的一份。第二只猴子又把剩下的桃子平均分为n份，又多了一个，它同样把它扔掉，并拿走其中的一份。其他猴子也是如此，直到第n只猴子还是分成n份，又多了一个。请问一共有多少个桃子？
 程序设计思路：
     首先，n个猴子都做了同样的动作，循环。
     其次，假设有5只猴子，每一只猴子都是将桃子分成5份，再扔掉一个，说明当时桃子数减1可以被5整除。
     桃子数可能取多个值，可以值考虑一个范围内符合条件的桃子数，存储到一个数组中。
 */

import UIKit

func monkeyDividePeach(numOfMonkey: Int) -> [Int] {
    var peachNum = 0  //当前桃子数
    var flag: Bool    //是否满足分桃条件
    var peachSum = [Int]() // 可能的桃子数
    
    for i in 1...8000 {
        flag = true
        peachNum = i
        
        for count in 1...numOfMonkey {
            if (peachNum - 1) % 5 != 0 {
                flag = false
                break
            }
            peachNum = (peachNum - 1) / 5
            if peachNum == 1 {
                if count == numOfMonkey {
                    flag = true
                }else {
                    flag = false
                    break
                }
            }
        }
        
        if flag {
            print(i)
            peachSum.append(i)
        }i
    }
    
    return peachSum
}

monkeyDividePeach(numOfMonkey: 5)


