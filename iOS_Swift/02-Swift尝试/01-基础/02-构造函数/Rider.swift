//
//  Rider.swift
//  01-基础
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import Foundation

class Rider: NSObject {
    
    var _name: String?
    
    
    var name: String? {
        didSet {
            print(name!)
        }
    }
    
    var title: String? {
        get {
            return "boss: \(self.name)"
        }
    }
    
    
}
