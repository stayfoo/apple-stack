//
//  String+Emoticon.swift
//  Emoji
//
//  Created by apple on 2017/6/2.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import Foundation

extension String {
    
    func emojiStr() -> String {
        
        let scanner = Scanner(string: self)
        
        //将扫描字符串的结果 输出到某一个地址下
        var value: UInt32 = 0
        scanner.scanHexInt32(&value)
        
        //将十六进制的数据转换为 unicode 编码字符
        let c = Character(UnicodeScalar(value)!)
        
        return "\(c)"
    }
}
