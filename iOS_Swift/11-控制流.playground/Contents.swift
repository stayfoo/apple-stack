//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, 控制流：循环、条件、控制转移"

//1. for-in 循环
/*
 遍历区间  ...  ..<
 遍历数组
 遍历字典 （每项以元组的形式返回）
 
 */


// 打印 5*5 乘法表
for index in 1...5 {
// index 是一个每次循环遍历开始时,被自动赋值的常量。
// index 在使用前不需要声明,只需要将它包含在循环的声明中,就可以对其进行"隐式声明",而无需使用 let 关键字声明。
    print("\(index) times 5 is \(index * 5)")
}


let base = 3
let power = 10
var answer = 1
for _ in 1...power { //可以使用下划线( _ )替代变量名来忽略区间序列内每一项的值
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")



let names = ["Anna", "Alex", "Tom"]
for name in names {
    print("Hello, \(name)")
}


let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}



//2.  While 循环
/*
 使用场景：在第一次迭代前,迭代次数未知的情况。
 
 两种形式：
    while  ： 每次在循环开始时计算条件是否符合
     while condition {
        code
     }
     
 
    repeat-while ：每次在循环结束时计算条件是否符合。
        在判断循环条件之前,先执行一次循环的代码块。 和其他语言中的 do-while 循环是类似的。
     repeat {
        code
     } while condition
 
*/



//3.  if 条件语句
/*
    if condition {
        code
    }
    
 
    if condition {
        code
    } else {
        code
    }

 
 
    if condition {
        code
    } else if condition {
        code
    }
 
*/



//4.  switch 条件语句
//4.1 基本使用
/*
    更适用于条件较复杂、有更多排列组合的时候。
    在需要用到模式匹配(pattern-matching)的情况下,switch会更有用。
    
 
    （1）保证 swith 语句的完备性；
 
 
    （2）不存在隐式的贯穿；（不需要显式地使用 break ）
    （3）每一个 case 分支都必须包含至少一条语句，否则编译器报错；（避免了意外地从一个 case 分支贯穿到另外一个,使得代码更安全、也更直观）
 
    （4）case 分支的模式可以是一个值的区间。
    （5）case 分支的模式可以是元组
 
 
 注意: 虽然在Swift中 break 不是必须的, 但你依然可以在 case 分支中的代码执行完毕前使用 break 跳出。
 */
let someCharacter: Character = "z"
switch someCharacter {
case "a","A":   //同时匹配
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:  // 保证了swith语句的完备性。
    print("Some other character")
}


let approximateCount = 62
let countedThings = "books"
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")


let somePoint = (1, 1)
switch somePoint {
case (0, 0): // 原点
    print("(0,0) is at the origin")
case (_, 0): // x轴
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _): // y轴
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside the box")
}
/*
 点(0, 0)可以匹配所有四个 case。
 但是,如果存在多个匹配,那么只会执行第一个被匹配到的 case 分支。
 考虑点(0, 0)会首先匹配 case (0, 0) ,因此剩下的能够匹配的分支都会被忽视掉。
 */



//4.2  值绑定 (Value Bindings)
/*
 （1）case 分支允许将匹配的值绑定到一个临时的常量或变量
 （2）值绑定的常量或变量可以在 case 分支体内使用
 （3）匹配的值在 case 分支体内, 与临时的常量或变量绑定
 */
let anotherPoint = (0, 2)
switch anotherPoint {
case (let x, 0): // x 轴
    print("on the x-axis with an x value of \(x)")
case (0, let y): // y 轴
    print("on the y-axis with a y value of \(y)")
case let (x, y): // 其他
    print("somewhere else at (\(x), \(y))")
}
/*
 解释：
    （1）这三个 case 都声明了常量 x 和 y 的占位符,用于临时获取元组 anotherPoint 的一个或两个值。
    （2）第一个 case —— case (let x, 0) 将匹配一个纵坐标为 0 的点,并把这个点的横坐标赋给临时的常量 x 。
    （3）第二个 case —— case (0, let y) 将匹配一个横坐标为 0 的点,并把这个点的纵坐标赋给临时的常量 y 。
    （4）一旦声明了这些临时的常量,它们就可以在其对应的 case 分支里使用。
    （5）最后一个 case —— case let(x, y) 声明了一个可以匹配余下所有值的元组。这使得 switch 语句完备性。
 */



//4.3  Where
/*
 case 分支的模式可以使用 where 语句来判断额外的条件。
 */
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y: // 第一、三象限 对角线
    print("(\(x),\(y)) is on the line x == y")
case let (x, y) where x == -y: // 第二、四象限 对角线
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):   //其他
    print("(\(x), \(y)) is just some arbitrary point")
}
/*
 解释：
 （1）这三个 case 都声明了常量 x 和 y 的占位符,用于临时获取元组 yetAnotherPoint 的两个值。
 （2）这两个常量被用作 where 语句的一部分,从而创建一个动态的过滤器(filter)。
 （3）当且仅当 where 语句的条件为 true 时,匹配到的 case 分支才会被执行。
 （4）由于最后一个 case 分支匹配了余下所有可能的值, switch 语句的完备性。
 */


//4.4  复合匹配
/*
 （1）当多个条件可以使用同一种方法来处理时,可以将这几种可能放在同一个 case 后面,并且用逗号隔开。
 （2）当case后面的任意一种模式匹配的时候,这条分支就会被匹配。
 （3）如果匹配列表过长,还可以分行书写。
 
 （4）复合匹配同样可以包含值绑定。
    复合匹配里所有的匹配模式,都必须包含相同的值绑定。
    并且每一个绑定都必须获取到相同类型的值。
    这保证了,无论复合匹配中的 哪个模式发生了匹配,分支体内的代码,都能获取到绑定的值,并且绑定的值都有一样的类型。
 */
let someChar: Character = "e"
switch someChar {
case "a", "e", "i", "o", "u":
    print("\(someChar) is a vowel") //元音字母
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
      "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someChar) is a consonant") //辅音字母
default:
    print("\(someChar) is not a vowel or a consonant")
}


let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}
/*
 解释：
    （1）上面的case有两个模式: (let distance, 0) 匹配了在x轴上的值, (0, let distance) 匹配了在y轴上的值。
    （2）两个模式都绑定了 distance ,并且 distance 在两种模式下,都是整型。
        这意味着分支体内的代码,只要case匹 配,都可以获取到 distance 值。
 */



//5.  控制转移语句
/*
 改变代码执行顺序.
 实现代码的跳转.
 
     continue
     break
     fallthrough
     
     return
     throw
*/

//5.1  continue
/*
 告诉一个循环体立刻 停止本次循环,重新开始下次循环。
 */



//5.2  break
/*
 立刻结束整个控制流的执行。(switch / 循环体)
 
 switch 中的 break ：被用来匹配或者忽略一个或多个分支。
*/



//5.3   fallthrough
/*
 实现 C 风格的贯穿的特性.
 
 （1）fallthrough 关键字不会检查它下一个将会落入执行的 case 中的匹配条件。
 （2）fallthrough 简单地使代码继续连接到下一个 case 中的代码。
 
 
 比 C 语言的更加清晰和可预测.
 */
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)



//5.4  带标签的语句
/*
 给循环体 或 条件语句 加一个标签，
 可以使用 "break 标签"、"continue 标签" 显式地清晰指明要操作的代码块。
 在嵌套控制语句中，使代码逻辑更清晰。
 
 
 label name : while condition { statements }
 标签：前导关键字(introd ucor keyword)
 */

let finalNumber = 30
var inputNum = 20
gameLoop: while inputNum != finalNumber{
    inputNum += 1
    switch inputNum {
    case 22:
        break gameLoop
    case let newNum where inputNum > finalNumber:
        continue gameLoop
    default:
        break
    }
}
print(inputNum)



//6.  guard 提前退出
/*
  （1）guard 语句：条件为真时,执行 guard 语句后的代码。 类似if
  （2）guard 语句总有一个 else 从句,如果条件不为真则执行 else 从句中的代码。不同于 if
 
  （3）如果 guard 语句的条件被满足,则继续执行 guard 语句大括号后的代码。
    将变量或者常量的可选绑定作为语句的条件,都可以保护 guard 语句后面的代码。
 
  （4）如果条件不被满足,在 else 分支上的代码就会被执行。
    这个分支必须转移控制以退出 guard 语句出现的代码段。
    它可以用控制转移语句如 return , break , continue 或者 throw 做这件事,或者调用一个不返回的方法或函数,例如 fatalError() 。
 
 优点：
（1）相比于可以实现同样功能的 if 语句, 按需使用 guard 语句会提升我们代码的可读性。
（2）它可以使你的代码连贯的被执行而不需要将它包在 else 块中,
（3）它可以使你在紧邻条件判断的地方,处理违规的情况。
 */
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    
    print("Hello \(name)")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location).")
}
greet(person: ["name": "John"])

greet(person: ["name":"Jane","location":"Beijing"])

greet(person: ["xxx":"Tom"])



//7.  检测 API 可用性
/*
 Swift内置支持检查 API 可用性.
 编译器使用 SDK 中的可用信息来验证我们的代码中使用的所有 API 在项目指定的部署目标上是否可用。如果我 们尝试使用一个不可用的 API,Swift 会在编译时报错。
 可以在 if 或 guard 语句中使用 可用性条件 #available(Platform..., *)
 
     if #available(Platform..., *) {
        //APIs 可用,语句将执行
     } else {
        //APIs 不可用,语句将不执行
     }
 
 */

if #available(iOS 10, macOS 10.12, *) { // 可用性条件指定
    // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
}else {
    // 使用先前版本的 iOS 和 macOS 的 API
}
/*
 最后一个参数, * ,是必须的,用于指定在所有其它平台中,如果版本号高于你的设备指定的最低版本,if语句的代码块将会运行。
 
 在它一般的形式中,可用性条件使用了一个平台名字和版本的列表。
 平台名字可以是 iOS , macOS , watchOS 和 tvOS 
 除了指定像 iOS 8的主板本号, 还可以指定像iOS 8.3 以及 macOS 10.10.3的子版本号。
 */



