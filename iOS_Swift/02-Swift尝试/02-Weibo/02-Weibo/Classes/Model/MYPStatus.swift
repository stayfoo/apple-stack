//
//  MYPStatus.swift
//  02-Weibo
//
//  Created by apple on 2017/5/27.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 *  微博模型
 */

import UIKit

class MYPStatus: NSObject {
// MARK: - 属性
    var created_at: String?   //微博创建时间
    var id: Int = 0           //微博ID
    var text: String?         //微博正文
    var source: String?       //微博来源
    var user: MYPUser?        //添加user属性
    
    //配图数组属性
    var pic_urls: [[String : String]]? {
        didSet {
            guard let urls = pic_urls else {
                //终止set操作
                return
            }
            imageURLs = [URL]() //实例化 
            
            for item in urls {
                let urlString = item["thumbnail_pic"]
//                let largeString = urlString?.replacingOccurrences(of: "thumbnail", with: "bmiddle")
                let url = URL(string: urlString!)!
                imageURLs?.append(url)
            }
        }
    }
    var imageURLs: [URL]?
  
    
// MARK: - 构造方法
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "user" {
            if let dict = value as? [String : AnyObject] {
                user = MYPUser(dict: dict)  //字典转模型
            }
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
    //过滤
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    //重写description 属性
    override var description: String {
        let keys = ["created_at","id","text","source"]
        return dictionaryWithValues(forKeys: keys).description
    }
    
}
