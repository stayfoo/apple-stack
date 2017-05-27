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

// MARK: - 系统
    // MARK: 尺寸相关
    let kScreenBounds = UIScreen.main.bounds
    let kScreenW      = UIScreen.main.bounds.width
    let kScreenH      = UIScreen.main.bounds.height
    let kScreenSize   = UIScreen.main.bounds.size
    let kScreenOrigin = UIScreen.main.bounds.origin

    // MARK: 沙盒路径
    let kHomeDocumentsPath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString)
    //  /Users/apple/Library/Developer/CoreSimulator/Devices/22A3FC45-B293-4941-9F23-7147E9656BAC/data/Containers/Data/Application/0B9DC41D-06C0-4585-99B6-DF8D595B2616/Documents
    let kHomeLibraryPath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString)

    let kHomeLibraryCachesPath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString)

    let kHomeLibraryPreferencesPath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.preferencePanesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString)


    let kHomeLibraryCachesURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)[0]


    //  file:///Users/apple/Library/Developer/CoreSimulator/Devices/22A3FC45-B293-4941-9F23-7147E9656BAC/data/Containers/Data/Application/0B9DC41D-06C0-4585-99B6-DF8D595B2616/Library/Caches/



// MARK: - 自定义
    // MARK: 主题色
    let kThemeColor = UIColor.orange

    // MARK: 通知字段
    let k_switchRootVCNotification = "MYPSwitchRootVCNotification"


    // MARK: 存储字段
    let k_sandBoxLastVersionKey = "sandBoxLastBundleShortVersionKey"
    let k_imagePath = kHomeLibraryCachesPath.appendingPathComponent("image.plist")// 图片存储路径









// MARK: - SDK
    // MARK: 新浪APPKey
    let k_appKey         = "3656325289"                       // client_id
    let k_appSecret      = "956a491a0d3d5e5a854fb46f0aef0e42" // client_secret
    let k_appRedirectURI = "http://www.mengyueping.com"       // redirect_uri


    // MARK: 接口 API
    let k_api_url       = "https://api.weibo.com"
    let k_oauth_url     = "https://api.weibo.com/oauth2/authorize"


