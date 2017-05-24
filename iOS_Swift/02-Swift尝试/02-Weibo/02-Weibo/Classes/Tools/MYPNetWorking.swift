//
//  MYPNetWorking.swift
//  02-Weibo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/// 网络工具类封装

import UIKit
import Alamofire

class MYPNetWorking: NSObject {
    
// MARK: - 单例
    static let sharedManager: MYPNetWorking = {
        let manager = MYPNetWorking()
        
        return manager
    }()
    
    
// MARK: - get 方法
    func get(_ url: String, _ parameters: [String: Any], _ completionHandler: @escaping (HTTPURLResponse?, Result<String>) -> Void) {
        
        let param: Parameters? = parameters as Parameters
        
        let request = Alamofire.request(url, method: .get, parameters: param)
        request.responseString { response in
            if let error = response.error {
                print("网络请求报错：\(error)")
                return
            }
            
            
            completionHandler(response.response, response.result)
        }
    }
    
}
