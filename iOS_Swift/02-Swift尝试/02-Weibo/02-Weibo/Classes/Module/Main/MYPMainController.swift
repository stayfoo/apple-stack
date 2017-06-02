//
//  MYPMainController.swift
//  02-Weibo
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 fileprivate : 只有在当前类的内部可以访问。
 */

import UIKit

class MYPMainController: UITabBarController {
    
    let mainTabBar = MYPMainTabBar()
    
    
// MARK: - 初始化
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orange
        
        setValue(mainTabBar, forKey: "tabBar") // 替换系统 tabBar,KVC动态修改只读属性
        mainTabBar.composeBtn.addTarget(self, action: #selector(MYPMainController.composeBtnDidClick), for: .touchUpInside)
        
        print(tabBar.classForCoder) // classForCoder 对象的所属类的类名（字符串）
        
        addChildViewControllers()
    }
    
// MARK: - 事件监听
    
    /*
     target-action 方法选择器机制,都是OC中机制, 
     为了让 Swift 中的语法,能够兼容OC方法选择器,需要使用 @objc
     */
    @objc fileprivate func composeBtnDidClick() {
        print(#function)
        
        let composeVC = MYPComposeController()
        let navVC = UINavigationController(rootViewController: composeVC)
        present(navVC, animated: true, completion: nil)
        
    }
    
// MARK: - 私有方法
    
    /// 添加子控制器
    fileprivate func addChildViewControllers() {
        self.tabBar.tintColor = UIColor.orange
        
        addChildViewController(MYPHomeController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(MYPMessageController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(MYPDiscoverController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(MYPDiscoverController(), title: "我", imageName: "tabbar_profile")

    }
    
    fileprivate func addChildViewController(_ vc: UIViewController, title: String,imageName: String) {
        
        let nav = MYPBaseNavController(rootViewController: vc)
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        addChildViewController(nav)
        
    }


}
