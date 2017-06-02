//
//  MYPBaseNavController.swift
//  02-Weibo
//
//  Created by apple on 2017/5/30.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import UIKit

class MYPBaseNavController: UINavigationController {

// MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count != 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MYPBaseNavController.close))
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
// MARK: - 事件监听
    @objc fileprivate func close() {
        popViewController(animated: true)
    }

}
