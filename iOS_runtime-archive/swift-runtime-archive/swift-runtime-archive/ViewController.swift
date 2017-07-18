//
//  ViewController.swift
//  swift-runtime-archive
//
//  Created by 孟跃平 on 2017/7/17.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var momentmodel = { () -> MomentModel in
        let model: MomentModel = MomentModel()
        model.content = "这是一条动态"
        model.time = "2017.7.17"
        model.pic = "http://123.jpg"
        model.place = "Beijing"
        
        return model
    }()
    
    lazy var userModel = { () -> UserModel in
        let model: UserModel = UserModel()
        model.age = "18"
        model.avatar = "http://avatar.jpg"
        model.name = "Tom"
        return model
    }()
    
    let k_moment_path = "\(NSTemporaryDirectory())/moment.moment"
    let k_user_path = "\(NSTemporaryDirectory())/user.user"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var outCount: UInt32 = 0
        let ivars = class_copyIvarList(UserModel.self, &outCount)
        print(String(cString: ivar_getName(ivars?[0]), encoding: String.Encoding.utf8)!)
        print(outCount)
    }
    
    @IBAction func encode(_ sender: Any) {
        let isSuccess: Bool = NSKeyedArchiver.archiveRootObject(momentmodel, toFile: k_moment_path)
        if isSuccess {
            print("归档成功")
        }
        
        let isOk = NSKeyedArchiver.archiveRootObject(userModel, toFile: k_user_path)
        if isOk {
            print("归档成功 isOK")
        }
        
    }
    @IBAction func decode(_ sender: Any) {
        if let obj = NSKeyedUnarchiver.unarchiveObject(withFile: k_moment_path) as? MomentModel {
            print("MomentModel: \(obj) \(obj.content!) \(obj.pic!) \(obj.place!) \(obj.time!)")
        }
        
        if let user = NSKeyedUnarchiver.unarchiveObject(withFile: k_user_path) as? UserModel {
            print("UserModel: \(user) \(user.name!) \(user.avatar!) \(user.age!)")
        }
    }
}

