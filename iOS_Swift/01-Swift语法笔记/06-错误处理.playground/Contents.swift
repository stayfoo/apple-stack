//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, 错误处理 error handling"

//1. 错误处理
/*
 可选类型：运用值的存在与缺失，来表达函数的成功与失败。
 错误处理：可以推断失败的原因，并传播至程序的其他部分。
 
 */

//当一个函数遇到错误条件,它能报错。调用函数的地方能抛出错误消息并合理处理。

func canThrowAnError() throws {
    //这个函数有可能抛出错误
}

//一个函数可以通过在声明中添加 throws 关键词来抛出错误消息。
//当你的函数能抛出错误消息时, 应该在表达式中前置 try 关键词。

do {
    try canThrowAnError()
    //没有错误消息抛出
} catch {
    //有一个错误消息抛出
}

//一个 do 语句创建了一个新的包含作用域,  使得错误能被传播到一个或多个 catch 从句。



