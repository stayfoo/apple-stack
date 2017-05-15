//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, 下标"


//1.  下标语法
/*
 subscript(index: Int) -> Int {
    get {
        // 返回一个适当的 Int 类型的值
    }
    set(newValue){
        // 执行适当的赋值操作
    }
 }
 
 只读下标
 subscript(index: Int) -> Int {
    // 返回一个适当的 Int 类型的值
 }
 */


struct TimesTable {
    let multiplier: Int
    
    //定义一个 只读下标,
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
//创建一个 TimesTable 实例, 表示整数 3 的乘法表
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])") // 可以通过下标访问 threeTimesTable 实例



//2.  下标用法
/*
 下标通常作为访问集合，列表或序列中元素的快捷方式。
 
 注意：
 Swift 的 Dictionary 类型的下标接受并返回可选类型的值。
 Dictionary 类型之所以如此实现下标，是因为不是每个键都有个对应的值，同时 这也提供了一种通过键删除对应值的方式，只需将键对应的值赋值为 nil 即可。
 */



//3.  下标选项
/*
 下标可以接受任意数量的入参，并且这些入参可以是任意类型。
 下标的返回值也可以是任意类型。
 下标可以使用变量参数和可变参数，但不能使用输入输出参数，也不能给参数设置默认值。
 
 
 下标的重载：
    一个类或结构体可以根据自身需要提供多个下标实现，使用下标时将通过入参的数量和类型进行区分，自动匹配合适的下标。
 */

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    //用来检查入参 row 和 column 的值 是否在矩阵范围内
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    // 接受两个入参的构造方法,入参分别是 rows 和 columns
    subscript(row: Int, column: Int) -> Double {
        get {
            //断言检查下标入参 row 和 column 的值是否有效
            assert(indexIsValidForRow(row: row, column: column),"Index out of range")
            
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            
            grid[(row * columns) + column] = newValue
        }
    }
}

//创建了一个 Matrix 实例来表示两行两列的矩阵
var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.0

//let someValue = matrix[2,2] //越界，触发断言





