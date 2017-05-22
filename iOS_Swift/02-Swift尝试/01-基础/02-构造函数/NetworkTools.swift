//
//  NetworkTools.swift
//  01-基础
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 单例
 */

import Foundation

class NetworkTools: NSObject {
    
    var fileName: String?
    
    //简单写法
    static let shareTools: NetworkTools = NetworkTools()
    
    //复杂写法
    static let tools: NetworkTools = {
        let tool = NetworkTools() 
        tool.fileName = "xx"
        return tool
    }()
}


