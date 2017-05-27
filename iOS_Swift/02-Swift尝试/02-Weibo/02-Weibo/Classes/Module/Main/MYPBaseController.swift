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
    
// MARK: - 生命周期
    
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
        
        print(NSHomeDirectory())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("--控制器销毁了--")
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
        
        MYPNetWorking.sharedManager.download("https://cdn.pixabay.com/photo/2017/05/12/08/29/coffee-2306471_1280.jpg"){ response, result in
            
//            print("response: \(response) --- result: \(result.value)")
            
            
            /*
             response: Optional(<NSHTTPURLResponse: 0x60800023b380> 
             { 
                URL: https://cdn.pixabay.com/photo/2017/05/12/08/29/coffee-2306471_1280.jpg
             } 
             { 
                status code: 200, headers 
                 {
                    "Accept-Ranges"     = bytes;
                    "Cache-Control"     = "no-cache, must-revalidate";
                    "Content-Length"    = 257149;
                    "Content-Type"      = "image/jpeg";
                    Date                = "Fri, 26 May 2017 02:06:54 GMT";
                    Etag                = "\"59155653-3ec7d\"";
                    "Last-Modified"     = "Fri, 12 May 2017 06:29:39 GMT";
                    Server              = nginx;
                 } 
             }
             ) --- result: SUCCESS
             */
        }
    }
    @objc internal func userWillLogin() {
        print(#function)
        
        let oauthVC = MYPOAuthController()
        let navVC = UINavigationController(rootViewController: oauthVC)
        present(navVC, animated: true, completion: nil)
    }
}



