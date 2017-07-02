//
//  ViewController.swift
//  JSExport实现JS对系统对象的调用
//
//  Created by 孟跃平 on 2017/6/28.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

import UIKit
import JavaScriptCore

/// 自定义协议继承自 <JSExport>
//注意：@objc
@objc protocol MYPJSExport: JSExport {
    var text: String? {get set}
}

class ViewController: UIViewController {
    lazy var context: JSContext? = {
        let context = JSContext()
        return context
    }()
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context?.exceptionHandler = { (context, exception) in
            guard let exception = exception else { return }
            context?.exception = exception
            print("JS抛出错误：\(exception)")
        };
        let block: @convention(block) () -> () = {
            print("----Begin Log----")
            print("Thread.current: \(Thread.current)")
            
            let arguments = JSContext.currentArguments()
            guard let args = arguments else { return }
            var num = 1
            for arg in args {
                num += 1
                print("arg[\(num)]: \(arg)")
            }
            print("----End Log----")
        }
        context?.setObject(block, forKeyedSubscript: NSString(string: "log"))
        
        //为UITextField类动态添加协议
        class_addProtocol(UITextField.self, MYPJSExport.self)
    }
    
    @IBAction func btnClick() {
        context?.setObject(textField, forKeyedSubscript: NSString(string: "textField"))
        let _ = context?.evaluateScript("log(textField.text)")
        
        let script = "var num = parseInt(textField.text, 10); ++num; textField.text = num;"
        let _ = context?.evaluateScript(script)
        
        //注音：注意JS脚本调用OC/Swift是在子线程还是主线程，如果是更新原生UI，需要注意在主线程更新。
    }
}

