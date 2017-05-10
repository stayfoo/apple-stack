//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, 集合类型：数组、集合、字典"

//1. 集合的可变性
/*
 （1）可变：
    使用 var 来定义一个 Arrays 、 Sets 或 Dictionaries （即：把它分配成变量）,这个集合将会是可变的。（可变就是：在创建之后，可以“添加”、“移除“、”更改“集合中的数据项）
 
 （2）不可变：
    使用 let 来定义一个 Arrays 、 Sets 或 Dictionaries （即：把它分配成常量）,这个集合将会是不可变的。（不可变就是：大小和内容都不能被改变）
 
 
 注意:
    在我们不需要改变集合的时候创建不可变集合是很好的实践。
    如此 Swift 编译器可以优化我们创建的集合。
 */


//2.  数组
/*
 Arrays
    （1）有序的
    （2）元素是同一类型
    （3）相同的值可以多次出现在一个数组的不同位置中
 
 public struct Array<Element> : RandomAccessCollection, MutableCollection {}
 
 
 注意: Swift 的 Array 类型被桥接到 Foundation 中的 NSArray 类。
 */

//2.1  创建一个空数组，指定特定数据类型
Array<Int>() //方法一
[Int]()      //方法二  构造语法  类型被推断成指定数据类型


var someInts = [Int]()
someInts.append(3)
someInts = [] // 如果代码上下文中已经提供了类型信息, 就可以不用重新指定类型，直接使用 [] 来创建一个空数组  （eg: 一个函数参数;一个已经定义好类型的常量或者变量;）

//2.2  创建一个带有默认值的数组
/*
 public init(repeating repeatedValue: Element, count: Int)
 作用：创建特定大小并且所有数据都被默认的构造方法。
    count： 数据项数量
    repeating ： 适当类型的初始值
 
 */

var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles 被推断为 [Double]



//2.3  通过两个数组相加创建一个数组
/*
  + ：可以组合两种已存在的相同类型数组。
   新数组的类型：从两个数组的数据类型中推断出来。
 */

var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles 被推断为 [Double]

var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles 被推断为 [Double] , [0, 0, 0, 2.5, 2.5, 2.5]


//2.4  用数组字面量构造数组
var shoppingList: [String] = ["Eggs", "Milk"]
var shoppingLists = ["Eggs", "Milk"]  //类型推断
/*
 解释：
    shoppingList 变量 被声明为“字符串值类型的数组“,记作 [String]
 
 */



//2.5  访问和修改数组
/*
 方法一：数组的方法和属性
 方法二：下标语法
 
 */

shoppingList.count   // Int 获取数组中的数据项数量
shoppingList.isEmpty // Bool 检查 count 属性是否为 0
shoppingList.append("Flour") // 数组后面添加新的数据项
shoppingList += ["Cheese"]
shoppingList += ["Butter", "apple"] // += 数组后面添加拥有相同类型的数据项


var firstItem = shoppingList[0] //下标语法来获取数组中的数据项
shoppingList[0] = "Six eggs" //下标来改变某个已有索引值对应的数据值
shoppingList[3...5] = ["Bananas","Apples"] //用下标来一次改变一系列数据值,新数据和原有数据的数量可以不一样。
shoppingList

//注意:不可以用下标访问的形式去在数组尾部添加新项



shoppingList.insert("Maple Syrup", at: 0) // 在某个具体索引值之前添加数据项
let mapleSyrup = shoppingList.remove(at: 0) // 移除数组中的某一项,返回被移除的数据项。数组空出项会被自动填补
shoppingList
let apples = shoppingList.removeLast() //移除组中的最后一项,返回被移除的数据项
shoppingList


// 防止索引越界引发运行时错误：在使用某个索引之前，可以使用索引值和数组的 count 属性进行比较，来检验是否有效。


//2.6  数组的遍历
/*
    for-in
 
   public func enumerated() -> EnumeratedSequence<Array<Element>>
    返回一个由每一个数据项索引值和数据值组成的元组。
 */

for item in shoppingList {
    print(item)
}

for (index, value) in shoppingList.enumerated() { // 获得每个数据项的值和索引值
    print("Item \(String(index+1)) : \(value)")
}



//3.  集合
/*
    Sets
    
    没有确定顺序
    每个元素只出现一次
    类型相同
 
 注意:
    Swift 的 Set 类型被桥接到 Foundation 中的 NSSet 类。
 */

//3.1 集合类型的哈希值
/*
 一个类型为了存储在集合中,该类型必须是可哈希化的;
 也就是说,该类型必须提供一个方法来计算它的哈希值。
 
 
 Swift 的所有基本类型(比如 String , Int , Double 和 Bool )默认都是可哈希化的,可以作为集合的值的类型或者字典的键的类型。
 没有关联值的枚举成员值,默认也是可哈希化的。

 
 哈希值是 Int 类型;
 相等的对象哈希值必须相同;
    eg: a==b 必须 a.hashValue == b.hashValue
 
 注意：
 自定义的类型 作为集合的值的类型 或 字典的键的类型，需满足：自定义类型符合 Swift 标准库中的 Hashable 协议。
 符合 Hashable 协议的自定义类型：
    （1）需要提供一个类型为 Int 的可读属性 hashValue 。
    （2）自定义类型的 hashValue 属性返回的值，在同一程序的不同执行周期 或 不同程序之间不需要保持相同。
    
    因为 Hashable 协议符合 Equatable 协议,所以遵循该协议的类型也必须提供一个"是否相等"运算符( == )的实现。
 这个 Equatable 协议要求任何符合 == 实现的实例间都是一种相等的关系。也就是说,对于 a,b,c 三个值来 说, == 的实现必须满足下面三种情况:
         a == a (自反性)
         a == b 意味着 b == a (对称性)
         a == b && b == c 意味着 a == c (传递性)
 */

var name = "ss"
name.hashValue


//3.2  创建和构造一个空的集合
/*
 构造器语法
 
 
 如果上下文提供了类型信息,可以通过一个空的数组字面量创建一个空的 Set
 eg：作为函数的参数；已知类型的变量或常量；

 */
var letters = Set<Character>() //构造器语法   创建一个特定类型的空集合
// letters 类型推断为 Set<Character>
letters.insert("a")
letters = []   // letters 类型推断不变，为 Set<Character>  空的 Set


//3.3  用数组字面量创建集合

var favoriteGenres: Set<String> = ["Rock","Rock", "Classical", "Hip hop"]//重复自动过滤
// favoriteGenres 类型显式声明为 Set<String>


var favorites: Set = ["Rock","Rock", "Classical", "Hip hop"] //重复自动过滤
// favorites 显示声明为 Set ， 类型推断 Set 的具体类型为 Set<String>


//3.4  访问和修改一个集合
/*
 Set 的属性和方法
 
 public var count: Int { get }
 
 public var isEmpty: Bool { get }
 
 public mutating func insert(_ newMember: Element) -> (inserted: Bool, memberAfterInsert: Element)
 
 public mutating func remove(_ member: Element) -> Element?
 
 public mutating func removeAll(keepingCapacity keepCapacity: Bool = default)
 
 */
favoriteGenres.count   // Set 中元素的数量
favoriteGenres.isEmpty // 检查 count 属性是否为 0
favoriteGenres.insert("Jazz") // 添加一个新元素
favoriteGenres
favoriteGenres.remove("Rock") // 如果存在，删除该元素并返回被删除的元素值；否则返回 nil 。
favoriteGenres
favoriteGenres.removeAll() // 删除所有元素，返回一个空集合
favoriteGenres.contains("Rock") // 是否包含一个特定的值 , 返回 Bool


//3.5  遍历一个集合
/*
 for-in
 
 public func sorted() -> [Element]
 按'<'对 Set 元素排序，返回一个 Array 数组类型.
 
 */
for item in favorites {
    print("\(item)")
}

var abc: Set = ["c","e","a","b","d"]
abc
var abcSorted = abc.sorted() // 按'<'对元素排序，返回一个数组类型.
abcSorted  // 类型: [String]


//3.6  集合操作
/*
 
 把两个集合组合到一起,
 判断两个集合共有元素,
 判断两个集合是否全包含,
 部分包含或者不相交。
 
 
 public func union<S : Sequence where S.Iterator.Element == Element>(_ other: S) -> Set<Element>
 并集。
 
 public func intersection(_ other: Set<Element>) -> Set<Element>
 交集。
 
 public func subtracting(_ other: Set<Element>) -> Set<Element>
 去交集。
 
 public func symmetricDifference<S : Sequence where S.Iterator.Element == Element>(_ other: S) -> Set<Element>
 并集去交集。
 
 
 public func isSubset(of other: Set<Element>) -> Bool
 是否是子集合；可能相等
 public func isSuperset(of other: Set<Element>) -> Bool
 是否是父集合；可能相等
 
 public func isStrictSubset(of other: Set<Element>) -> Bool
 是否是子集合，且不相等
 public func isStrictSuperset(of other: Set<Element>) -> Bool
 是否是父集合，且不相等
 
 public func isDisjoint(with other: Set<Element>) -> Bool
 是否没有交集； true：没有交集；
 
 == ：判断两个集合是否包含全部相同的值。
 
 */

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted() //并集。根据两个集合的值创建一个新的集合

oddDigits.intersection(evenDigits).sorted() //交集。两个集合中都包含的值创建的一个新的集合。

oddDigits.subtracting(singleDigitPrimeNumbers).sorted() //去交集。根据不在该集合中的值创建一个新的集合。  oddDigits 中不在 singleDigitPrimeNumbers 的元素。

oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted() //并集去交集。在一个集合中但不在两个集合中的值创建一个新的集合。



let houseAnimals: Set = ["Pig"]
let farmAnimals: Set = ["Pig", "Duck", "Chicken"]
let cityAnimals: Set = ["Cat"]

houseAnimals.isSubset(of: farmAnimals) // Bool   是否是子集合；可能相等
farmAnimals.isSuperset(of: houseAnimals) // Bool  是否是父集合；可能相等

houseAnimals.isStrictSubset(of: farmAnimals)   //Bool  是否是子集合，且不相等
farmAnimals.isStrictSuperset(of: houseAnimals) //Bool  是否是父集合，且不相等

farmAnimals.isDisjoint(with: cityAnimals) // Bool 是否没有交集； true：没有交集；


//4.  字典
/*
 存储多个相同类型的值
 每 value 都关联唯一的 key
 数据项是无顺序的
 通过 key 访问数据
 
 
 Swift 的 Dictionary 类型被桥接到 Foundation 的 NSDictionary 类。
 */

//4.1  创建
//Dictionary<key, Value>()
//[Key: Value]()

var namesOfIntegers = [Int: String]()// 构造语法    创建一个空字典  [Int: String] 类型
namesOfIntegers[2] = "sixteen"
namesOfIntegers = [:]  // [Int: String] 类型的空字典
//如果上下文已经提供了类型信息, 可以使用空字典字面量来创建一个空字典,记作 [:]


var airports: [String: String] = ["ZBAA": "北京首都国际机场", "ZBNY": "北京南苑国际机场","ZHCC": "郑州新郑国际机场"]
var airs = ["ZBAA": "BeiJing", "ZHCC": "ZhengZhou"] // 类型推断：Dictionary<String, String> 类型


//4.2  访问和修改
/*
 字典的方法和属性
 下标语法  Key
 */

airports.count // 获取字典的数据项数量
airports.isEmpty // 检查 count 属性是否为 0

airports["LHR"] = "London" // 使用下标语法来添加新的数据项
airports["LHR"] = "London Heathrow" //使用下标语法来修改 Key 对应的 Value
airports

let oldValue = airports.updateValue("南苑国际机场", forKey: "ZBNY") // 更新 Key 对应的 Value     oldValue 类型： String?
airports.updateValue("xx", forKey: "ZBNX") // 返回 nil
// .updateValue 返回更新值之前的原值的可选值，如果不存在,返回 nil 。可以检查更新是否成功。
airports


//字典的下标访问 返回对应值的类型的可选值. 字典包含请求 Key 所对应的 Value,返回包含这个值的可选值,否则返回 nil
if let airportName = airports["DUB"] {
    print("机场名字是： \(airportName)")
}else{
    print("没有这个 Key 值 DUB ")
}


//可以使用下标语法, 通过给某个键的对应值赋值为 nil 来从字典里移除一个键值对 .
airports
airports["ZBNX"] = nil  // ZBNX 的 key-value 被移除了
airports
airports.removeValue(forKey: "LHR") // 移除 key-value; 并返回被移除的值; 或在没有值的情况下返回 nil ;
airports


//4.3  字典遍历
/*
 for-in
 返回 (key, value) 元组
 
 public var keys: LazyMapCollection<[Key : Value], Key> { get }
 获得所有的 key
 public var values: LazyMapCollection<[Key : Value], Value> { get }
 获得所有的 value
 */

for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}

for airportCode in airports.keys { // 遍历所有的 key
    print("AirportCode: \(airportCode)")
}

for airportName in airports.values { // 遍历所有的 value
    print("AirportCode: \(airportName)")
}













    