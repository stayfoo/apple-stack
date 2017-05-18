//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, 字符串 、字符"

//1. 字符串
/*
 字符串是有序的 Character (字符)类型的值的集合。
 
 
 （1）Swift 的 String 和 Character 类型提供了快速和兼容 Unicode 的方式供你的代码使用。
 
 （2）字符串连接操作只需要简单地通过 + 符号将两个字符串相连即可。
 
 （3）与 Swift 中其他值一样,能否更改字符串的值,取决于其被定义为常量还是变量。
 
 （4）String 类型是一种快速、现代化的字符串实现。 
    每一个字符串都是由编码无关的 Unicode 字符组成, 并支持访问字符的多种 Unicode 表示形式(representations)。
 
 
 （5）注意:
     Swift 的 String 类型与 Foundation NSString 类进行了无缝桥接。
     Foundation 也可以对 String 进行扩展, 暴露在 NSString 中定义的方法。
     这意味着,如果你在 String 中调用这些 NSString 的方法,将不用进行 转换。
 */

let a = "aaa"
var b = "bbb"


//2. 字符串字面量
/*
 字符串字面量：是由双引号 ( "" ) 包裹着的具有固定顺序的文本字符集。
 
 作用：为常量和变量提供初始值。
 
 */

let someString = "literal value"
//解释：someString 常量通过字符串字面量进行初始化，Swift 会推断该常量为 String 类型。



//3. 初始化空字符串
/*
 方法一：  ""
 方法二：  String()     初始化一个空的 String 实例
 
 */

var emptyString = ""    //空字符串字面量
var anotherEmptyString = String()  //初始化方法
//两个字符串均为空，且等价。

if emptyString.isEmpty { // String 实例的 isEmpty 属性，判断字面量是否为空
    print("Nothing to see here")
}


//4. 字符串可变性
/*
 通过将一个特定字符串分配给一个 变量 来对其进行修改；
 通过将一个特定字符串分配给一个 常量 来保证其不会被修改。
 
 */
var variableString = "Horse"
variableString += " and carriage"

let constantString = "Highlander"
//constantString += " and another Highlander" //编译错误 (compile-time error)


//5. 字符串是值类型
/*
 Swift 的 String 类型是值类型。（结构体和枚举是值类型）
 
 
 （1）如果您创建了一个新的字符串, 那么当其进行常量、变量赋值操作, 或在函数/方法中传递时,会进行值拷贝。任何情况下,都会对已有字符串值创建新副本,并对该新副本进行传递或赋值操作。
    （在对字符串 “操作”、“传递”过程中，会进行值拷贝，创建新副本。即值传递）
 
 （2）Swift 默认字符串拷贝的方式保证了在函数/方法中传递的是字符串的值。
    很明显无论该值来自于哪里,都是您独自拥有的。 您可以确信传递的字符串不会被修改,除非你自己去修改它。
    （在字符串“传递”过程中，传递的字符串不会被修改 --除非自己主动修改。）
 
 （3）在实际编译时, Swift 编译器会优化字符串的使用, 使 “实际的复制只发生在绝对必要的情况下” , 这意味着您将字符串作为值类型的同时可以获得极高的性能。
 */



//6. 使用字符
/*
 （1）可通过 for-in 循环来遍历字符串中的 characters 属性来获取每一个字符的值。
 
 （2）通过标明一个 Character 类型并用字符字面量进行赋值, 可以建立一个独立的字符常量或变量。
 
 （3）字符串可以通过传递一个值类型为 Character 的数组作为自变量来初始化。
 
 */
for character in "Dog!?".characters {
    print(character)
}

let exclamationMark: Character = "!"

let catCharacters: [Character] = ["C","a","t","!","?"]
let catString = String(catCharacters)
print(catString)



//7. 连接字符串和字符
/*
 （1）通过 + “连接” 创建一个新的字符串。
 （2）通过 += 将一个字符串添加到一个已经存在字符串变量上。
 （3）用 append() 方法将一个 字符 附加到一个字符串变量的尾部。
 
 （4）不能将一个字符串或者字符添加到一个已经存在的字符变量上, 因为字符变量只能包含一个字符。
 */

let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2

var instruction = "look over"
instruction += string2

let exclamationMarking: Character = "!"
welcome.append(exclamationMarking)
welcome += "!"
//welcome += exclamationMarking //编译报错



//8. 字符串插值
/*
 一种构建新字符串的方式, 可以在其中包含常量、变量、字面量和表达式。 
 
    \()
 
 
 （1）括号中的表达式 不能包含： “非转义反斜杠 ( \ )” , “回车” , “换行符”。
 （2）插值字符串可以包含其他字面量。
 */

let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
print(message) //3 times 2.5 is 7.5



//9. Unicode
/*
  Swift 的 String 和 Character 类型完全兼容 Unicode 标准的。
 */

//9.1  Unicode 标量
/*
 Unicode 标量是对应字符或者修饰符的唯一的21位数字。
 
 Swift 的 String 类型是基于 Unicode 标量建立的。
 
 注意: 
 Unicode 码位(code poing) 的范围是 U+0000 到 U+D7FF 或者 U+E000 到 U+10FFFF 。
 Unicode 标量不包括 Unicode 代理项(surrogate pair) 码位,其码位范围是 U+D800 到 U+DFFF 。
 
 不是所有的21位 Unicode 标量都代表一个字符,因为有一些标量是留作未来分配的。
 已经代表一个典型字符的标量都有自己的名字。
 */


//9.2  字符串字面量的特殊字符
/*
 转义字符：
     \0   (空字符)
     \\   (反斜线)
     \t   (水平制表符)
     \n   (换行符)
     \r   (回车符)
     \"   (双引号)
     \'   (单引号)
 
 Unicode 标量：
    \u{n} 
    其中，
        u为小写, n 为任意一到八位十六进制数且可用的 Unicode 位码。
 */

let wiseWords = "\"Imageination is more important than knowledge\" - Einstein"
let dollarSign = "\u{24}"        // $ , Unicode 标量 U+0024
let blackHeart = "\u{2665}"      // ♥ , Unicode 标量 U+2665
let sparklingHeart = "\u{1F496}" // 💖 , Unicode 标量 U+1F496


//9.3  可扩展的字形群集
/*
 每一个 Swift 的 Character 类型代表一个可扩展的字形群。
 一个可扩展的字形群是一个或多个可生成人类可读 的字符 Unicode 标量的有序排列。
 
 
 */

let eAcute: Character = "\u{E9}"  // é  包含一个单一标量
let combinedEAcute: Character = "\u{65}\u{301}" // é  包含两个标量的字形群
"\u{65}"  // e     U+0065
"\u{301}" //  ́     U+0301

/*
 解释：
    （1）在这两种情况中,字母 é 代表了一个单一的 Swift 的 Character 值,
            同时代表了一个可扩展的字形群。
    （2）在第一种情况, 这个字形群包含一个单一标量;  
        而在第二种情况,它是包含两个标量的字形群。

 */

/*
 可扩展的字符群集是一个灵活的方法, 用许多复杂的脚本字符表示单一的 Character 值。
 例如,来自朝鲜语字母表的韩语音节能表示为组合或分解的有序排列。 在 Swift 都会表示为同一个单一的 Character 值。
 */

let precomposed: Character = "\u{D55C}"  // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"  // 한
"\u{1112}" // ᄒ
"\u{1161}" // ᅡ
"\u{11AB}" // ᆫ


/*
 可拓展的字形群集 可以使 包围记号的标量 包围其他 Unicode 标量, 作为一个单一的 Character 值。
    ⃝ 包围了 é ，结果是： é⃝
 */
let enclosedEAcute: Character = "\u{E9}\u{20DD}" // é⃝
" \u{20DD} "          //  ⃝
print(enclosedEAcute) // é⃝

/*
 地域性指示符号 相关的 Unicode 标量可以组合成一个单一的 Character 值。
 
 */
let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
"\u{1F1FA}" // 🇺
"\u{1F1F8}" // 🇸
"\u{43}\u{48}\u{4e}"




//10. 计算字符数量
/*
 （1）如果想要获得一个字符串中 Character 值的数量,可以使用字符串的 characters 属性的 count 属性。
 
 （2）注意在 Swift 中, 使用可拓展的字符群集作为 Character 值来连接或改变字符串时,并不一定会更改字符串的字符数量。
 
 注意:
     可扩展的字符群集 可以组成一个或者多个 Unicode 标量。
     这意味着不同的字符以及相同字符的不同表示方式可能需要不同数量的内存空间来存储。
     所以 Swift 中的字符在一个字符串中并不一定占用相同的内存空间数量。
     因此在没有获取字符串的可扩展的字符群的范围时候, 就不能计算出字符串的字符数量。
     如果您正在处理一个长字符串,需要注意 characters 属性必须遍历全部的 Unicode 标量,来确定字符串的字符数量。

    即：一个字符可以用不同方式表示，占用内存空间数量不一定相同，需要遍历全部的 Unicode 标量才能确定字符串的字符数量真实值。
 
 
 
 另外需要注意：
    通过 .characters.count 属性返回的字符数量并不总是与包含相同字符的 NSString 的 length 属性相同。 
    NSString 的 length 属性是利用 UTF-16 表示的十六位代码单元数字，,而不是 Unicode 可扩展的字符群集。
    证明：当一个 NSString 的 length 属性被一个 Swift 的 String 值访问时，实际上是调用了 utf16.count 。

 */

let unusualMenagerie = "Koala ?,"
unusualMenagerie.characters.count  // 8 ，空格算一个
print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")

var word = "cafe"
word.characters.count  // 4
word += "\u{301}"      // café
word.characters.count  // 4  字符串变了, .characters.count获得的字符数量没变
word.utf16.count       // 5


//11. 访问和修改字符串
/*
 方法一：通过字符串的属性和方法来访问和修改它。
 方法二：用下标语法完成。
 
 */

//11.1  字符串索引

/*
 每一个 String 值都有一个关联的索引(index)类型,  String.Index , 
 它对应着字符串中的每一个 Character 的位置。
 Swift 的字符串不能用整数(integer)做索引。
 
 
 
 
 .startIndex ：获得一个 String 的第一个 Character 的索引。
 .endIndex  ：获取一个 String 的最后一个 Character 的后一个位置的索引。 
        所以 .endIndex属性不能作为一个字符串的有效下标。
 如果 String 为空串，.startIndex 和 .endIndex 是相等的
 
 
 public func index(before i: String.Index) -> String.Index
 public func index(after i: String.Index) -> String.Index
 通过 String 的这两个方法，可以获取给定索引前面或后面的一个索引。
 
 public func index(_ i: String.Index, offsetBy n: String.IndexDistance) -> String.Index
 获取对应偏移量的索引。
 
 
 */

let greeting = "Guten Tag!"
greeting[greeting.startIndex]  // G
greeting[greeting.index(before: greeting.endIndex)]  // !
greeting[greeting.index(after: greeting.startIndex)] // u

let index = greeting.index(greeting.startIndex, offsetBy: 1) // 1
greeting[index]   // u

//greeting[greeting.endIndex] //试图获取越界索引对应的 Character ,将引发一个运行时错误。


//使用 characters 属性的 indices 属性会创建一个包含全部索引的范围(Range),用来在一个字符串中访问单个字符。

for index in greeting.characters.indices {
    print("\(greeting[index])",terminator: " ") // G u t e n   T a g !
}


/*
 注意:
 您可以使用 startIndex 和 endIndex 属性
 或者 index(before:) 、 index(after:) 和 index(_:offsetB y:) 方法 
 在任意一个确认的并遵循 Collection 协议的类型里面, 如上文所示是使用在 String 中,您也可以使用在 Array 、 Dictionary 和 Set 中。
*/



//11.2  插入和删除
/*
 public mutating func insert(_ newElement: Character, at i: String.Index)
 方法作用：在一个字符串的指定索引插入一个字符
 
 public mutating func insert<S : Collection where S.Iterator.Element == Character>(contentsOf newElements: S, at i: String.Index)
 方法作用：在一个字符串的指定索引插入一个段字符串。
 
 
 public mutating func remove(at i: String.Index) -> Character
 方法作用：在一个字符串的指定索引删除一个字符
 
 public mutating func removeSubrange(_ bounds: Range<String.Index>)
 方法作用：在一个字符串的指定索引删除一个子字符串。
 
 */

var well = "hello"
well.insert("!", at: well.endIndex)
well.insert(contentsOf: " there".characters, at: well.index(before: well.endIndex))


well.remove(at: well.index(before: well.endIndex)) //返回被移除的字符  !
well  // hello there

let range = well.index(well.endIndex, offsetBy: -6)..<well.endIndex
well.removeSubrange(range)

/*
 注意: 
 您可以使用 insert(_:at:) 、 insert(contentsOf:at:) 、 remove(at:) 和 removeSubrange(_:) 方法 
 在任意一个确认的并遵循 RangeReplaceableCollection 协议的类型里面,
 如上文所示是使用在 String 中,您也可以使用在 Array、Dictionary 和 Set 中。
 */




//12.  比较字符串
/*
 Swift 提供了三种方式来比较文本值:
    字符串字符相等、前缀相等和后缀相等。
 
 */

/*
 字符串/字符相等
    ==    !=
 
 
 如果两个字符串(或者两个字符)的可扩展的字形群集是”标准相等“的,那就认为它们是相等的。
 在这个情况下,即使可扩展的字形群集是有不同的 Unicode 标量构成的,只要它们有同样的“语言意义“和”外观“,就认为它们”标准相等“。
 */
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    print("两个字符串相等。。")
}


let eAcuteQuestion = "这个：caf\u{E9}"
let combinedEAcuteQuestion = "这个：caf\u{65}\u{301}"
if eAcuteQuestion == combinedEAcuteQuestion {
    print("只要语言意义和外观一样，Unicode 不同，也是相等")
}


let latinCapitalLetterA: Character = "\u{41}"      // A  英语
let cyrillicCapitalLetterA: Character = "\u{0410}" // A  俄语
if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("not equivalent, 字形一样，但有不同的语言意义, 不相等")
}


/*
 注意： 在 Swift 中,字符串和字符并不区分地域(not locale-sensitive)。
 */


/*
 前缀/后缀相等
 
 public func hasPrefix(_ prefix: String) -> Bool
 检查字符串是否拥有特定前缀 , 并返回一个布尔值。
 
 public func hasSuffix(_ suffix: String) -> Bool
 检查字符串是否拥有特定后缀 , 并返回一个布尔值。
 
 
 比较过程：都是在每个字符串中逐字符比较其可扩展的字符群集是否标准相等。
 */

let studentsAndSubjects = [
    "Sun Tom  : Chinese, English",
    "Sun Jim  : English, Math",
    "Sun Jack : Chinese, Math",
    "Sun Lucy : Math, English",
    "Sun Rose : Math, English",
    "Mon Aaron: Chinese, Math"
]

var sunCount = 0
for item in studentsAndSubjects {
    if item.hasPrefix("Sun") {
        sunCount += 1
    }
}
print("星期天人数：\(sunCount)")

var mathLastClassCount = 0
for item in studentsAndSubjects {
    if item.hasSuffix("Math") {
        mathLastClassCount += 1
    }
}
print("最后一节课是Math有 \(mathLastClassCount) 个.")



//13.  字符串的 Unicode 表示形式

/*
 利用 for-in 来对字符串进行遍历,从而以 Unicode 可扩展的字符群集的方式访问每一个 Character 值.
 
 其他三种 Unicode 兼容的方式访问字符串的值:
     UTF-8 代码单元集合 (利用字符串的 utf8 属性进行访问)
     UTF-16 代码单元集合 (利用字符串的 utf16 属性进行访问)
     21位的 Unicode 标量值集合,也就是字符串的 UTF-32 编码格式 (利用字符串的 unicodeScalars 属性进行 访问)

 */







