//
//  MYPBaseController.swift
//  02-Weibo
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 控制器基类
 */

import UIKit

// 多继承
class MYPBaseController: UITableViewController,MYPVisitorLoginViewDelegate {

// MARK: - 属性
    var userLogin = false //标记用户是否登录 true:已登录
    var visitorLoginView: MYPVisitorLoginView?  // 访客视图属性
    
// MARK: - 初始化
    
    /*
     loadView :
     准备视图层次结构,加载视图
     苹果专门为手写代码准备的方法, 一旦实现了该方法,storyboard/xib 就自动是失效
     在 loadView 方法,会自动检测根视图是否为空,如果为空会自动调用 loadView
     */
    override func loadView() {
        // 选择加载视图
        userLogin ? super.loadView() : setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: - 私有方法
    
    /// 自定义访客视图
    fileprivate func setupVisitorView() {
        
        visitorLoginView = MYPVisitorLoginView()
        visitorLoginView?.visitorViewDelegate = self
        view = visitorLoginView
        
        
        // Use of string literal for Objective-C selectors is deprecated; use '#selector' instead
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MYPBaseController.userWillLogin))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.done, target: self, action: #selector(MYPBaseController.userWillRegister))
        
        
    }
    
// MARK: - 事件监听 & 代理方法
    @objc internal func userWillRegister() {
        print(#function)
    }
    @objc internal func userWillLogin() {
        print(#function)
        
        let oauthVC = MYPOAuthController()
        let navVC = UINavigationController(rootViewController: oauthVC)
        present(navVC, animated: true, completion: nil)
    }
}



