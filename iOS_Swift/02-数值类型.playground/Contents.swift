//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, 整数、浮点数、类型安全和推断、类型转换"

//1. 整数
/*
 Swift 提供了8,16,32和64位的有符号和无符号整数类型。
 
     Int  ： 长度与当前平台的原生字长相同
 
     Int8
     Int16
     Int32
     Int64
     
     UInt ： 长度与当前平台的原生字长相同
 
     UInt8
     UInt16
     UInt32
     UInt64
 */
let minValue = UInt8.min // UInt8类型最小值是0， minValue 是UInt8类型
let maxValue = UInt8.max // UInt8类型最大值是255，maxValue 是UInt8类型

/*
 （1）一般来说,不需要专门指定整数的长度。使用 Int 和 UInt 就够了。
    在32位平台上, Int和 Int32 长度相同。
    在64位平台上, Int 和 Int64 长度相同。
 
 （2）尽量不要使用 UInt , 除非你真的需要存储一个和当前平台原生字长相同的无符号整数。
    除了这种情况,最好使 用 Int ,即使你要存储的值已知是非负的。
    统一使用 Int 可以提高代码的可复用性,避免不同类型数字之间的转换,并且匹配数字的类型推断。
 */


//2. 浮点型  
/*
 （1）Double 精确度很高,至少有15位数字。
 （2）Float 只有6位数字。
 （3）选择哪个类型取决于你的代码需要处理的值的范围,  在两种类型都匹配的情况下,将优先选择 Double 。
 
   都使用 Double 。
 */



//3. 类型安全(type safe)
/*
 （1）Swift 是一个类型安全(type safe)的语言。
 类型安全的语言可以让你清楚地知道代码要处理的值的类型。
 如果你的代码需要一个 String ,你绝对不可能不小心传进去一个 Int 。
 
 （2）由于 Swift 是类型安全的,所以它会在编译你的代码时进行类型检查(type checks),
 并把不匹配的类型标记 为错误。
 这可以让你在开发的时候尽早发现并修复错误。
 
 （3）当你要处理不同类型的值时,类型检查可以帮你避免错误。
 然而,这并不是说你每次声明常量和变量的时候都需要显式指定类型。
 如果你没有显式指定类型,Swift 会使用类型推断(type inference)来选择合适的类型。
 有了类型推断,编译器可以在编译代码的时候自动推断出表达式的类型。原理很简单,只要检查你赋的值即可。
 
 （4）因为有类型推断,和 C 或者 Objective-C 比起来 Swift 很少需要声明类型。
 常量和变量虽然需要明确类型,但是大部分工作并不需要你自己来完成。
 
 （5）当你声明常量或者变量并赋初值的时候，类型推断非常有用。
 当你在声明常量或者变量的时候，赋给它们一个字面量(literal value 或 literal)即可触发类型推断。
  (字面量：就是变量或常量的值)
 
 类型推断在赋值的时候可以触发。
 */
let pi = 3.1 //类型推断为： Double 类型

let meaningOfLife = 42 //类型推断为：Int 类型

let anotherPi = 3 + 0.14 //类型推断为： Double 类型


//4. 数值型字面量

/*
 一个十进制数,没有前缀
 一个二进制数,前缀是 0b
 一个八进制数,前缀是 0o
 一个十六进制数,前缀是 0x
 */
let decimalInteger = 17
let binaryInteger = 0b10001   // 二进制的17
let octalInteger = 0o21       // 八进制的17
let hexadecimalInteger = 0x11 // 十六进制的17

//5. 数值型类型转换
/*
 总是使用默认的整数类型：可以保证你的整数常量和变量可以直接被复用，并且可以匹配整数类字面量的类型推断。
 
 只有在必要的时候才使用其他整数类型,比如：要处理外部的长度明确的数据 或者 为了优化性能、内存占用等等。使用显式指定长度的类型可以及时发现值溢出并且可以暗示正在处理特殊数据。
 
 
 Int8 能够存储数字范围： -128 ~ 127 
 UInt8 能够存储数字范围： 0 ~ 255
 如果数字超出了常量或者变量可存储的范 围,编译的时候会报错。
 */
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)//必须显示转换
/*
 解释：
 SomeType(ofInitialValue) ：是调用 Swift 构造器并传入一个初始值的默认方法。 UInt16(one)
 在语言内部, UInt16 有一个 构造器,可以接受一个 UInt8 类型的值,所以这个构造器可以用现有的 UInt8 来创建一个新的 UInt16 。
 注意：你并不能传入任意类型的值,只能传入 UInt16 内部有对应构造器的值。不过你可以扩展现有的类型来让它 可以接收其他类型的值(包括自定义类型),
 
 */
/*
 注意:
 结合数字类常量和变量不同于结合数字类字面量。
 字面量 3 可以直接和字面量 0.14159 相加,因为数字字面量 本身没有明确的类型。它们的类型只在编译器需要求值的时候被推测。
 */


//6. 类型别名
/*
 类型别名(type aliases)就是给现有类型定义另一个名字。
 
 当你想要给现有类型起一个更有意义的名字时,类型别名非常有用。
 
 */

typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min
UInt16.min



