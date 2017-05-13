//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, 枚举"



//1.  枚举
/*
 Enumerations
 枚举为一组相关的值定义了一个共同的类型,使你可以在代码中以类型安全的方式来使用这些值。
 
 在 Swift 中,枚举类型是一等(first-class)类型。
 它们采用了很多在传统上只被类(class)所支持的特性,
 例如:
    计算属性(computed properties),
    用于提供枚举值的附加信息,
    实例方法(instance methods),
    用于提供和枚举值相关联的功能。
    枚举也可以定义构造函数(initializers)来提供一个初始值;
    可以在原始实现的基础上扩展它们的功能;
    还可以遵循协议(protocols)来提供标准的功能。
 
 
 
 Swift 中的枚举更加灵活,不必给每一个枚举成员提供一个值。
 如果给枚举成员提供一个值(称为“原始”值),则该值的类型可以是 字符串,字符,或是一个整型值或浮点数。
 
 枚举语法：
 enum SomeEnumeration {
    // 枚举定义放在这里
 }
 
 （1）Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。
 （2）多个成员值可以出现在同一行上,用逗号隔开。
 （3）每个枚举都定义了一个全新的类型。名字首字母应该大写。
 
 
 */

//用枚举表示指南针四个方向
enum CompassPoint {
    case north  //成员值(或成员)
    case south
    case east
    case west
}
/*
  （1）north , south , east 和 west 不会被隐式地赋值为 0 , 1 , 2 和 3 。
  （2）相反,这些枚举成员本身 就是完备的值,这些值的类型是已经明确定义好的 CompassPoint 类型。
 */

//


var directionToHead = CompassPoint.west //类型推断：CompassPoint类型
directionToHead = .east //已知类型为枚举CompassPoint，可以使用更简短语法给他设置其他值。显式类型的枚举值时,具有更好的可读性。



enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}



//2.  使用 Switch 语句匹配枚举值

directionToHead = .south
switch directionToHead { //强制穷举,确保枚举成员不会被意外遗漏。
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}


//3.  关联值
/*
Swift 枚举可以存储任意类型的关联值,如果需要的话,每个枚举成员的关联值类型可以各不相同。

 */

enum Barcode {
    case upc(Int, Int, Int, Int) //成员值upc,关联值类型:(Int,Int,Int,Int)
    case qrCode(String) //成员值qrCode, 关联值类型: String
}
/*
 理解：
 （1）这个枚举的定义不提供任何 Int 或 String 类型的关联值
 （2）只是定义了,当 Barcode 常量和变量等于 Barcode.upc 或 B
 arcode.qrCode 时,可以存储的关联值的类型。
 */
var productBarcode = Barcode.upc(8, 88999, 22, 1)
/*
 理解：
 （1）创建了一个名为 productBarcode 的变量
 （2）将 Barcode.upc 赋值给这个变量 productBarcode
 （3）关联的元组值为 (8, 88999, 22, 1) 。
 */
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
/*
 （1）原始的 Barcode.upc 和其整数关联值被新的 Barcode.qrCode 和其字符串关联值所替代。
 （2）Barcode 类型的常 量和变量可以存储一个 .upc 或者一个 .qrCode (连同它们的关联值),  但是在同一时间只能存储这两个值中的一 个。
 */

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode)")
}

//如果一个枚举成员的所有关联值都被提取为常量,或者都被提取为变量,为了简洁,你可以只在成员名称前标注 一个let或者var:

switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case let .qrCode(productCode):
    print("QR code: \(productCode)")
}



//4.  原始值
/*
 （1）原始值是关联值的替代选择。
 （2）枚举成员可以被默认值(称为原始值)预填充。
 （3）原始值的类型必须相同。
 （4）原始值可以是字符串,字符,或者任意整型值或浮点型值。
 （5）每个原始值在枚举声明中必须是唯一的。
 （6）原始值是在定义枚举时被预先填充的值。如果定义了原始值，原始值始终不变。
 
 关联值是创建一个基于枚举成员的常量或变量时才设置的值,枚举成员的关联值可以变化。
 
 
 原始值的隐式赋值：
 （1）原始值为整数或者字符串类型,则不需要显式（手动）地为每一个枚举成员设置原始值,Swift 将会自动为你赋值。
 （2）当使用整数作为原始值时,隐式赋值的值依次递增 1 。如果第一个枚举成员没有设置原始值,其原始值将 为0。
 （3）当使用字符串作为枚举类型的原始值时,每个枚举成员的隐式原始值为该枚举成员的名称。
 （4）使用枚举成员的 .rawValue 属性，访问该枚举成员的原始值。
 
 
 使用原始值初始化枚举实例：(原始值构造器)
    如果在定义枚举类型的时候使用了原始值,那么将会自动获得一个初始化方法：
        枚举类型(rawValue: )
    接收一个 rawValue 参数,类型为原始值类型,返回值是枚举成员或 nil ， 一个可选的枚举成员。(是可以失败的，失败返回nil，所以是可选类型)
    可以使用这个初始化方法来创建一个新的枚举实例。
 
 */

enum ASCIIControlCharacter: Character { //原始值类型被定义为 Character
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

//.mercury = 1  .venus = 2   依次.....
enum Planets: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//.north 隐式原始值 north    依次.....
enum CompassPoints: String {
    case north, south, east, west
}

let earthsOrder = Planets.earth.rawValue // 3
let sunsetDirection = CompassPoints.west.rawValue //west


let possiblePlanet = Planets(rawValue: 7) // .uranus  可选的枚举成员
//类型推断：Planets?


let positionToFind = 11
if let somePlanet = Planets(rawValue: positionToFind) { //nil
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
}else {
    print("There isn't a planet at position \(positionToFind)")
}



//5.  递归枚举
/*
 （1）递归枚举是一种枚举类型。
 （2）它有一个或多个枚举成员使用该枚举类型的实例作为关联值。
 （3）使用递归枚举时,编译器会插入一个间接层。
 
 在枚举成员前加上 indirect 表示该成员可递归。
 在枚举类型开头加上 indirect 关键字,表明它的所有成员都是可递归的
 
 */

//在枚举成员前加上 indirect 表示该成员可递归。
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

//在枚举类型开头加上 indirect 关键字,表明它的所有成员都是可递归的
indirect enum ArithmeticExpressions {
    case number(Int) //纯数字
    case addition(ArithmeticExpressions, ArithmeticExpressions) //两个表达式相加, 关联值也是算术表达式
    case multiplication(ArithmeticExpressions, ArithmeticExpressions) //两个表达式相乘, 关联值也是算术表达式
}

//使用递归枚举创建表达式 (5 + 4) * 2
let five = ArithmeticExpressions.number(5)
let four = ArithmeticExpressions.number(4)
let sum = ArithmeticExpressions.addition(five, four)
let product = ArithmeticExpressions.multiplication(sum, ArithmeticExpressions.number(2))


//使用递归函数，直接操作具有递归性质的数据结构。对算术表达式求值函数：
func evaluate(_ expression: ArithmeticExpressions) -> Int {
    switch expression {
    case let .number(value): //纯数字,就直接返回该数字的值。
        return value
    case let .addition(left, right): //加法运算,则分别计算左边表达式和右边表达式的值,然后相加
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right): //乘法运算,则分别计算左边表达式和右边表达式的值,然后相乘
        return evaluate(left) * evaluate(right)
    }
}



















