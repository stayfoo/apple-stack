//
//  Comman.swift
//  02-Weibo
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 swift中,在同一个命名空间下,所有的文件和方法以及属性全局共享。
 在 OC 中 pch 文件类似, 定义程序中非常常用的方法：常量。
 */

import UIKit

// MARK: - 尺寸相关
let kScreenBounds = UIScreen.main.bounds
let kScreenW = kScreenBounds.width
let kScreenH = kScreenBounds.height


// MARK: - 主题色
let kThemeColor = UIColor.orange


// MARK: - 接口 API
let k_oauth_url     = "https://api.weibo.com/oauth2/authorize"
let k_client_id     = "4137025574"
let k_redirect_uri  = "http://www.baidu.com/"
let k_client_secret = "48286e1870c9d5f14827eb56ddddfd5c"

