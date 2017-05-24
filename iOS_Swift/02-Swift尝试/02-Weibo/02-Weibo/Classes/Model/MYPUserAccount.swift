//
//  MYPUserAccount.swift
//  02-Weibo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import UIKit

class MYPUserAccount: NSObject {
    var access_token: String?        //接口获取授权后的access token。
    var expires_in: TimeInterval = 0 //access_token的生命周期，单位是秒数。
    var uid: String?                 //当前授权用户的UID
    
    var name: String?         //友好显示名称
    var avatar_large: String? //用户头像地址（大图），180×180像素
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    // 过滤属性字段
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
