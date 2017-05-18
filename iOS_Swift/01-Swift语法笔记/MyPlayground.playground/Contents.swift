//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
print(str)



//使用方括号 [] 来创建数组和字典,并使用下标或者键(key)来访问元素。最后一个元素后面允许有个逗号。
var shopping = ["apple","android"]
shopping[0]
shopping[1]
shopping.count

var occupations = [
    "Malcolm":"Captain",
    "Kaylee":"Mechanic"
]
occupations["Jayne"] = "Public Relations"

occupations.count

//创建空数组/空字典, 使用初始化语法。
let emptyArray = [String]()
let emptyDictionary = [String: Float]()


//包裹条件和循环 变量括号可以省略,  但是语句体的大括号是必须的。
let scores = [77,22,33,44,65]
var teamScore = 0
for score in scores {
    print(score)
    if score > 50 {
        teamScore += 3
    }else{
        teamScore += 1
    }
}
print(teamScore)

//在 if 语句中,条件必须是一个布尔表达式   
// ——这意味着像 if score { ... } 这样的代码将报错,而不会隐形地 与 0 做对比。

if true {
    print("--true-")
}

if false {
    
}else{
    print("-false--")
}



//条件语句处理值缺失情况：
//方法一：
//你可以一起使用 if 和 let 来处理值缺失的情况。这些值可由可选值来代表。一个可选的值是一个具体的值或者 是 nil 以表示值缺失。在类型后面加一个问号来标记这个变量的值是可选的。

var optionalString: String? = "Hello"
let n = optionalString
print(optionalString == nil)
print(n)


//var optionalName: String? = nil
var optionalName: String? = "Jim"
var greeting = "Hello"
if let name = optionalName {  // optionalName == nil
    greeting = "Hello, \(name)"
}else{
    greeting = "Hello, kk"
}

//如果变量的可选值是 ,条件会判断为 ,大括号中的代码会被跳过。
//如果不是 ,会将值解包并赋给 后面的常量,这样代码块中就可以使用这个值了。



//方法二：
//另一种处理可选值的方法是通过使用 ?? 操作符来提供一个默认值。
//如果可选值缺失的话,可以使用默认值来代 替。

let nickName: String? = nil
//let nickName: String? = "Tom"
let fullName: String = "Jack"
let informalGreeting = "Hi \(nickName ?? fullName)"




//switch 支持任意类型的数据以及各种比较操作——不仅仅是整数以及测试相等。
let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log")
case "cucumber", "watercress":
    print("That")
case "red pepper":
    print("This a")
case "red pepper":
    print("This b")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything")
}


//运行 switch 中匹配到的子句之后,程序会退出 switch 语句,并不会继续向下运行,所以不需要在每个子句结尾 写 break 。



//你可以使用 for-in 来遍历字典,需要两个变量来表示每个键值对。字典是一个无序的集合,所以他们的键和值以 任意顺序迭代结束。
let interestingNumbers = [
    "Prime" : [1,3,44,52,88],
    "Fibonacci": [1,4,5,22,55],
    "Square": [43,9,99,39]
]
var largest = 0
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
print(largest)



var nn = 2
while nn < 100 {
    nn = nn * 2
}

print(nn)



var mm = 2
repeat {
    mm = mm * 2
} while mm < 100

print(mm)


//你可以在循环中使用 ..< 来表示范围。 ..< 创建的范围不包含上界
//如果想包含的话需要使用 ... 。
//前闭
var total = 0
for i in 0..<2 {
    total += i
}
print(total)

//reversed() 翻转， 循环区间从9-1
for i in (1..<10).reversed() {
    print("for: ", i)
}

//stride(from: 0.5, to: 5, by: 0.1)   
// by: 循环步长  to ：取不到边界   through: 可以取到边界
for i in stride(from: 0.5, through: 5, by: 0.1) {
    print(i)
}






//使用 func 来声明一个函数,使用名字和参数来调用函数。使用 -> 来指定函数返回值的类型。
func greet(person: String, day: String, foot: String) -> String {
    return "Hello \(person), today is \(day), my food is \(foot)."
}
greet(person: "Tom", day: "Tuesday", foot: "apple")


//默认情况下,函数使用它们的参数名称作为它们参数的标签,在参数名称前可以自定义参数标签,或者使用 _ 表示不使用参数标签。
func eat(_ name: String, on day: String) -> String {
    return "Hello \(name), today is \(day)."
}
eat("Jack", on: "Wednesday")



//使用 元组 来让一个函数返回多个值。该元组的元素可以用名称或数字来表示。
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int){
    var min = scores[0]
    var max = scores[1]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    
    return (min, max, sum)
}

let statistics = calculateStatistics(scores: [3,1,2])
print(statistics.sum)
print(statistics.2)


//函数可以带有可变个数的参数,这些参数在函数内表现为数组的形式:
func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
sumOf()
sumOf(numbers: 22, 33)



//函数可以嵌套。被嵌套的函数可以访问外侧函数的变量,你可以使用嵌套函数来重构一个太长或者太复杂的函数。
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()


//函数是第一等类型,这意味着函数可以作为另一个函数的返回值。
func makeIncrementer() -> ((Int) -> Int){
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)


//函数也可以当做参数传入另一个函数。
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [22, 8, 11]
hasAnyMatches(list: numbers, condition: lessThanTen)


//函数实际上是一种特殊的闭包:它是一段能之后被调取的代码。

//闭包中的代码能访问 闭包所建作用域中 能得到的变量和函数, 即使闭包是在一个不同的作用域被执行的 -- 你已经在嵌套函数例子中所看到。
//你可以使用 {} 来创建 一个匿名闭包。 使用 in 将参数和返回值类型声明与闭包函数体进行分离。


numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result;
})

//有很多种创建更简洁的闭包的方法。如果一个闭包的类型已知,比如作为一个回调函数,你可以忽略参数的类型和返回值。单个语句闭包会把它语句的值当做结果返回。
let mappedNumbers = numbers.map({ number in 2 * number})
print(mappedNumbers)

//你可以通过参数位置而不是参数名字来引用参数——这个方法在非常短的闭包中非常有用。当一个闭包作为最后一个参数传给一个函数的时候,它可以直接跟在括号后面。当一个闭包是传给函数的唯一参数,你可以完全忽略括号。
let sortedNumbers = numbers.sorted {$0 > $1}
print(sortedNumbers)



//使用 class 和类名来创建一个类。类中属性的声明和常量、变量声明一样,唯一的区别就是它们的上下文是 类。同样,方法和函数声明也一样。
class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
//要创建一个类的实例,在类名后面加上括号。使用点语法来访问实例的属性和方法。
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()


//上边版本的 Shape 类缺少了一些重要的东西:  一个构造函数来初始化类实例。使用 init 来创建一个构造器。

class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
//注意 self 被用来区别实例变量。当你创建实例的时候,像传入函数参数一样给类传入构造器的参数。    每个属性都 需要赋值——无论是通过声明(就像 numberOfSides )还是通过构造器(就像 name )。



//子类的定义方法是在它们的类名后面加上父类的名字,用冒号分割。创建类的时候并不需要一个标准的根类,所以你可以忽略父类。
//子类如果要重写父类的方法的话,需要用 override 标记 ——-- 如果没有添加 override 就重写父类方法的话编译器 会报错。编译器同样会检测 override 标记的方法是否确实在父类中。
class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        
        super.init(name: name)
        
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)"
    }
}

let test = Square(sideLength: 5, name: "my test square")
test.area()
test.simpleDescription()



//除了储存简单的属性之外,属性可以有 getter 和 setter 。

class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triagle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)
triangle.perimeter = 9.9
print(triangle.sideLength)




//在 perimeter 的 setter 中,新值的名字是 newValue 。你可以在 set 之后显式的设置一个名字。

/*
 注意 EquilateralTriangle 类的构造器执行了三步:
 1. 设置子类声明的属性值
 2. 调用父类的构造器
 3. 改变父类定义的属性值。其他的工作比如调用方法、getters 和 setters 也可以在这个阶段完成。
 */



//如果你不需要计算属性,但是仍然需要在设置一个新值之前或者之后运行代码,使用 willSet 和 didSet 。

//比如,下面的类确保三角形的边长总是和正方形的边长相同。
class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger")
print(triangleAndSquare.triangle.sideLength)


//处理变量的可选值时,你可以在操作(比如方法、属性和子脚本)之前加 ? 。
//如果 ? 之前的值是 nil , ? 后面 的东西都会被忽略,并且整个表达式返回 nil 。
//否则, ? 之后的东西都会被运行。
//在这两种情况下,整个表达式 的值也是一个可选值。
let optionalSquare: Square? = Square(sideLength:2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength



//使用 enum 来创建一个枚举。就像类和其他所有命名类型一样,枚举可以包含方法。
enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.Ace
let aceRawValue = ace.rawValue //原始值

Rank.King
Rank.King.rawValue
Rank.King.simpleDescription()
//Rank.simpleDescription(Rank.King)() //感觉不合理

Rank(rawValue: 4) //枚举值

//默认情况下,Swift 按照从 0 开始每次加 1 的方式为原始值进行赋值,不过你可以通过显式赋值进行改变。
//在上面的例子中, Ace 被显式赋值为 1,并且剩下的原始值会按照顺序赋值。
//你也可以使用字符串或者浮点数作为 枚举的原始值。使用 rawValue 属性来访问一个枚举成员的原始值。


//使用 init?(rawValue:) 初始化构造器在原始值和枚举值之间进行转换。
//Rank(rawValue: 3)    获取枚举值
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}

//枚举的成员值是实际值, 并不是原始值的另一种表达方法。实际上,如果没有比较有意义的原始值,你就不需要提供原始值。
enum Suit {
    case Spades, Hearts, Diamonds, Clubs
    func simpleDescription() -> String {
        switch self {  //这里的 self 就是枚举 Suit 的一个成员。可以说是已经知道变量类型。
        case .Spades:  //.Spades 引用枚举的成员方式二。
            return "spades" //黑桃
        case .Hearts:
            return "hearts" //红心
        case .Diamonds:
            return "diamonds" //方块
        case .Clubs:
            return "clubs"  //梅花
        }
    }
    func color() -> String {
        switch self {
        case .Spades, .Clubs:
            return "black"
        case .Hearts, .Diamonds:
            return "red"
        }
    }
}
let hearts = Suit.Hearts //Suit.Hearts 引用枚举的成员方式一。
let heartsDescription = hearts.simpleDescription()
let heartsColor = hearts.color()

//注意,有两种方式可以引用 Hearts 成员:  给 hearts 常量赋值时,枚举成员 Suit.Hearts 需要用全名来引用, 因为常量没有显式指定类型。在 switch 里,枚举成员使用缩写 .Hearts 来引用,因为 self 的值已经知道是一个 suit。 已知变量类型的情况下你可以使用缩写。




//一个枚举成员的实例可以有实例值。
//相同枚举成员的实例可以有不同的值。创建实例的时候传入值即可。
//实例值和原始值是不同的: 枚举成员的原始值对于所有实例都是相同的,而且你是在定义枚举的时候设置原始值。

enum ServerResponse {
    case Result(String, String)
    case Failure(String)
    case Crash(String)
}

let success = ServerResponse.Result("6:00 am", "8:00 pm")
let failure = ServerResponse.Failure("Out of cheese.")
let crash = ServerResponse.Crash("Server is Crash...")

switch success {
case let .Result(sunrise, sunset):
    let serverResponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)."
case let .Failure(message):
    print("Failure... \(message)")
case let .Crash(msg):
    print("Crash...\(msg)");
}

//注意日升和日落时间是如何从 ServerResponse 中提取到并与 switch 的 case 相匹配的。





//使用 struct 来创建一个结构体。结构体和类有很多相同的地方,比如方法和构造器。它们之间最大的一个区别就 是结构体是传值,类是传引用。

struct Card {
    var rank: Rank //扑克牌 牌面大小
    var suit: Suit //扑克牌 花色
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}
let threeOfSpades = Card(rank: .Three, suit: .Spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()


//使用 protocol 来声明一个协议。
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}
//类、枚举和结构体都可以实现协议。
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription


struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription

//写一个实现这个协议的枚举。
//enum SimpleEnum: ExampleProtocol {
//    var simpleDescription: String = "A simple Enum"
//    mutating func adjust() {
//        simpleDescription += " (adjusted)"
//    }
//}

//注意 声明 SimpleStructure 时候 mutating 关键字用来标记一个会修改结构体的方法。 
// SimpleClass 的声明不需要 标记任何方法,因为类中的方法通常可以修改类属性(类的性质)。


//使用 extension 来为现有的类型添加功能,比如新的方法和计算属性。你可以使用扩展在别处修改定义,甚至是 从外部库或者框架引入的一个类型,使得这个类型遵循某个协议。
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}
print(7.simpleDescription)


//给 Double 类型写一个扩展,添加 absoluteValue 功能。
//protocol NumberAbsoluteValueProtocol {
//    var simpleDescription: Double { get }
//    mutating func adjust()
//}
//extension Double: NumberAbsoluteValueProtocol {
//    var simpleDescription: Double {
//        if self >= 0 {
//            return self
//        }else{
//            return self * (-1);
//        }
//    }
//    mutating func adjust() {
//        
//    }
//}
//print(-7.simpleDescription)


let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
//print(protocolValue.anotherProperty)







//Swift 还增加了 Objective-C 中没有的高阶数据类型比如元组(Tuple)。元组可以让你 创建或者传递一组数据,比如作为函数的返回值时,你可以用一个元组可以返回多个值。

//Swift 可选(Optional)类型,用于处理值缺失的情况。可选表示 “那儿有一个值,并且它等于 x ” 或者 “那儿没有值” 。可选有点像在 Objective-C 中使用   ,但是它可以用在任何类型上,不仅仅是 类。可选类型比 Objective-C 中的   指针更加安全也更具表现力,它是 Swift 许多强大特性的重要组成部 分。


//Swift 是一门类型安全的语言,这意味着 Swift 可以让你清楚地知道值的类型。如果你的代码期望得到一个 ,类型安全会阻止你不小心传入一个   。同样的,如果你的代码期望得到一个 ,类型安全会阻止你意外传入一个可选的   。类型安全可以帮助你在开发阶段尽早发现并修正错误。


















