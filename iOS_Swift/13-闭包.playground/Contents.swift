//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, 闭包"


//1.  闭包
/*
 Closures
 闭包是自包含的函数代码块,可以在代码中被传递和使用。
 
 Swift 中的闭包与 C 和 Objective-C 中的代码块(blocks)以及其他一些编程语言中的匿名函数比较相似。
 
 
 包裹常量和变量：闭包可以捕获和存储其所在上下文中任意常量和变量的引用。
    Swift 会为你管理在捕获过程中涉及到的所有内存操作。
 
 全局和嵌套函数实际也是特殊的闭包, 闭包采取如下三种形式之一:
    （1）全局函数是一个有名字但不会捕获任何值的闭包；
    （2）嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包；
    （3）闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包；
 
 Swift 闭包语法优化如下:
    （1）利用上下文推断参数和返回值类型；
    （2）隐式返回单表达式闭包,即单表达式闭包可以省略 return 关键字；
    （3）参数名称缩写；
    （4）尾随闭包语法；
 
 */



//2.  闭包表达式
/*
 闭包表达式是一种利用简洁语法构建内联闭包的方式。
 闭包表达式提供了一些语法优化,使得撰写闭包变得简单明了。
 
 闭包表达式语法：（Closures）
     { (parameters) -> return type in
        statements
     }
 闭包表达式参数 可以是 in-out 参数,但不能设定默认值
 闭包表达式参数 可以是具名的可变参数，但要放在参数列表的最后一位,否则，调用闭包时编译器将报错。
 元组也可以作为参数和返回值。
 
 
 闭包的函数体部分由关键字 in 引入。
 该关键字表示闭包的参数和返回值类型定义已经完成,闭包函数体即将开始。
 
 
 实际上,通过内联闭包表达式构造的闭包作为参数传递给函数或方法时,总是能够推断出闭包的参数和返回值类型。
 这意味着闭包作为函数或者方法的参数时,你几乎不需要利用完整格式构造内联闭包。
 */

let names = ["Chris","Alex","Ewa","Barry","Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
/*
 解释：
    （1）如果第一个字符串(s1)大于第二个字符串(s2),backward(_:_:) 函数会返回 true,表示在新的数组中 s1 应该出现在 s2 前。
    （2）对于字符串中的字符来说,“大于”表示“按照字母顺序较晚出现”。
        这意味着字母 "B" 大于字母 "A" ,字符串 "Tom" 大于字符串 "Tim"。
    （3）该闭包将进行字母逆序排序,"Barry" 将会排在 "Alex" 之前。
 缺点：
    以这种方式来编写一个实际上很简单的表达式( a > b ),确实太过繁琐了。
    对于这个例子来说,利用闭包表达式语法可以更好地构造一个内联排序闭包。
 */

//简化一：使用闭包
//内联闭包参数和返回值类型声明 与 backward(_:_:) 函数类型声明相同。
//内联闭包表达式,函数和返回值类型都写在大括号内,而函数类型声明是在大括号外。
//一对圆括号仍然包裹住了方法的整个参数。然而,参数现在变成了内联闭包。
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

//简化二：
//可以改写成一行代码
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 })

//简化三：
//根据上下文推断类型
//闭包函数是作为 sorted(by:) 方法的参数传入的,Swift 可以推断其参数和返回值的类型。
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 })
/*
 如果完整格式的闭包能够提高代码的可读性,则更鼓励采用完整格式的闭包。
 而在 sorted(by:) 方法这个例子里,显然闭包的目的就是排序。
 由于这个闭包是为了处理字符串数组的排序,因此读者能够推测出这个闭包是用于字符串处理的。
 */

//简化四：
//单表达式闭包隐式返回
//单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果。
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 })
/*
 sorted(by:) 方法的参数类型明确了闭包必须返回一个 Bool 类型值。
 因为闭包函数体只包含了一个单一表达式( s1 > s2 ),该表达式返回 Bool 类型值,因此这里没有歧义, return 关键字可以省略。
 */

//简化五：
//参数名称缩写
//Swift 自动为内联闭包提供了参数名称缩写功能,你可以直接通过 $0 , $1 , $2 来顺序调用闭包的参数,以此类推。
//如果你在闭包表达式中使用参数名称缩写,你可以在闭包定义中省略参数列表,并且对应参数名称缩写的类型会通过函数类型进行推断
// in 关键字也同样可以被省略,因为此时闭包表达式完全由闭包函数体构成
reversedNames = names.sorted(by: {$0 > $1})
//$0和$1表示闭包中第一个和第二个 String 类型的参数。

//简化六：
//运算符方法
//Swift 的 String 类型定义了关于大于 号(>)的字符串实现,其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。
reversedNames = names.sorted(by: >)
//可以简单地传递一个大于号,Swift 可以自动推断出 你想使用大于号的字符串函数实现



//3.  尾随闭包
/*
 （1）如果你需要将一个很长的闭包表达式作为最后一个参数传递给函数,可以使用尾随闭包来增强函数的可读性。
 （2）尾随闭包是一个书写在函数括号之后的闭包表达式,函数支持将其作为最后一个参数调用。
 （3）在使用尾随闭包时,不用写出它的参数标签。
 
 适用场景：
    当闭包非常长以至于不能在一行中进行书写时,尾随闭包变得非常有用。
 */
//定义函数，最后一个参数是一个函数类型，即可以传入一个闭包
func someFunctionThatTakesAClosure(closure: () -> Void) {
    //函数体部分
}
//函数调用一：使用普通闭包
someFunctionThatTakesAClosure(closure: {
    //闭包主体部分
})
//函数调用二：使用尾随闭包
someFunctionThatTakesAClosure() {
    //闭包主体部分
}

//使用尾随闭包：
reversedNames = names.sorted() {$0 > $1}
//简化：如果闭包表达式是函数或方法的唯一参数, 则使用尾随闭包时,可以把 () 省略掉
reversedNames = names.sorted {$0 > $1}

/*
 public func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]
 功能：做数组映射，生成映射后的新数组。
 
 Swift 的 Array 类型有一个 map(_:) 方法,这个方法获取一个闭包表达式作为其唯一参数。
 该闭包函数会为数组中的每一个元素调用一次,并返回该元素所映射的值。
 具体的映射方式和返回值类型由闭包来指定。
 当提供给数组的闭包应用于每个数组元素后,map(_:) 方法将返回一个新的数组,数组中包含了与原数组中的元素一一对应的映射后的值。
 */
let digitNames = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 555]
let strings = numbers.map {
    (number) -> String in
    
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    
    return output
}
print(strings) // 映射后：["OneSix", "FiveEight", "FiveFiveFive"]
/*
 解释：
 map(_:) 为数组中每一个元素调用了一次闭包表达式。
 不需要指定闭包的输入参数 number 的类型,因为可以通过要映射的数组类型进行推断。
 在该例中,局部变量 number 的值由闭包中的 number 参数获得, 因此可以在闭包函数体内对其进行修改,(闭包或者函数的参数总是常量),闭包表达式指定了返回类型为 String, 以表明存储映射值的新数组类型为 String 。
 闭包表达式在每次被调用的时候创建了一个叫做 output  的字符串并返回。
 
 */



//4.  值捕获
/*
 闭包可以在其被定义的上下文中捕获常量或变量。
 即使定义这些常量和变量的原作用域已经不存在,闭包仍可以在闭包函数体内引用和修改这些值。
 
 嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量。
 
 */

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int { //没有任何参数 , 在函数体内访问了 runningTotal 和 amount 变量。
        runningTotal += amount //它从外围函数捕获了 runningTotal 和 amount 变量的引用。
        return runningTotal
        //捕获引用保证了 runningTotal 和 amount 变量在 调用完 makeIncrementer 后不会消失,并且保证了在下一次执行 incrementer 函数时,runningTotal 依旧存在。
    }
    return incrementer
}
//返回类型：() -> Int

// 注意： 为了优化,如果一个值不会被闭包改变,或者在闭包创建后不会改变,Swift 可能会改为捕获并保存一份对值的拷贝。 Swift 也会负责被捕获变量的所有内存管理工作,包括释放不再需要的变量。


//该例子定义了一个叫做 incrementByTen 的常量, 该常量指向一个每次调用会将其 runningTotal 变量增加 10 的 incrementor 函数。 调用这个函数多次可以得到以下结果:
let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen() //返回值：10
incrementByTen() //返回值：20
incrementByTen() //返回值：30


//如果创建了另一个 incrementor ,它有属于自己的引用,指向一个全新、独立的 runningTotal 变量.
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven() //返回值：7
incrementBySeven() //返回值：14


//再次调用原来的 incrementByTen 会继续增加它自己的 runningTotal 变量, 该变量和 incrementBySeven 中捕获的变量没有任何联系:
incrementByTen() //返回值：40

/*
 注意: 
    如果你将闭包赋值给一个类实例的属性, 并且该闭包通过访问该实例或其成员而捕获了该实例, 你将在闭包和该实例间创建一个循环强引用。Swift 使用捕获列表来打破这种循环强引用。
 */


//5.  闭包是引用类型
/*
 无论你将函数或闭包赋值给一个常量还是变量, 你实际上都是将常量或变量的值设置为对应函数或闭包的引用。
 
 */

//上面的例子中,incrementBySeven 和 incrementByTen 都是常量,但是这些常量指向的闭包仍然可以增加其捕 获的变量的值。   这是因为函数和闭包都是引用类型

//上面的例子中,指向闭包的引用 incrementByTen 是一个常量,  而并非闭包内容本身。

//将闭包赋值给了两个不同的常量或变量, 两个值都会指向同一个闭包:
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen() //返回值：50



//6.  逃逸闭包
/*
 当一个闭包作为参数传到一个函数中,但是这个闭包在函数返回之后才被执行,我们称该闭包从函数中逃逸。
 
 当你定义接受闭包作为参数的函数时,你可以在参数名之前标注 @escaping ,用来指明这个闭包是允许“逃逸”出这个函数的。
 
 
 能使闭包“逃逸”出函数的方法是：将这个闭包保存在一个函数外部定义的变量中。

 */


//很多启动异步操作的函数接受一个闭包参数作为 completion handler。
//这类函数会在异步操作开始之后立刻返回, 但是闭包直到异步操作结束后才会被调用。
//在这种情况下,闭包需要“逃逸”出函数,因为闭包需要在函数返回之后被调用。
var completionHandlers: [() -> Void] = [] //定义一个数组，元素是函数类型（即是闭包）
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler) //闭包被添加到函数外定义的数组中
}

//将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self 。


//传递到 someFunctionWithNonescapingClosure(_:) 中的闭包是一个非逃逸闭包,它可以隐式引用self。
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 } //逃逸闭包，显式地引用 self
        someFunctionWithNonescapingClosure { x = 200 }   //非逃逸闭包，隐式引用 self
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)



//7.  自动闭包
/*
 自动闭包是一种自动创建的闭包, 用于包装传递给函数作为参数的表达式。
 这种闭包不接受任何参数,当它被调用的时候,会返回被包装在其中的表达式的值。
 这种便利语法让你能够省略闭包的花括号,用一个普通的表达式来代替显式的闭包。
 
 我们经常会调用采用自动闭包的函数,但是很少去实现这样的函数。
 
 自动闭包让你能够延迟求值,因为直到你调用这个闭包,代码段才会被执行。
 延迟求值对于那些有副作用(SideEffect)和高计算成本的代码来说是很有益处的,因为它使得你能控制代码的执行时机。
 
 
 public func assert(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String = default, file: StaticString = #file, line: UInt = #line)
 函数接受自动闭包作为它的 condition 参数和 message 参数;
 它的 condition 参数仅会在 debug 模式下被求值,它的 message 参数仅当 condition 参数为 false 时被计算求值。

 */

//闭包延时求值
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count) //5

let customerProvider = { customersInLine.remove(at: 0) } //在闭包被调用之前,数组中元素不会被移除
//如果这个闭包永远不被调用,那么在闭包里面的表达式将永远不会执行,那意味着列表中的元素永远不会被移除。
// customerProvider 类型： () -> String 一个没有参数且返回值为 String 的函数。
print(customersInLine.count) //5

print("Now serving \(customerProvider())!") //调用闭包
print(customersInLine.count) // 4


//将闭包作为参数传递给函数时,你能获得同样的延时求值行为。
func serve(customer customerProvider: () -> String) { //该函数接受一个返回顾客名字的显式的闭包。
    print("Now serving Alex!")
}
serve(customer: { customersInLine.remove(at: 0) })

//完成了与上面相同的操作。
//不过它并没有接受一个显式的闭包,而是通过将参数标记为 @autoclosure 来接收一个自动闭包。
//可以将该函数当作接受 String 类型参数(而非闭包)的函数来调用。
//customerProvider 参数将自动转化为一个闭包, 因为该参数被标记了 @autoclosure 特性。
func served(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
served(customer: customersInLine.remove(at: 0))


//注意：过度使用 autoclosures 会让你的代码变得难以理解。上下文和函数名应该能够清晰地表明求值是被延迟执行的。

//如果想让一个自动闭包可以“逃逸”,则应该同时使用 @autoclosure 和 @escaping 属性。

var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider) // 将闭包追加到了 customerProviders 数组中。逃逸闭包
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}




