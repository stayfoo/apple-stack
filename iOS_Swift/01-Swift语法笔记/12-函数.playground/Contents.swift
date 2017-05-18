//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, 函数"

//1.  函数的定义与调用
/*
 函数名：   描述函数执行的任务。
 参数：    名字+类型的值。
 返回类型： 某种类型的值，函数执行结束时的输出。
 
 函数的实参必须与函数参数表里参数的顺序一致。
 */

func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}
print(greet(person: "Anna"))
print(greet(person: "Brian"))

func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))


//2.  函数参数与返回值
//2.1  无参数函数
func sayHelloWorld() -> String {
    return "无参数函数- Hello, world!"
}
print(sayHelloWorld())


//2.2  多参数函数
/*
 函数名相同，参数不同，是不同函数。
 */
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet(person: "Tom", alreadyGreeted: true))


//2.3  无返回值函数
/*
 （1）没有定义返回类型的函数会返回一个特殊的 Void 值。
 （2）它其实是一个空的元组(tuple),没有任何元素,可以写成()。
 
    public typealias Void = ()
 
 */
func greeted(person: String) {
    print("无返回值函数--- Hello, \(person)!")
}
greeted(person: "Dave")



//2.4  多重返回值函数
/*
 返回元组(tuple)类型。（复合值）
 
 注意：
    元组的成员不需要在元组从函数中返回时命名,因为它们的名字已经在函数返回类型中指定了。
 */
func minMax(array: [Int]) -> (min: Int, max: Int) { //获取数组中最小值，最大值
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        }else if value > currentMax {
            currentMax = value
        }
    }
    
    return (currentMin, currentMax) //此处不需要再命名元组，函数声明返回值类型是已经命名
}

let bounds = minMax(array: [8, -3, 3, 99, 50])
print("min is \(bounds.min) and max is \(bounds.max)")


//2.5  可选元组返回类型
/*
 如果函数返回的元组类型有可能整个元组都“没有值”,
 可以使用可选的( optional ) 元组返回类型反映整个元组可以是 nil 的事实。
    eg: (Int, Int)?  或 (String, Int, Bool)?
 
 注意： 
    （1）可选元组类型 如 (Int, Int)? 与 元组包含可选类型 如 (Int?, Int?) 是不同的.
    （2）可选的元组类型,整个元组是可选的,而不只是元组中的每个元素值。
 
 */
func minMaxed(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil} // 安全地处理这个“空数组”问题
    
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else {
            currentMax = value
        }
    }
    
    return (currentMin, currentMax)
}

if let boun = minMaxed(array: [22, -6, 88, 90,3]) {
    print("min is \(boun.min) and max is \(boun.max))")
}


//3.  函数参数标签和参数名称
/*
 （1）每个函数参数都有一个参数标签(argument label)以及一个参数名称(parameter name)。
 （2）函数的参数标签，在调用函数时使用； 参数名称，在函数的实现中使用。
 （3）默认情况下,函数参数使用参数名称来作为它们的参数标签。
 
 （4）参数都必须有一个独一无二的名字。
 （5）多个参数的参数标签是可以相同，但尽量保证函数标签的唯一性，能够使你的代码更具可读性。

*/

func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // 在函数体内， firstParameterName 和 secondParameterName 代表参数值
}
someFunction(firstParameterName: 1, secondParameterName: 2)


//3.1  指定参数标签
/*
 可以在函数名称前指定它的参数标签, 中间以空格分隔.
 
优点：
 参数标签的使用能够让一个函数在调用时更有表达力,更类似自然语言,
 并且仍保持了函数内部的可读性以及清晰的意图。
 */

func sayGreet(person: String, from hometown: String) -> String {
    return "Hello \(person)! Glad you could visit from \(hometown)"
}
print(sayGreet(person: "Bill", from: "Beijing"))


//3.2  忽略参数标签
/*
 如果不希望为某个参数添加标签,可使用下划线( _ )来代替一个明确的参数标签。
 
 如果一个参数有一个标签,那么调用时必须使用标签来标记这个参数。
 如果用 _ 标记了不添加标签，调用时直接填写参数。
 */

func someF(_ firstParameterName: Int, secondParameterName: Int) {
    
}
someF(1, secondParameterName: 2)


//3.3  默认参数值
/*
 （1）当默认值被定义后,调用函数时可忽略这个参数。
 （2）将不带有默认值的参数放在函数参数列表的最前。
 
 */

func someFun(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    
}
someFun(parameterWithoutDefault: 3, parameterWithDefault: 6)
someFun(parameterWithoutDefault: 3)


//3.4  可变参数
/*
 （1）可变参数,可接受零个或多个值。
 
 （2）可变参数的传入值,在函数体中,变为此类型的一个数组。
 （3）一个函数最多只能拥有一个可变参数。
 */

func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1,2,3,4,5) // 3
arithmeticMean(3,8,19) //10


//3.5  输入输出参数
/*
 函数参数默认是常量。在函数体中不能修改参数值。
 
 In-Out Parameters
 输入输出参数场景：
    如果你想要一个函数可以修改参数的值, 并且想要在函数调用结束后，这些修改仍然存在。
 
 定义：在参数定义前加 inout 关键字
 
 
 输入输出参数和返回值是不一样的。
 输入输出参数是函数对函数体外产生影响的另一种方式。
 
 
 注意：
    （1）只能传递变量给输入输出参数。
    （2）不能传入常量或者字面量, 因为这些量是不能被修改的。
    （3）当传入的参数作为输入输出参数时,需要在参数名前加 & 符,表示这个值可以被函数修改。
    （4）输入输出参数不能有默认值, 而且可变参数不能用 inout 标记。
 
 */


func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 108
swapTwoInts(&someInt, &anotherInt)
print("someInt： \(someInt), anotherInt： \(anotherInt)") //someInt和anotherInt被修改



//4.  函数类型
/*
 每个函数都有种特定的函数类型, 函数的类型由函数的参数类型和返回类型组成。
 */
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
//两个函数的类型是： (Int, Int) -> Int
//解读：“这个函数类型有两个 Int 型的参数并返回一个 Int 型的值。”


func printHelloWorld() {
    print("Hello, World")
}
//函数类型：() -> Void
//解读：“没有参数,并返回 Void 类型的函数。”


//4.1  使用函数类型
/*
 在 Swift 中,使用函数类型就像使用其他类型一样。
 类似非函数类型的变量, 有相同匹配类型的不同函数可以被赋值给同一个变量。
 */

//定义一个类型为函数的常量或变量, 并将适当的函数赋值给它
var mathFunction: (Int, Int) -> Int = addTwoInts
//解读：定义一个叫做 mathFunction 的变量, 类型是‘一个有两个 Int 型的参数并返回一个 Int 型的值的函数’, 并让这个新变量指向 addTwoInts 函数”
print("Result: \(mathFunction(2,3))")

mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2,3))")

let anotherMathFunction = addTwoInts // 类型推断为： (Int, Int) -> Int



//4.2  函数类型作为参数类型
/*
 可以用 (Int, Int) -> Int 这样的函数类型作为另一个函数的参数类型。
 这样可以将函数的一部分实现留给函数的调用者来提供。
 
 */

func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
/*
 printMathResult(_:_:_:) 函数的作用就是输出另一个适当类型的数学函数的调用结果。
 它不关心传入函数是如何实现的,只关心传入的函数是不是一个正确的类型。
 这使得 printMathResult(_:_:_:) 能以一种类型安全(type-safe)的方式将一部分功能转给调用者实现。
 */



//4.3  函数类型作为返回类型
/*
 可以用函数类型作为另一个函数的返回类型。
 在返回箭头(->)后写一个完整的函数类型。
 */

//函数类型： (Int) -> Int
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

//函数类型：(Bool) -> (Int) -> Int
//返回类型是：(Int) -> Int
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
//一个指向返回的函数的引用保存在了 moveNearerToZero 常量中。

print("Counting to zero: ")
while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")



//5.  嵌套函数
/*
 全局函数(global functions)：定义在全局域中。
 嵌套函数(nested functions)：把函数定义在别的函数体中。
 
 
 默认情况下,嵌套函数是对外界不可见的,但是可以被它们的外围函数(enclosing function)调用。
 一个外围 函数也可以返回它的某一个嵌套函数,使得这个函数可以在其他域中被使用。

 */
//使用返回嵌套函数的方式重新实现 chooseStepFunction(backward:) 函数:
func chooseStepFun(backward: Bool) -> (Int) -> Int {
    func stepFor(input: Int) -> Int {return input + 1}
    func stepBack(input: Int) -> Int {return input - 1}
    return backward ? stepBack : stepFor
}
var currentV = -4
let moveNearerTo0 = chooseStepFun(backward: currentV > 0)
while currentV != 0 {
    print("\(currentV)")
    currentV = moveNearerTo0(currentV)
}
print("zero!")








