//
//  MYPUserAccount.swift
//  02-Weibo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 MengYP. All rights reserved.
//
/*
 业务逻辑模型
 */


import UIKit

class MYPUserAccount: NSObject,NSCoding {
// MARK: - 属性
    var access_token: String?        //接口获取授权后的access token。
    var expires_in: TimeInterval = 0 {//access_token的生命周期，单位是秒数。
        didSet {
            expires_date = Date(timeIntervalSinceNow: expires_in)
        }
    }
    var uid: String?                 //当前授权用户的UID
    
    var name: String?         // 友好显示名称
    var avatar_large: String? // 用户头像地址（大图），180×180像素
    
    var expires_date: Date?  // 计算属性,token失效的日期
    // 开发者账号的有效期5年,普通用户的有效期3天,未审核通过的token的有效期1天
    
// MARK: - 初始化
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    // 过滤属性字段
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
    // 重写description 属性
    override var description: String {
        let keys = ["access_token","expires_in","uid","name","avatar_large","expires_date"]
		return dictionaryWithValues(forKeys: keys).description
    }
    
// MARK: - NSCoding 协议
    /// 解档   二进制 -> 对象
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? Date
        uid          = aDecoder.decodeObject(forKey: "uid") as? String
        name         = aDecoder.decodeObject(forKey: "name") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
    }
    
    /// 归档   对象 -> 二进制 -> 沙盒(磁盘)
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
    }
    
// MARK: - 提供接口方法
    
    /// 保存模型 （自定义对象）
    func saveAccount() {
        let path = kHomePath.appendingPathComponent("account.plist") // 存储路径
        NSKeyedArchiver.archiveRootObject(self, toFile: path)
        print(path)
    }
    
    /// 从本地沙盒获取模型（自定义对象） 类型方法
    class func loadAccount() -> MYPUserAccount? {
        let path = kHomePath.appendingPathComponent("account.plist") // 存储路径
        if let account = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? MYPUserAccount {
            //日期判断（是否过期）
            if account.expires_date?.compare(Date()) == ComparisonResult.orderedDescending {
                return account
            }
        }
        return nil
    }
    
}
