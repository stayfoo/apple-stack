//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, 构造过程"


//1.  构造过程
/*
 构造过程是使用类、结构体或枚举类型的实例之前的准备过程。
 在新实例可用前必须执行这个过程，具体操作包括设置实例中每个存储型属性的初始值和执行其他必须的设置或初始化工作。
 
 
 通过定义构造器来实现构造过程，这些构造器可以看做是用来创建特定类型新实例的特殊方法。
 与 Objective-C 中的构造器不同，Swift 的构造器无需返回值，它们的主要任务是保证新实例在第一次使用前完成正确的初始化。

 */


//2.  存储属性的初始赋值
/*
 类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。
 存储型属性的值不能处于一个未知的状态。
 你可以在构造器中为存储型属性赋初值，也可以在定义属性时为其设置默认值。
 
 注意：当为存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观察者。
 */

//2.1  构造器
/*
 构造器在创建某个特定类型的新实例时被调用。
 
 形式：
     init() {
        // 在此处执行构造过程
     }
 */

struct Fahrenheit { //保存华氏温度的结构体
    var temperature: Double
    init() { //不带参数的构造器
        temperature = 32.0 //存储型属性 temperature 的值初始化 , 水的冰点
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")


//2.2  默认属性值
/*
  如果一个属性总是使用相同的初始值，那么为其设置一个默认值比每次都在构造器中赋值要好。
  
 优点：
    （1）两种方法的效果是一样的，只不过使用默认值让属性的初始化和声明结合得更紧密。
    （2）使用默认值能让你的构造器更简洁、更清晰，且能通过默认值自动推导出属性的类型。
    （3）能让你充分利用默认构造器、构造器继承等特性。
 */

//简化：
struct Fahrenheits {
    var temperature = 32.0
}


//3.  自定义构造过程
/*
 构造能做的事情：
    输入参数；
    输入可选类型的属性；
    修改常量属性；
 */

//3.1  构造参数
/*
 自定义 构造过程 时，可以在定义中提供构造参数，指定所需值的类型和名字。
 构造参数的功能和语法跟函数和方法的参数相同。
 
 */

struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)


//3.2  构造参数的内部名称和外部名称
/*
 在调用构造器时，主要通过构造器中的 参数名和类型来确定应该被调用的构造器。
 
 如果不通过外部参数名字传值，你是没法调用这个构造器的。
 
 */

//指示颜色中红、绿、蓝成分的含量  0.0 - 1.0
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
//let veryGreen = Color(0.0,1.0,0.0) // 编译报错


//3.3  不带外部名的构造器参数

struct Celsiuss {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) { // 不带外部名的构造器参数
        temperatureInCelsius = celsius
    }
}


//3.4  可选属性类型
/*
 可选类型的属性将自动初始化为 nil ，表示这个属性是有意在初始化时设置为空的。
 */

class SurveyQuestion {
    var text: String
    var response: String? //可选字符串属性
//    当 SurveyQuestion 实例化时，它将自动赋值为 nil ，表明此字符串暂时还没有值。
    
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like it."


//3.5  构造过程中常量属性的修改
/*
 可以在构造过程中的任意时间点给常量属性指定一个值，只要在构造过程结束时是一个确定的值。
 一旦常量属性被赋值，它将永远不可更改。

 对于类的实例来说，它的常量属性只能在定义它的类的构造过程中修改;不能在子类中修改。
 */

class SurveyQuestions {
    let text: String //常量属性
    var response: String?
    
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestions(text: "How about beets?") //类的构造器中设置 常量属性
beetsQuestion.ask()
beetsQuestion.response = "I also lie it."


//4.  默认构造器
/*
 如果结构体或类的所有属性都有默认值，同时没有自定义的构造器，那么 Swift 会给这些结构体或类提供一个默认构造器(default initializers)。
 默认构造器会创建一个所有属性值都设置为默认值的实例。
 
 
 所有属性都有默认值；
 没有父类的基类；
 没有自定义的构造器;
 */

class ShoppingListItem { //购物清单
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem() //调用默认构造器


//结构体的逐一成员构造器
/*
 如果结构体没有提供自定义的构造器，它们将自动获得一个逐一成员构造器，即使结构体的存储型属性没有默认值。
 逐一成员构造器是用来初始化结构体新实例里成员属性的快捷方法。
 在调用逐一成员构造器时，通过与成员属性名相同的参数名进行传值来完成对成员属性的初始赋值。
 
 */

//自动获得 init(width:height:) 逐一成员构造器
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)


//5.  值类型的构造器代理
/*
 构造器代理：构造器 通过调用其它构造器来完成实例的部分构造过程。
    能减少多个构造器间的代码重复。
 
 值类型：(结构体和枚举类型)不支持继承，只能代理给自己的其它构造器。
    （1）只能在构造器内部调用 self.init ，引用相同类型中的其它构造器。
    （2）如果你为某个值类型定义了一个自定义的构造器，你将无法访问到默认构造器；如果是结构体，还将无法访问逐一成员构造器；
    （3）如果希望默认构造器、逐一成员构造器以及自定义构造器都能用来创建实例，可以将自定义的构造器写到扩展( extension )中，而不是写在值类型的原始定义中。
 
 
 类：可以继承自其它类。
    类必须保证其所有继承的存储型属性，在构造时也能正确的初始化。
 */

struct Point {
    var x = 0.0, y = 0.0
}
//矩形
struct Rect {
    var origin = Point()
    var size = Size()
    
    init() {} // 自定义构造器 , 空函数, 没有执行任何构造过程, 返回一个 Rect 实例, 属性默认值
    
    init(origin: Point, size: Size) { // 自定义构造器, 类似逐一成员构造器,
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size) { // 自定义构造器
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size) //构造器代理
    }
}

let basicRect = Rect()

let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))



//6.  类的继承和构造过程
/*
 类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值。
 
 类类型两种构造器：指定构造器（最主要） 和 便利构造器（辅助型）。
 目的：确保实例中所有存储型属性都能获得初始值。
 
 
 指定构造器：
    一个指定构造器将初始化类中提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化。
 
    每一个类都必须拥有至少一个指定构造器。
    在某些情况下，许多类通过继承了父类中的指定构造器而满足了这个条件。
 
     init(parameters) {
        statements
     }
 
 
 便利构造器：
    可以定义便利构造器来调用同一个类中的指定构造器，并为其参数提供默认值。
    可以定义便利构造器来创建一个特殊用途或特定输入值的实例。
 
     convenience init(parameters) {
        statements
     }

 
 类的构造器代理规则：
    规则 1： 指定构造器必须调用其直接父类的的指定构造器。
    规则 2： 便利构造器必须调用同类中定义的其它构造器。
    规则 3： 便利构造器必须最终导致一个指定构造器被调用。
 记忆方法：
    指定构造器必须总是向上代理
    便利构造器必须总是横向代理
 
 
 
 
 两段式构造过程：（类的构造过程包含两个阶段）
    第一阶段，每个存储型属性被引入它们的类指定一个初始值，直到每个存储型属性的初始值被确定。
    第二阶段，它给每个类一次机会，在新实例准备使用之前进一步定制它们的存储型属性。
 优点：
    两段式构造过程的使用让构造过程更安全；
    同时在整个类层级结构中给予了每个类完全的灵活性；
    防止属性值在初始化之前被访问；
    可以防止属性被另外一个构造器意外地赋予不同的值；
 注意：
    Swift 的两段式构造过程跟 Objective-C 中的构造过程类似。
    最主要的区别在于阶段 1，Objective-C 给每一个属性赋值 0 或空值(比如说 0 或 nil )。
    Swift 的构造流程则更加灵活，它允许你设置定制的初始值，并自如应对某些属性不能以 0 或 nil 作为合法默认值的情况。
 
 Swift 编译器将执行 4 种有效的安全检查：（确保两段式构造过程能不出错地完成）
    安全检查 1 ：指定构造器必须保证它所在类引入的所有属性都必须先初始化完成，之后才能将其它构造任务向上代理给父类中的构造器。
        一个对象的内存只有在其所有存储型属性确定之后才能完全初始化。
        为了满足这一规则，指定构造器必须保证它所在类引入的属性在它往上代理之前先完成初始化。
    安全检查 2 ： 指定构造器必须先向上代理调用父类构造器，然后再为继承的属性设置新值。如果没这么做，指定构造器赋予的新值将被父类中的构造器所覆盖。
    安全检查 3 ：便利构造器必须先代理调用同一类中的其它构造器，然后再为任意属性赋新值。如果没这么做，便利构造器赋予的新值将被同一类中其它指定构造器所覆盖。
    安全检查 4 ：构造器在第一阶段构造完成之前，不能调用任何实例方法，不能读取任何实例属性的值，不能引用 self 作为一个值。
 类实例在第一阶段结束以前并不是完全有效的。只有第一阶段完成后，该实例才会成为有效实例，才能访问属性和调用方法。
 
 两段式构造过程构造流程展示:（基于安全检查）
    阶段 1：
        • 某个指定构造器或便利构造器被调用。
        • 完成新实例内存的分配，但此时内存还没有被初始化。
        • 指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化。
        • 指定构造器将调用父类的构造器，完成父类属性的初始化。
        • 这个调用父类构造器的过程沿着构造器链一直往上执行，直到到达构造器链的最顶部。
        • 当到达了构造器链最顶部，且已确保所有实例包含的存储型属性都已经赋值，这个实例的内存被认为已经完 全初始化。此时阶段 1 完成。
    阶段 2
        • 从顶部构造器链一直往下，每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问 self 、修改它的属性并调用实例方法等等。
        • 最终，任意构造器链中的便利构造器可以有机会定制实例和使用 self 。
 
 
 
 
 
 构造器的继承和重写：
    跟 Objective-C 中的子类不同，Swift 中的子类默认情况下不会继承父类的构造器。
    父类的构造器仅会在安全和适当的情况下被继承。
    
 重写父类的指定构造器： 使用 override 。即使重写的是系统自动提供的默认构造器，也需要带上 override 修饰符。
 如果你编写了一个和父类便利构造器相匹配的子类构造器，由于子类不能直接调用父类的便利构造器，因此，严格意义上来讲，你的子类并未对一个父类构造 器提供重写。最后的结果就是，你在子类中“重写”一个父类便利构造器时，不需要加 override  前缀。
 
 注意：子类可以在初始化时修改继承来的变量属性，但是不能修改继承来的常量属性。
 */

//基类
class Vehicle {
    var numberOfWheels = 0 //存储型属性, 提供默认值, 没有自定义构造器,自动获得一个默认构造器
    
    var description: String { //计算型属性
        return "\(numberOfWheels) wheel(s)"
    }
}
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    override init() { // 自定义指定构造器,重写父类的指定构造器
        super.init() // 调用 Bicycle 的父类 Vehicle 的默认构造器, 保证父类存储型属性被初始化
        numberOfWheels = 2
    }
}
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")


/*
 构造器的自动继承
 
 假设你为子类中引入的所有新属性都提供了默认值，以下 2 个规则适用:
    规则 1： 如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器。
    规则 2： 如果子类提供了所有父类指定构造器的实现 —— 无论是通过规则 1 继承过来的，还是提供了自定义实现 —— 它将自动继承所有父类的便利构造器。
 即使你在子类中添加了更多的便利构造器，这两条规则仍然适用。
 注意：对于规则 2，子类可以将父类的指定构造器实现为便利构造器。
 
 
 指定构造器和便利构造器实践
 */

class Food {
    var name: String
    
    init(name: String) { // 指定构造器
        //没有父类,不需要调用 super.init() 来完成构造过程
        self.name = name
    }
    
    convenience init() { // 便利构造器
        self.init(name: "[Unnamed]") // 横向代理到指定构造器 init(name: String)
    }
}
let namedMeat = Food(name: "Bacon")


class RecipeIngredient: Food {
    var quantity: Int
    
    init(name: String, quantity: Int) { //指定构造器
        self.quantity = quantity
        super.init(name: name) // 构造器向上代理到父类 Food 的 init(name: String)
    }
    
    //将父类的指定构造器重写为了便利构造器
    override convenience init(name: String) { // 便利构造器
        self.init(name: name, quantity: 1) // 横向代理到类中的指定构造器
    }
    /*
     注意，此便利构造器使用了跟Food 中指定构造器 init(name: String) 相同的参数。
     由于这个便利构造器重写了父类的指定构造器 , 因此必须在前面使用 override 修饰。
     */
    
}
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)


class ShoppingListItems: RecipeIngredient {
    var purchased = false // 未购买

    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ?" : " ?"
        return output
    }
    
    /*
     由于它为自己引入的所有属性都提供了默认值，并且自己没有定义任何构造器， ShoppingListItem 将自动继承所 有父类中的指定构造器和便利构造器。
     */
}

var breakfastList = [
    ShoppingListItems(),
    ShoppingListItems(name: "Bacon"),
    ShoppingListItems(name: "Eggs", quantity: 6)
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}


//7.  可失败构造器
/*
 构造过程可失败：传入了无效参数，缺少某种所需的外部资源，不满足某种必要条件等。
 
 可以在一个类，结构体或是枚举类型的定义中，添加一个或 多个可失败构造器：
 语法：
    init?
 可失败构造器的参数名和参数类型，不能与其它非可失败构造器的参数名，及其参数类型相同。
 
 可失败构造器会创建一个类型为自身类型的可选类型的对象。你通过 return nil 语句来表明可失败构造器在何种情况下应该“失败”。
 注意： 严格来说，构造器都不支持返回值。因为构造器本身的作用，只是为了确保对象能被正确构造。因此你只是用 return nil 表明可失败构造器构造失败，而不要用关键字 return 来表明构造成功。
 
 
 */

struct Animal {
    let species: String
    
    init?(species: String) { // 可失败构造器
        if species.isEmpty { // 如果为空字符串，则构造失败
            return nil
        }
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print("An animal")
}

//空字符串( "" )和一个值为 nil 的可选类型的字符串是两个完全不同的概念。
//空字符串( "" )是一个有效的，非可选类型的字符串。
let anonymousCreature = Animal(species: "") // 构造失败
if anonymousCreature == nil {
    print("Not be initialized")
}


//7.1  枚举类型的可失败构造器

//如果提供的参数无法匹配任何枚举成员，则构造失败。
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:    //构造失败
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("initialization failed.")
}

//7.2  带原始值的枚举类型的可失败构造器
/*
 带原始值的枚举类型会自带一个可失败构造器 init?(rawValue:)
 */
enum TemperatureUnits: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnits = TemperatureUnits(rawValue: "F")
if fahrenheitUnits != nil {
    print("initialization succeeded.")
}

let unknownUnits = TemperatureUnits(rawValue: "X")
if unknownUnits == nil {
    print("initialization failed.")
}


//7.3  构造失败的传递
/*
 类，结构体，枚举的可失败构造器可以横向代理到类型中的其他可失败构造器。
 类似的，子类的可失败构造器也能向上代理到父类的可失败构造器。
 
 
 无论是向上代理还是横向代理，如果你代理到的其他可失败构造器触发构造失败，整个构造过程将立即终止，接
 下来的任何构造代码不会再被执行。
 
 注意：可失败构造器也可以代理到其它的非可失败构造器。通过这种方式，你可以增加一个可能的失败状态到现有的构造过程中。
 
 */

class Product {
    let name: String
    
    init?(name: String) { // 可失败构造器
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) { // 可失败构造器
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
}else{
    print("Unable to initialize")
}

if let oneUnnamed = CartItem(name: "", quantity: 1) { // 父类构造过程失败
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
}else{
    print("Unable to initialize")
}


//7.4  重写一个可失败构造器

class Document {
    var name: String?
    
    init() {}
    
    init?(name: String) { //可失败构造器
        self.name = name
        if name.isEmpty {
            return nil
        }
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    
    //本身是：非可失败构造器
    override init(name: String) { //重写父类的可失败构造器
        super.init()
        
// 当你用子类的非可失败构造器重写父类的可失败构造器时，向上代理到父类的可失败构造器的唯一方式是对父类的可失败构造器的返回值进行强制解包。
        
        if name.isEmpty {
            self.name = "[Untitled]"
        }else{
            self.name = name
        }
    }
}

class UntitledDocument: Document {
    override init(){
// 可以在子类的非可失败构造器中使用强制解包来调用父类的可失败构造器。
// 如果在调用父类的可失败构造器 init?(name:) 时传入的是空字符串，那么强制解包操作会引发运行时错误。
        super.init(name: "[Untitled]")!
    }
}


//7.5  可失败构造器 init!
/*
 init!  ： 可失败构造器将会构建一个对应类型的隐式解包可选类型的对象。
 
 可以在 init? 中代理到 init! ，反之也成立。
 可以用 init? 重写 init! ，反之也成立。
 可以用 init 代理 到 init! ，不过，一旦 init! 构造失败，则会触发一个断言。
 
 */



//8.  必要构造器
/*
 required 修饰 
 表明所有该类的子类都必须实现该构造器。
 
 
 在子类重写父类的必要构造器时，必须在子类的构造器前也添加 required 修饰符，表明该构造器要求也应用于继承链后面的子类。
 在重写父类中必要的指定构造器时，不需要添加 override 修饰符。
 
 
 
 注意：如果子类继承的构造器能满足必要构造器的要求，则无须在子类中显式提供必要构造器的实现。
 */
class SomeClass {
    required init() {
        // 构造器的实现代码
    }
}

class SomeSubclass: SomeClass {
    required init() {
        // 构造器的实现代码
    }
}








