//
//  MYPUser.swift
//  02-Weibo
//
//  Created by apple on 2017/5/27.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 *  用户模型
 */

import UIKit

class MYPUser: NSObject {
// MARK: - 属性
    var id: Int = 0                 //用户UID
    var name: String?               //友好显示名称
    
    var profile_image_url: String?  //Y用户头像地址
    var headImageURL: URL? {        //用户头像 (计算型属性)
        return URL(string: profile_image_url ?? "")
    }
    
    // 认证类型，-1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var verified_type: Int = -1
    var verified_type_image: UIImage? {  //认真类型图片
        switch verified_type {
        case -1    : return nil
        case 0     : return UIImage(named: "avatar_vip")
        case 2,3,5 : return UIImage(named: "avatar_enterprise_vip")
        case 220   : return UIImage(named: "avatar_grassroot")
        default    : return nil
        }
    }
    
    var mbrank: Int = 0          // 会员等级 0-6
    var mbrankImage: UIImage? {  //用户等级图片
        if mbrank > 0 && mbrank < 7 {
            return UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        return nil
    }
    
    
// MARK: - 构造方法
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict) //kvc设置初始值
    }
    
    //过滤
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
    
}
