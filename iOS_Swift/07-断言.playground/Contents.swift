//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, 断言"

//1. 断言
/*
 可选类型：可以判断值是否存在,你可以在代码中优雅地处理值缺失的情况。
 
 断言场景：
    在某些情况下,如果值缺失或者值并不满足特定的条件,代码可能没办法继续执行。
    这时,你可以在你的代码中触发一个断言 (assertion) 来结束代码运行，并通过调试来找到值缺失的原因。
 */


//2. 使用断言进行调试

/*
断言会在运行时判断一个逻辑条件是否为 true 。
 
可以使用断言来保证在运行其他代码之前, 某些重要的条件已经被满足。
 
如果条件判断为 true ,代码运行会继续进行; 
如果条件判断为 false ,代码执行结束,你的应用被终止。
 

使用全局 assert(_:_:file:line:) 函数来写一个断言。
向这个函数传入一个结果为 true 或者 的表达式以及一条信息, 当表达式的结果为 false 的时候这条信息会被显示。
如果不需要断言信息,可以省略。
*/

//let age = -3
let age = 3
assert(age >= 0, "A person's age cannot be less than zero")
/*
 解释：
     只有 age >= 0 为 true 的时候, 代码才会继续执行。
     如果 age >= 0 为 false , 断言被触发,终止应用。
*/

/*
 注意:
    当代码使用优化编译的时候,断言将会被禁用, 
    例如：在 Xcode 中, 使用默认的 target Release 配置选项来 bu ild 时,断言会被禁用。
 */


//3. 何时使用断言
/*
 断言的适用情景:
 （1）整数类型的下标索引被传入一个自定义下标实现,但是下标索引值可能太小或者太大。
 （2）需要给函数传入一个值,但是非法的值可能导致函数不能正常执行。
 （3）一个可选值现在是 nil ,但是后面的代码运行需要一个非 nil 值。
 
 注意:
 断言可能导致应用终止运行, 所以你应当仔细设计你的代码来让非法条件不会出现。
 然而,在你的应用发布之前,有时候非法条件可能出现,这时使用断言可以快速发现问题。
*/



/*
 
 */









