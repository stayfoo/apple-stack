//
//  ViewController.swift
//  01-基础
//
//  Created by apple on 2017/5/19.
//  Copyright © 2017年 MengYP. All rights reserved.
//


/*
 Swift中，没有使用的变量也会警告;
 
 print = NSLog ;
 
 不支持隐式转换, 不同的类型的变量不能够直接进行运算;
 Bool 只有true 和 false ，没有非零即真;
 
 Swift: String  是结构体  效率更高    支持字符串的遍历
 OC :   NSString 继承 NSObject 是对象  不支持遍历的
 
 函数只是闭包的一种特殊形式;
 
 swift 中的 '闭包' 和 OC中的 block 是类似的：
    1>.提前准备好的一段可以执行的代码
    2>.可以当做参数进行传递
    3>.在需要的时候执行闭包  完成回调
    4>.在闭包中 使用self  需要注意 循环引用
 
 闭包就是一段匿名函数;
 
 */
import UIKit

class ViewController: UIViewController {

    // MARK: - 初始化
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        demo1()
//        demo2()
//        demo3()
        
        loadData { (dataString) in
            print(dataString)
        }
        
        
    }
    
    // MARK: - 私有方法
    func loadData(_ finished: @escaping (_ dataString: String) -> ()) {
//        public class func global(priority: DispatchQueue.GlobalQueuePriority) -> DispatchQueue
//        public class func global(qos: DispatchQoS.QoSClass = default) -> DispatchQueue

        //异步加载数据
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            //执行耗时任务
            print("加载数据")
            
            //回到主线程
            DispatchQueue.main.async {
                
                //执行回调
                finished("hello world")
                
                print("执行回调")
            }
        }
    }
    
    
    
    func d1() -> () {
        print("没有返回值")
    }
    func d2() -> Void {
        print("没有返回值")
    }
    func d3() {
        print("没有返回值")
    }
    
    
    
    
    // MARK: 字符串
    func demo3() {
        //一个中文的字符长度是 3
        let str = "你好"
        let len = str.lengthOfBytes(using: String.Encoding.utf8)
        print("len: \(len)") // 6
        
        let count = str.characters.count
        print("count: \(count)") // 2
        
        for s in str.characters {
            print("s: \(s)")
        }
        
        //字符串的截取
        //as 表示将 String 转换为 NSString
        let subStr = str.substring(from: str.index(str.startIndex, offsetBy: 1))
        print("subStr: \(subStr)")
        
        let subStr2 = (str as NSString).substring(with: NSMakeRange(1, 1))
        print("subStr2: \(subStr2)")
    }
    
    // MARK: ??
    func demo2() {
        /*
         ??
         快速判断是否为空 , 并且指定为空的情况的默认值, 如果不为空取指定值
         用于可选类型
         */
        let a: Int? = 0
        let b = (a ?? 0) + 10
        print(b)
    }
    
    
    // MARK: 字符串转码
    func demo1() {
        /*
         public init?(string: String)
         可失败构造器，返回一个可选类型，可能是 nil
         */
        let urlString = "http://www.douniwan.com?type=中国"  //包含了非法字符：中国
        let escapedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        print("1 " + escapedUrlString!) // http:%2F%2Fwww.douniwan.com%3Ftype=%E4%B8%AD%E5%9B%BD
        
        let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print("2 " + escapedString!) // http://www.douniwan.com?type=%E4%B8%AD%E5%9B%BD
        
        
        let url = URL(string: escapedUrlString!)
        /*
         print(url!)
         报错：
         如果可选类型为 nil，强制解包报错
         fatal(致命) error: unexpectedly found nil while unwrapping(解包) an Optional value
         */
        if url != nil {
            let request = URLRequest(url: url!)
            print(request)
        }
        
        if let url = URL(string: escapedUrlString!) {
            let request = URLRequest(url: url)
            print(request)
        }
        
        guard let urlTemp = URL(string: escapedUrlString!) else {
            //能够进入该分支 urlTemp 一定没有值, 终止分支的执行
            return
        }
        let request = URLRequest(url: urlTemp)
        print(request)
        
    }
}

