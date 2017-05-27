//
//  MYPHomeController.swift
//  02-Weibo
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import UIKit

class MYPHomeController: MYPBaseController {

// MARK: - 初始化
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorLoginView?.setWithInfo("周边看一看", imageName: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
