//
//  ViewController.swift
//  JavaScriptCore-SwiftExecuteJS
//
//  Created by 孟跃平 on 2017/6/19.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

/*
 * 使用JavaScriptCore执行一段JavaScript代码
 *
 * 使用OC的Block定义js函数。
 */

import UIKit
import JavaScriptCore

class ViewController: UIViewController {
    
    lazy var context = JSContext()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: 初始化JSContext对象及异常处理
        context.exceptionHandler = { (context, exception) in
            guard let excep = exception else {
                return
            }
            print(excep)
            /*
             此处打印js异常错误，JSContext不会主动抛出js异常。
             常见异常：
             ReferenceError: Can't find variable:
             TypeError: undefined is not an object
             */
            context?.exception = excep
        }
        
        // MARK: 执行带返回结果js脚本
        let jsStr1 = "1+2"
        let jsvalue1 = context.evaluateScript(jsStr1)
        print("value1 JS: \(String(describing: jsvalue1))  -> Swift: \(String(describing: jsvalue1?.toNumber()))")
        // value1 JS: Optional(3)  -> Swift: Optional(3)
        
        
        // MARK: 执行不带返回结果js脚本
        let jsStr2 = "var a = 1; var b = 2;"
        let jsvalue2 = context.evaluateScript(jsStr2)
        print("value2 JS: \(String(describing: jsvalue2))  -> Swift: \(String(describing: jsvalue2?.toObject))");
        //value2 JS: Optional(undefined)  -> Swift: Optional((Function))
        
        
        // MARK: 取出js脚本执行后存储在JSContext对象中的变量
        let jsValueA = context.objectForKeyedSubscript("a")
        let jsValueB = context.objectForKeyedSubscript("b")
        NSLog("JS a: \(String(describing: jsValueA));  JS b: \(String(describing: jsValueB))") //  JS a: Optional(1);  JS b: Optional(2)
        
        
        // MARK: 取出存储的js变量，并修改
        let jsStr3 = "var arr = [88, 'mengyueping', 66];"
        let value3 = context.evaluateScript(jsStr3)
        let jsArr = context.objectForKeyedSubscript("arr")
        print("value3 JS: \(String(describing: value3))  -> Swift: \(String(describing: value3?.toObject))");
        // value3 JS: Optional(undefined)  -> Swift: Optional((Function))
        print("JS Array: \(String(describing: jsArr));  Length: \(String(describing: jsArr?.objectForKeyedSubscript("length"))); jsArr[0]：\(String(describing: jsArr?.objectAtIndexedSubscript(0)))" )
        // JS Array: Optional(88,mengyueping,66);  Length: Optional(3); jsArr[0]：Optional(88)
        jsArr?.setValue("www.", at: 0)
        jsArr?.setValue(".com", at: 2)
        print("通过下标对js取值赋值：JS Array: \(String(describing: jsArr));  Length: \(String(describing: jsArr?.objectForKeyedSubscript("length"))); jsArr[0]：\(String(describing: jsArr?.objectAtIndexedSubscript(0)))" )
        // 通过下标对js取值赋值：JS Array: Optional(www.,mengyueping,.com);  Length: Optional(3); jsArr[0]：Optional(www.)
        
        
        // MARK: 取出存储的js集合对象，并转为Swift数组对象
        let swiftArr = jsArr?.toArray()
        print("js Arr -> Swift Arr: \(String(describing: swiftArr))");
        /*
         js Arr -> Swift Arr: Optional([www., mengyueping, .com])
         */
        
        
        // MARK: 取出存储的js集合对象，并直接使用Swift对象给js对象赋值
        jsArr?.setValue(8, at: 8)
        print("通过下标对js取值赋值：JS Array: \(String(describing: jsArr));  Length: \(String(describing: jsArr?.objectForKeyedSubscript("length"))); jsArr[0]：\(String(describing: jsArr?.objectAtIndexedSubscript(0)))" )
        // 通过下标对js取值赋值：JS Array: Optional(www.,mengyueping,.com,,,,,,8);  Length: Optional(9); jsArr[0]：Optional(www.)
        print("js Arr -> Swift Arr: \(String(describing: jsArr?.toArray()))")
        /*
         js Arr -> Swift Arr: Optional([www., mengyueping, .com, <null>, <null>, <null>, <null>, <null>, 8])
         */
        
        
        // MARK: 取出存储的js函数，并执行
        context.evaluateScript("function add(a, b){ return a + b; }")
        let addValue = context.objectForKeyedSubscript("add") // js函数
        print("Func: \(String(describing: addValue))")  // Func: Optional(function add(a, b){ return a + b; })
        // 取出js函数，调用函数 open func call(withArguments arguments: [Any]!) -> JSValue!
        let sum = addValue?.call(withArguments:[1,2])
        print("Sum: \(String(describing: sum?.toInt32()))") // Sum: Optional(3)
        
        
        // MARK:  调用js函数的另一种简单方法
        let jsValue = context.evaluateScript("function multiply(a, b){ return a * b; }")
        let multiplyValue = jsValue?.context.globalObject.invokeMethod("multiply", withArguments: [3,6])
//        let multiplyValue = context.globalObject.invokeMethod("multiply", withArguments: [3,6])
        print("multiplyValue: \(String(describing: multiplyValue?.toInt32()))"); // multiplyValue: Optional(18)
        
        
        // MARK: 把OC中Closure转换成JS函数，并存储到JSContext对象
        let block: @convention(block) () -> () = {
            print("++++++Begin Log++++++")
            
            let args = JSContext.currentArguments()
            
            for jsVal in args! {
                print(jsVal)
            }
            
            let this = JSContext.currentThis()
            print("this: \(String(describing: this))")
            
            print("---End Log------")
        }
        context.setObject(block, forKeyedSubscript: NSString(string: "log"))
        // 执行js，调用使用Block自定义的js函数
        context.evaluateScript("log('mengyueping', [10,20], {'hello': 'world', 'number': '100'})")
        /*
         ++++++Begin Log++++++
         mengyueping
         10,20
         [object Object]
         this: Optional([object GlobalObject])
         ---End Log------
         */
        
    }
    

}

