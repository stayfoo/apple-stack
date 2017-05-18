//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, 继承"

/*
 在 Swift 中，
    （1）继承是区分「类」与其它类型的一个基本特征。
    （2）类可以调用和访问父类的方法，属性和下标，并且可以重写这些方法，属性和下标来优化或修改它们的行为。
    （3）Swift 会检查你的重写定义在超类中是否有匹配的定义，以此确保你的重写行为是正确的。
 */


//1.  定义一个基类
/*
 不继承于其它类的类，称之为基类。
 
 
 注意：
    Swift 中的类并不是从一个通用的基类继承而来。
    如果你不为你定义的类指定一个父类的话，这个类就自动成为基类。
 */

class Vehicle { //定义了一个通用特性的车辆类
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        //这个方法实际上不为 Vehicle 实例做任何事，但之后将会被 Vehicle 的子类定制
    }
}
let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")


//2.  子类生成
/*
 将父类名写在子类名的后面，用冒号分隔.
 
 class SomeClass: SomeSuperclass {
    //子类定义
 }
 */

class Bicycle: Vehicle { // 继承成父类 Vehicle
//    自动获得 Vehicle 类的所有特性，属性,方法。
    
    var hasBasket = false //表示有没有篮子
}

let bicycle = Bicycle()
bicycle.hasBasket = true

bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")


class Tandem: Bicycle { //双人自行车 继承成 Bicycle
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")



//3.  重写
/*
 重写：子类可以为继承来的实例方法，类方法，实例属性，或下标提供自己的定制的实现。
 
 使用 override 关键字修饰要重写的特性（实例方法，类方法，实例属性）。
 
 override 关键字会提醒 Swift 编译器去检查该类的超类(或其中一个父类)是否有匹配重写版本的声明。
 这个检查可以确保你的重写定义是正确的。
 */

//3.1  访问父类的方法，属性及下标
/*
 可以使用 super 来访问父类版本的方法，属性或下标：
（1）在方法 someMethod() 的重写实现中，可以通过 super.someMethod() 来调用父类版本的 someMethod() 方法。
（2）在属性 someProperty 的 getter 或 setter 的重写实现中，可以通过 super.someProperty 来访问父类版本的 someProperty 属性。
（3）在下标的重写实现中，可以通过 super[someIndex] 来访问父类版本中的相同下标。
 */


//3.2  重写方法
/*
 在子类中，你可以重写继承来的实例方法或类方法，提供一个定制或替代的方法实现。
 */

class Train: Vehicle {
    override func makeNoise() { //重写父类方法
        print("Choo Choo")
    }
}

let train = Train()
train.makeNoise()


//3.3  重写属性
/*
 可以重写继承来的"实例属性"或"类型属性"，提供自己定制的 getter 和 setter，或添加属性观察器,使重写的属性可以观察属性值什么时候发生改变。
 */

//（1）重写属性的 Getters 和 Setters
/*
 子类并不知道继承来的属性是存储型的还是计算型的，它只知道继承来的属性会有一个名字和类型.
 
 在重写一个属性时，必需将它的名字和类型都写出来。
 这样才能使编译器去检查你重写的属性是与父类中同名同类型的属性相匹配的。
 
 
 
 可以将一个继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供 getter 和 setter 即 可。
 但不可以将一个继承来的读写属性重写为一个只读属性。
 
 注意：
    如果你在重写属性中提供了 setter，那么你也一定要提供 getter。
    如果你不想在重写版本中的 getter 里修改继承来的属性值，你可以直接通过 super.someProperty 来返回继承来的值，其中 someProperty 是你要重写的属性的名字。

 */

class Car: Vehicle {
    var gear = 1 // 挡位
    override var description: String { //重写属性
        return super.description + " in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")


//（2）重写属性观察器
/*
 你可以通过重写属性为一个继承来的属性添加属性观察器。
 这样一来，当继承来的属性值发生改变时，你就会被通知到，无论那个属性原本是如何实现的。
 
 注意： 
    不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。
    这些属性的值是不可以被设置的，所以，为它们提供 willSet 或 didSet 实现是不恰当。
 
    不可以同时提供重写的 setter 和重写的属性观察器。如果你想观察属性值的变化，并且你已经为那个属性提供了定制的 setter，那么你在 setter 中就可以观察到任何值变化了。
 */

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")



//4.  防止重写
/*
 可以通过把方法，属性或下标标记为 final 来防止它们被重写，只需要在声明关键字前加上 final 修饰符即 可.  eg: final var , final func, final class func, final subscript
 如果你重写了带有 final 标记的方法，属性或下标，在编译时会报错。
 在类扩展中的方法，属性或下标也可以在扩展的定义里标记为 final 的。
 
 final class 这样的类是不可被继承的，试图继承这样的类会导致编译报错。
 */












