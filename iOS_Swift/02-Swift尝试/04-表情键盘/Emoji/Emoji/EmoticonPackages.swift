//
//  EmoticonPackages.swift
//  Emoji
//
//  Created by apple on 2017/6/2.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 *  分组模型
        把表情规整，每隔20个插入一个删除表情。不足21的倍数，使用空表情填充。
 *
 规则：
    每隔20个按钮需要一个删除按钮；
    页面表情不足21个需要不足空表情；
    点击分组跳转到指定分组起始位置；
 */

import UIKit

class EmoticonPackages: NSObject {
// MARK: - 属性
    lazy var emoticons = [Emoticon]()  //表情模型数组
    
    var id: String?
    var group_name_cn: String?
    
    
// MARK: - 构造方法
    
    init(id: String, group_name_cn: String, array: [[String : String]]) {
        self.id = id
        self.group_name_cn = group_name_cn
        
        super.init()
        
        var index = 0
        for item in array {
            
            let e = Emoticon(dict: item)
            e.id = id
            emoticons.append(e)
            index += 1
            
            if index == 20 { //插入删除按钮
                let delete = Emoticon(isDelete: true)
                emoticons.append(delete)  // 添加删除表情
                index = 0    // 恢复标记
            }
        }
        //判断每页是否有21个表情  如果不足21个 需要补足空表情
        insertEmptyEmoticon()
    }
    
// MARK: - 私有方法
    fileprivate func insertEmptyEmoticon() {
        let delta = emoticons.count % 21
        if delta == 0 { // 判断是否需要插入空表情
            return
        }
        
        print("需要补足的空表情：\(21 - delta)")
        for _ in delta..<20 { //添加空表情
            let e = Emoticon(isEmpty: true)
            emoticons.append(e)
        }
        //添加删除表情
        emoticons.append(Emoticon(isDelete: true))
    }
    
}
