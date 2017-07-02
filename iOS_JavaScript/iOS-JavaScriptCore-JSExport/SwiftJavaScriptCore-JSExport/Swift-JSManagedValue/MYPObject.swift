//
//  MYPObject.swift
//  Swift-JSManagedValue
//
//  Created by 孟跃平 on 2017/6/28.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

import UIKit
import JavaScriptCore

/// 自定义协议继承自 <JSExport>
@objc protocol MYPJSExport: JSExport {
    var managedValue: JSManagedValue? { get set }
}

@objc class MYPObject: NSObject, MYPJSExport {
    var text: String?
    
//    var managedValue: JSManagedValue = managedValue
    var managedValue: JSManagedValue? {
        willSet{
            print("newValue: \(String(describing: newValue))  |CurrentThread: \(Thread.current)")
        }
        didSet{
            print("oldValue: \(String(describing: oldValue))  |CurrentThread: \(Thread.current)")
        }
    }
    override init() {
        super.init()
    }
}

