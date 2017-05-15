//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, 方法"


//1.  方法

/*
 实例方法
 类型方法
 
 方法是与某些特定类型相关联的函数。
 类、结构体、枚举都可以定义实例方法;
 实例方法为给定类型的实例封装了具体的任务与功能。
 
 类、结构体、枚举也可以定义类型方法;
 类型方法与类型本身相关联。
 类型方法与 Object ive-C 中的类方法(class methods)相似。
 
 Swift 与 C/Objective-C 区别：
    Swift 结构体和枚举能够定义方法。
    在 Objective-C 中，类是唯一能定义方法的类型。
 */


//2.  实例方法
/*
 Instance Methods
 实例方法的语法与函数完全一致.
 实例方法只能被它所属的类的某个特定实例调用。
 
 实例方法能够“隐式”访问它所属类型的所有的其他实例方法和属性。(不用显示使用self)
 
 点语法(dot syntax)调用
 
 与函数参数也一样，方法参数可以同时有一个局部名称(在方法内部使用)和一个外部名称(在调用方法时使用)，因为方法就是函数，只是这个函数与某个类型相关联了。
 */

class Counter {
    var count = 0
    func increment() { //实例方法
        count += 1
    }
    func increment(by amount: Int) {//实例方法
        count += amount
    }
    func reset() {//实例方法
        count = 0
    }
}
let counter = Counter()
counter.increment()
counter.count
counter.increment(by: 5)
counter.count
counter.reset()
counter.count


//2.1  self 属性
/*
 类型的每一个实例都有一个隐含属性叫做 self ，self 完全等同于该实例本身。
 可以在一个实例的实例方法中使用这个隐含的 self 属性来引用当前实例。

 不论何时，只要在一个方法中使用一个已知的属性或者方法名称，如果你没有明确地写 self ，Swift 假定你是指当前实例的属性或者方法。
 
 使用self：
    使用这条规则的主要场景是实例方法的某个“参数名称”与实例的某个“属性名称”相同的时候。
    在这种情况下，参数名称享有优先权，并且在引用属性时必须使用一种更严格的方式。
    这时你可以使用 self 属性来区分参数名称和属性名称。
 */

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x //self.x 是属性， x 是参数
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}


//2.2  在实例方法中修改值类型
/*
 结构体和枚举是值类型。
 默认情况下，值类型的属性不能在它的实例方法中被修改。
 
 若想修改，使用 mutating 修饰该方法，然后就可以从其方法内部改变它的属性。
 并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。
 
 
 注意：
    不能在结构体类型的常量(a constant of structure type)上调用可变方法，因为其属性不能被改变，即使属性是变量属性，
 
 
 */

struct Points {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoints = Points(x: 1.0, y: 1.0)
somePoints.moveByX(deltaX: 2.0, y: 3.0)
print("The point is now at (\(somePoints.x), \(somePoints.y))")
//该方法被调用时修改了这个点，而不是返回一个新的点。
//方法定义时加上了 mutating 关键字，从而允许修改属性。


let fixedPoint = Points(x: 3.0, y: 3.0) //结构体类型的常量
//fixedPoint.moveByX(deltaX: 2.0, y: 3.0) //编译器报错



//2.3  在可变方法中给 self 赋值
/*
 可变方法可以给它隐含的 self 属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。

 */

struct PointThree {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        //给隐含属性 self 赋予一个全新的实例
        self = PointThree(x: x + deltaX, y: y + deltaY)
    }
}

//枚举的可变方法可以把 self 设置为同一枚举类型中不同的成员:
//一个三态开关的枚举,每次调用 next() 方法时，开关在不同的电源状态之间循环切换。
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}
var ovenLight = TriStateSwitch.Low // Low
ovenLight.next() //High
ovenLight.next() //Off



//3.  类型方法
/*
 使用类型本身调用。
 在方法的 func 关键字之前加上关键字 static ，来指定类型方法。
 类还可以用关键字 class 来允许子类重写父类的方法实现。
 点语法调用。
 
 在类型方法的方法体(body)中， self 指向这个类型本身，而不是类型的某个实例。
 可以用 self 来消除类型属性和类型方法参数之间的歧义。
 
 
 
 注意：
 在 Objective-C 中，你只能为 Objective-C 的类类型(classes)定义类方法(type-level methods)。
 在 Swift 中，你可以为所有的类、结构体和枚举定义类型方法。每一个类型方法都被它所支持的类型显式包含。
 
 
 使用：
 （1）类型方法中可以调用其它类型方法（本类中的）（通过类型方法的名称）（不用加上类型名称）。
 （2）类型方法中可以直接访问类型属性（本类中的）（不用加上类型名称）。
 
 
 函数标注 @discardableResult 属性：允许在调用函数时忽略返回值，不会产生编译警告。
 */

class SomeClass {
    class func someTypeMethod() {
        //在这里实现类型方法
    }
}
SomeClass.someTypeMethod()

//监测玩家已解锁的最高等级
struct LevelTracker {
    static var highestUnlockedLevel = 1 //最高等级, 类属性
    var currentLevel = 1 //监测每个玩家的进度,监测每个玩家 当前的等级。 实例属性
    
    static func unlock(_ level: Int) { //类方法
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool { //类方法
        return level <= highestUnlockedLevel
    }
    
    //函数标注 @discardableResult 属性：允许在调用函数时忽略返回值，不会产生编译警告。
    @discardableResult
    mutating func advance(to level: Int) -> Bool { //实例方法
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        }else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1) //忽略了返回的布尔值
    }
    
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Tom")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")


player = Player(name: "Jack")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
}else {
    print("level 6 has not yet been unlocked")
}











