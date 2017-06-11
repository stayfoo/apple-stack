//: Playground - noun: a place where people can play

/*
 猴子吃桃问题
 问题描述：
     猴子摘下了若干个桃子。
     第一天吃了一半后，不过瘾，又多吃了一个。
     第二天吃了剩下的一半后，不过瘾，又多吃了一个。
     此后，每天如此，均吃了剩下的一半多一个。
     到某一天时，发现只剩下了一个桃子。
     需要实现：已知第几天只剩下一个桃子，求猴子共摘了多少桃子。
 程序设计思路：
     倒推法，最后一天剩下一个桃子，那么前一天，吃了一半后，又多吃了一个，
     由此可以判定最后一个桃子加上多吃的一个桃子等于前一天的一半。
     由此可以循环反推桃子的总数，而循环的次数则取决于一共吃了多少天。
 */

import UIKit

func monkeyEatPeach(days: Int) {
    var peachNum = 1
    for _ in 1...days {
        peachNum = (peachNum + 1) * 2
    }
    print("桃子数量：\(peachNum) 个")
}

monkeyEatPeach(days: 8)
