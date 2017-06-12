//
//  EmoticonManager.swift
//  Emoji
//
//  Created by apple on 2017/6/4.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 管理分组表情工具类，加载所有的表情数据。
 */

import UIKit

class EmoticonManager: NSObject {
// MARK: - 属性
    lazy var packages = [EmoticonPackages]()
    
// MARK: - 构造方法
    override init() {
        super.init()
        
        loadPackages() //加载本地表情文件，并完成数据模型转换
    }
    
    
// MARK: - 私有方法
    //加载分组表情包
    func loadPackages() {
        let path = Bundle.main.path(forResource: "emoticons", ofType: "plist", inDirectory: "Emoticons.bundle")
        guard let filePath = path else {
            print("文件路径错误")
            return
        }
        
        let dict = NSDictionary(contentsOfFile: filePath)!
        let array = dict["packages"] as! [[String : Any]]
        
        for item in array {
            let id = item["id"] as! String
            loadGroupPackages(id)
        }
    }
    
    fileprivate func loadGroupPackages(_ id: String) {
        let path = Bundle.main.path(forResource: "Info", ofType: "plist", inDirectory: "Emoticons.bundle/\(id)")
        guard let filePath = path else {
            print("文件路径错误！")
            return
        }
        
        let dict = NSDictionary(contentsOfFile: filePath)!
        let group_name_cn = dict["group_name_cn"] as! String
        let array = dict["emoticons"] as! [[String : String]]
        
        let p = EmoticonPackages(id: id, group_name_cn: group_name_cn, array: array)
        
        packages.append(p)
    }
    
}
