//
//  AppDelegate.swift
//  02-Weibo
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

// MARK: - 生命周期
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupThemeColor()      //设置主题色
        registerNotification() // 注册通知
        
        
        window = UIWindow(frame: kScreenBounds)
        window!.backgroundColor = UIColor.white
        window!.makeKeyAndVisible()
        window!.rootViewController = defaultRootVC()
        
        
        return true
    }
    
    /// 析构方法
    deinit {
        NotificationCenter.default.removeObserver(self) // 移除通知
    }
    
// MARK: - 私有方法
    /// 根控制器显示判断
    fileprivate func defaultRootVC() -> UIViewController {
        
        if MYPUserAccountViewModel().userLogin {
            
            if isNewVersion() {
                return MYPNewFeatureController()
            }
            return MYPWelcomeController()
        }
        
        return MYPMainController()
    }
    
    /*
     * 判断是否版本更新
     *
     * - Returns: true : 版本更新了
     */
    fileprivate func isNewVersion() -> Bool {
        
        let dict = Bundle.main.infoDictionary!
        let currentNum = (dict["CFBundleShortVersionString"] as! String)
        
        let defaults = UserDefaults.standard
        let lastVersion = defaults.double(forKey: k_sandBoxLastVersionKey)
        
        let isNew = Double(currentNum)! > lastVersion
        if isNew {
            defaults.set(currentNum, forKey: k_sandBoxLastVersionKey) //重新记录版本
            defaults.synchronize() //同步沙盒
        }
        
        return isNew
    }
    
    /*
     * 设置主题色
     */
    fileprivate func setupThemeColor() {
        UINavigationBar.appearance().tintColor = kThemeColor
        UITabBar.appearance().tintColor = kThemeColor
    }
    
// MARK: - 事件监听
    @objc fileprivate func switchRootVC(_ note: Notification) {
        window?.rootViewController = MYPMainController()
    }
    
// MARK: - 通知注册
    fileprivate func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.switchRootVC(_:)), name: NSNotification.Name(rawValue: k_switchRootVCNotification), object: nil)
    }
    
}

