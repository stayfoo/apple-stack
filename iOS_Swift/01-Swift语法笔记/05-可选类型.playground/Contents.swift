//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, 可选类型， optionals"

//1. 可选类型
/*
 使用可选类型(optionals)来处理值可能缺失的情况。
 可选类型表示:
     有值,等于 x
  或者
     没有值
 
 
有点像 Objective-C 中的一个特性：
     （1）对象的一个方法要不返回一个对象要不返回 nil , nil 表示“缺少一个合法的对象”。这只对对象起作用。
     （2）结构体,基本的 C 类型或者枚举类型不起作用。对于这些类型,Objective-C 方法一般会返回一个特殊值(比如 NSNotFound )来暗示值缺失。
     这种方法假设方法的调用者知道并记得对特殊值进行判断。
 
优点：
Swift 的可选类型可以让你暗示任意类型的值缺失,并不需要一个特殊值。
 */


let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// 类型推断为： "Int?"  可选类型
/*
 解释：
    Int() 构造器，可以将一个 String 值转换为一个 Int 值。
    然而只有字面量是数字的字符串可以转换成一个整数。
    
    所以，返回的是一个可选类型Int（Int?），而不是一个Int.
    也就是说：可能包含 Int 值，也可能不包含值。（只能是Int值，或什么都没有）
 */


//2. nil
/*
 （1）可以给可选类型变量赋值为 nil 来表示它没有值。
 （2）nil 不能用于非可选的常量和变量。
 如果你的代码中有常量或者变量需要处理值缺失的情况,请把它们声明成对应的可选类型。
 （3）如果你声明一个可选常量或者变量但是没有赋值,它们会自动被设置为 nil 。
 */
var serverResponseCode: Int? = 404 //变量包含一个可选的 Int 值 404
serverResponseCode = nil  //变量现在不包含值

var surveyAnswer: String? //被自动设置为 nil


/*
 Swift 的 nil 和 Objective-C 中的 nil 并不一样。
 （1）在 Objective-C 中, nil 是一个指向不存在对象的指针。
 （2）在 Swift 中, nil 不是指针, 它是一个确定的值, 用来表示值缺失。
     任何类型的可选状态都可以被设置为 nil ,不只是对象类型。
 */


//3. if 语句 以及 强制解析
/*
 （1）可以使用 if 语句和 nil 比较来判断一个可选值是否包含值。
 使用 “相等”(==) 或 “不等” ( != ) 来执行比较。
 
 （2）可选值的强制解析(forced unwrapping)： 当确定可选类型确实包含值之后, 可以在可选的名字后面加一个感叹号( ! )来获取值。
     这个惊叹号表示“我知道这个可选有值,请使用它。”
 
 （3）使用 ! 来获取一个不存在的可选值会导致运行时错误。
     使用 ! 来强制解析值之前,一定要确定可选包含一 个非 nil 的值。
 */
if convertedNumber != nil {
    print("变量有值：\(convertedNumber)")  //Optional(123)
    print("变量有值：\(convertedNumber!)") //123
}


//4. 可选绑定
/*
 （1）使用可选绑定(optional binding)：用来判断可选类型是否包含值,如果包含就把值赋给一个临时常量或者变量。
 （2）可选绑定可以用在 if 和 while 语句中,  
       这条语句不仅可以用来判断可选类型中是否有值, 
       同时可以将可选类型中的值赋给一个常量或者变量。
 
 可选可以通过 if 语句来判断是否有值,如果有值的话可以通过可选绑定来解析值。
 */
if let actualNumber = Int(possibleNumber) {
    print("\(Int(possibleNumber)) 中包含一个 Int 值： \(possibleNumber)")
}
/*
 解释：
 （1）如果 Int(possibleNumber) 返回的可选 Int 包含一个值，
    创建一个叫做 actualNumber 的新常量并将可选包含的值赋给它。
    
    如果包含值，就是true 。
    如果可选绑定的值为 nil 就是 false。
 
 （2）如果转换成功, actualNumber 常量可以在 if 语句的第一个分支中使用。
    它已经被可选类型 包含的值初始化过, 所以不需要再使用 ! 后缀来获取它的值。  在这个例子中,actualNumber 只被用来输出转换结果。
*/

/*
 可以包含多个可选绑定或多个布尔条件在一个 if 语句中,只要使用逗号分开就行。
 
 只要有任意一个可选绑定的值为 nil, 或者任意一个布尔条件为 false, 则整个if条件判断为false, 这时你就需要使用嵌套 if 条件语句来处理
 */
if let firstNumber = Int("4"),let secondNumber = Int("42"),firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}


//5. 隐式解析可选类型
/*
 解决问题场景：
    有时候在程序架构中, 第一次被赋值之后, 可以确定一个可选类型总会有值。
    在这种情况下,每次都要判断和解析可选值是非常低效的,因为可以确定它总会有值。
 
 这种类型的可选状态被定义为隐式解析可选类型(implicitly unwrapped optionals)。 把想要用作可选的类型的后面的问号( String? )改成感叹号( String! )来声明一个隐式解析可选类型。
 
 使用：
    当可选类型被第一次赋值之后就可以确定之后一直有值的时候,隐式解析可选类型非常有用。
    隐式解析可选类型 主要被用在 Swift 中类的构造过程中。
 
 本质：
    一个隐式解析可选类型其实就是一个普通的可选类型,
    但是可以被当做非可选类型来使用,
    并不需要每次都使用解析来获取可选值。
*/
//展示了可选类型 String 和隐式解析可选类型 String 之间的区别:
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! //需要感叹号来获取值

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString  //不需要感叹号

/*
 可以把隐式解析可选类型 当做一个可以自动解析的可选类型。
 只是声明的时候把感叹号放到类型的结尾, 而不是每次取值的可选名字的结尾。
 
 如果你在隐式解析可选类型没有值的时候尝试取值,会触发运行时错误。
 和你在没有值的普通可选类型后面加一个惊叹号一样。
 */
//let aaa: String?
//let bbb:String!
//aaa = nil
//bbb = nil-
//let ccc = aaa
//let ddd = bbb


//仍然可以把隐式解析可选类型当做普通可选类型来判断它是否包含值:

if assumedString != nil {
    print(assumedString)
}

//也可以在可选绑定中使用 隐式解析可选类型 来检查并解析它的值:

if let definiteString = assumedString {
    print(definiteString)
}

/*
 注意：
    （1）如果一个变量之后可能变成 nil 的话请不要使用隐式解析可选类型。
    （2）如果你需要在变量的生命周期中判断是否是 nil 的话, 请使用普通可选类型。
*/






