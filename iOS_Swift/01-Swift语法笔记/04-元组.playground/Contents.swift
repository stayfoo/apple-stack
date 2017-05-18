//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, 元组 tuples"

//1. 定义元组
/*
 （1）元组(tuples)：把多个值组合成一个复合值。
 （2）元组内的值可以是任意类型,并不要求是相同类型。
 */

let http404Error = (404, "Not Found")
/*
 说明：
 （1）http404Error 的类型是 (Int, String) ，值是 (404, "Not Found")
 （2）元组把一个 Int  值和一个 String  值组合起来表示 HTTP 状态码的两个部分：一个数字 和一个人类可读的描述。
 （3）这个元组可以被描述为“一个类型为 (Int, String)  的元组”。
 */

//2. 分解元组
/*
 （1）可以将一个元组的内容分解(decompose)成单独的常量和变量。
 （2）如果你只需要一部分元组值,分解的时候可以把要忽略的部分用下划线( _ )标记；
 （3）可以通过下标来访问元组中的单个元素,下标从零开始；
 （4）可以在定义元组的时候给单个元素命名，给元组中的元素命名后, 可以通过名字来获取这些元素的值；
 */
let (statusCode, statusMessage) = http404Error
print("状态码是：\(statusCode)， 响应消息：\(statusMessage)")

let (justTheStatusCode, _) = http404Error
print("响应状态：\(justTheStatusCode)")

print("状态：\(http404Error.0), 消息：\(http404Error.1)")

let http200Status = (statusCode: 200, description: "OK")
print("状态：\(http200Status.statusCode), 信息：\(http200Status.description)")


/*
 作为函数返回值时,元组非常有用。
 元组在临时组织值的时候很有用,但是并不适合创建复杂的数据结构。
 如果你的数据结构并不是临时使用,请使用类或者结构体而不是元组。
 */


