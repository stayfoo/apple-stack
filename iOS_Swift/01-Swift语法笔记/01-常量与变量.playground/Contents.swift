//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, 常量 let 与 变量 var"


//1. 声明一个常量和变量
let maxNumberOfLoginAttempts = 10
var currentLoginAttempt = 0
/*
 解释： 
 声明一个名字是 maxNumberOfLoginAttempts 的新常量, 并给它一个值 10 。
 声明一个名字是 currentLoginAttempt 的变量并将它的值初始化为 0 。
 */


//2. 常量名和变量名
/*
 （1）可以用任何你喜欢的字符作为常量和变量名,包括 Unicode 字符；
 （2）常量与变量名不能包含数学符号,箭头,保留的(或者非法的)Unicode 码位,连线与制表符。
 （3）也不能以数字开 头,但是可以在常量与变量名的其他地方包含数字。
 （4）如果你需要使用与 Swift 保留关键字相同的名称作为常量或者变量名,你可以使用反引号(`)将关键字包围的方式将其作为名字使用。
     无论如何,你应当避免使用关键字作为常量或变量名,除非你别无选择。
 （5）一旦你将常量或者变量声明为确定的类型,你就不能使用相同的名字再次进行声明,或者改变其存储的值的类型。同时,你也不能将常量与变量进行互转。
 */
let 你 = "jj"
let π = "3.14159"

let `let` = "kk" //使用关键字作为变量名
`let`

//3. 赋值
/*
 （1）如果你在声明常量或者变量的时候赋了一个初始值,Swift可以推断出这个常量或者变量的类型.
 （2）如果没有赋初值，需要对类型进行标注。
 （3）常量的值一旦被确定就不能更改了。
 */
var myVariable = 42
myVariable = 50
myVariable = 33

let myConstant = 33
//myConstant = 34

let aa: Double //变量声明 类型标注
//let bb
/*
 如果不能推断变量类型：没有赋值，也没有标注类型， 编译器就会直接报错：
 error: type annotation missing in pattern
 let bb
 ^
 */

let imlicitInteger = 90
let imlicitDouble = 90.0

let explicitDouble: Double = 90   //类型标注
let tVariable: Float = 44

//4. 类型转换
/*
 （1）值永远不会被隐式转换为其他类型。
 （2）如果你需要把一个值转换成其他类型,请显式转换。
 
 把值转换成字符串的方法: 
    第一种：\(值)  把值写到括号中,并且在括号之前写一个反斜杠。
    第二种： String()
 */

let label = "The"
let width = 99
let labelWidth = label + String(width)

let apples = 3
let oranges = 6
let appleSummary = "I have \(apples) apples"
let fruitSummary = "I have \(apples + oranges) pieces of fruit"

//5. 输出
/*
 print函数：
 public func print(_ items: Any..., separator: String = default, terminator: String = default)
 */
print(apples,oranges,appleSummary,fruitSummary) //默认 separator 是空格 " "  ; terminator是换行 \n
print(apples,oranges,appleSummary,fruitSummary,separator:", ")
print(apples,oranges,appleSummary,fruitSummary,separator:", ",terminator:";")
print(apples,oranges)


//6. 注释
/*
 嵌套多行注释： 可以快速方便的注释掉一大段代码, 即使这段代码之中已经含有了多行注释块。
 
    /*
        /**/
    */
 */
