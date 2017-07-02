//
//  ViewController.swift
//  Swift-JSManagedValue
//
//  Created by 孟跃平 on 2017/6/28.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

import UIKit
import JavaScriptCore

class ViewController: UIViewController {
    let obj = MYPObject()
    let context = JSContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context?.exceptionHandler = { (context, exception) in
            guard let exce = exception else { return }
            context!.exception = exce
            print("JS抛出exception: \(exce)")
        }
        
        context?.setObject(obj, forKeyedSubscript: NSString(string: "SwiftObj"))
        let _ = context?.evaluateScript("function callback(){};")
        
        // 用 JSManagedValue来保存 JSValue
        // 把JS对象存储为全局属性，方便OC下次调用JS
        obj.managedValue = JSManagedValue.init(value: context?.objectForKeyedSubscript("callback"))
        context?.virtualMachine.addManagedReference(obj.managedValue, withOwner: self)
        print("obj.managedValue.value: \(String(describing: obj.managedValue?.value))")
        
        
        //注意：只有在协议中定义的方法和属性才能够在JS中被调用。
        let _ = context?.evaluateScript("SwiftObj.text = '测试';")
        print("obj.text: \(String(describing: obj.text))") // obj.text: nil
    }
}

