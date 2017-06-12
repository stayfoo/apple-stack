//
//  Emoticon.swift
//  Emoji
//
//  Created by apple on 2017/6/2.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 * 表情模型
 */

import UIKit

class Emoticon: NSObject {
// MARK: - 属性
    var id: String?      // 分组的文件夹名称, 用来拼接图片路径
    var chs: String?     // 表情字符串, 发送给服务器
    var png: String?     // 表情图片, 本地显示用
    var code: String?    // Emoji 表情的十六进制的字符串
    var isDelete = false // 标记是否是删除按钮
    var isEmpty = false  // 标记是否是空表情
    
    var imagePath: String? {
        let path = Bundle.main.bundlePath + "/Emoticons.bundle/" + "\(id ?? "")" + "/\(png ?? "")"
		return path
    }
    
    var emojiStr: String? { // 将 Emoji 表情的十六进制的字符串转换成表情unicode编码字符
        return (code ?? "").emojiStr()
    }
    
// MARK: - 构造方法
    
    init(dict: [String : String]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    ///删除表情的实例化方法
    init(isDelete: Bool) {
        self.isDelete = isDelete
        super.init()
    }
    
    ///空表情的实例化方法
    init(isEmpty: Bool) {
        self.isEmpty = isEmpty
        super.init()
    }
    
    //过滤
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
    override var description: String {
        let keys = ["chs", "png", "code"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
