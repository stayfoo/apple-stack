//
//  MYPFileManager.swift
//  02-Weibo
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 * 文件处理
 *
 */

import UIKit

class MYPFileManager: NSObject {
    
    // 存储
    class func sava(key: String, value: String, to plistPath: String?) {
        
        guard let toPlistPath = plistPath else {
            print("要保存的路径为空")
            return
        }
        let isExists = FileManager.default.fileExists(atPath: toPlistPath)
        if isExists {
            
            guard let dict = NSDictionary(contentsOfFile: toPlistPath) else {
                return
            }
            if let _ = dict.object(forKey: key) {
                
                dict.setValue(value, forKey: key)
                NSDictionary(dictionary: dict).write(toFile: toPlistPath, atomically: true)
            }
        } else {
            let dict = [key: value]
            NSDictionary(dictionary: dict).write(toFile: toPlistPath, atomically: true)
        }        
    }
    
    // 获取
    class func get(key: String, from plistPath: String) -> String?{
        
        let isExists = FileManager.default.fileExists(atPath: plistPath)
        if isExists {
            guard let dict = NSDictionary(contentsOfFile: plistPath) else {
                return nil
            }
            if let value = dict.object(forKey: key) {
                return (value as! String)
            }
        }
        return nil
    }

    
}
