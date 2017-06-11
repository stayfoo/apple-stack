//: Playground - noun: a place where people can play

/*
 折半查找
 问题描述：
     给定一个任意长度的整型数组，要求用折半查找的方法判断该数组中是否存在一个给定的整数。
 程序设计思路：
     表中元素按升序排列，将表中间位置记录的数值与要查找的数值比较，如果两者相等，则查找成功；否则利用中间位置记录将表分成前、后两个子表，如果中间位置记录的数值大于查找数值，则进一步查找前一个字表，否则进一步查找后一个字表。重复过程，满足条件，查找成功，或直到子表结束，查找失败。
 */

import UIKit

/// 折半查找
func binarySearch(theArray: [Int], theNumber: Int) -> Bool {
    var result = false
    var lo = 0    //下标尺
    var hi = theArray.count - 1 //上标尺
    var mid: Int  //中间标尺
    
    while lo <= hi {
        mid = lo + (hi - lo) / 2
        if theNumber > theArray[mid] {
            lo = mid + 1
        } else if theNumber < theArray[mid] {
            hi = mid - 1
        } else {
            result = true
            break
        }
    }
    
    return result
}

let theArr = [23,333,567,2,34,66,90,265]
let sortedArr = theArr.sorted()

binarySearch(theArray: sortedArr, theNumber: 90)

