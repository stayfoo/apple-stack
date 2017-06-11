//: Playground - noun: a place where people can play

/*
 数字加密问题
 问题描述：
     某单位用公用电话线路传递数据。数据格式为4位整数。
     传递过程中进行加密，具体的加密算法是：4位数的每个数字先加上5，再除以10，得到的余数代替原来的数字，组成一个新的4位数。然后该4位数的第一位和第四位进行交换，第二位和第三位进行交换。给定一个4位整数，要进行加密。
 程序设计思路：
     对一个4位数进行加密，首先需要将4个数字分离出来，进行加密处理后再合并成一个新的4位整数即可。
 */

import UIKit

func encryptNumbers(originNumber: Int) -> Int {
    var bitArray = [Int]()
    var temp: Int
    var encrypted: Int
    
    bitArray.append(originNumber / 1000)
    bitArray.append(originNumber / 100 % 10)
    bitArray.append(originNumber / 10 % 10)
    bitArray.append(originNumber % 10)
    
    for i in 0...3 {
        bitArray[i] += 5
        bitArray[i] %= 10
    }
    
    temp = bitArray[0]
    bitArray[0] = bitArray[3]
    bitArray[3] = temp
    
    temp = bitArray[1]
    bitArray[1] = bitArray[2]
    bitArray[2] = temp
    
    encrypted = bitArray[0] * 1000 + bitArray[1] * 100 + bitArray[2] * 10 + bitArray[3]
    
    return encrypted
}

encryptNumbers(originNumber: 2677)


