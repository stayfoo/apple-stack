//
//  ViewController.swift
//  SwiftJavaScriptCore-JSExport
//
//  Created by 孟跃平 on 2017/6/28.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.
//

import UIKit
import JavaScriptCore

class ViewController: UIViewController {
    let obj: MYPObject = MYPObject()
    let context:JSContext = JSContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context.exceptionHandler = { (context, exception) in
            guard let exce = exception else { return }
            context!.exception = exce
            print("JS抛出exception: \(exce)")
        }
        let block: @convention(block) () -> () = {
            print("++++++Begin Log++++++")
            let args = JSContext.currentArguments()
            for jsVal in args! {
                print(jsVal)
            }
            print("---End Log------")
        }
        context.setObject(block, forKeyedSubscript: NSString(string: "log"))
        context.setObject(obj, forKeyedSubscript: NSString(string: "Swiftobj"))
        
        
        print(context.evaluateScript("log(Swiftobj.doNothing(5))"))
        print(context.evaluateScript("log(Swiftobj.squared(5))"))
        print(context.evaluateScript("log(Swiftobj.add(5,5))"))
        print(context.evaluateScript("log(Swiftobj.addWithNum(5))"))
        print(context.evaluateScript("log(Swiftobj.addWithNum1Num2(10,10))"))
        print(context.evaluateScript("log(Swiftobj.addWithNum1(10,10))"))
//        print(context.evaluateScript("log(Swiftobj.addWithNum2(10,10))")) // 'Swiftobj.addWithNum2' is undefined
        
        context.evaluateScript("Swiftobj.sum = Swiftobj.add(2,3)")
        print(context.evaluateScript("log(Swiftobj.sum)"))
        print("obj.sum: \(obj.sum)")
    }
}


