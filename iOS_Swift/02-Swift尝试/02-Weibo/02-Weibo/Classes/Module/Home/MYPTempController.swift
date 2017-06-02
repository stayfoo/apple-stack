//
//  MYPTempController.swift
//  02-Weibo
//
//  Created by apple on 2017/5/30.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import UIKit

class MYPTempController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.randomColor()
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let temp = MYPTempController()
        navigationController?.pushViewController(temp, animated: true)
    }

}
