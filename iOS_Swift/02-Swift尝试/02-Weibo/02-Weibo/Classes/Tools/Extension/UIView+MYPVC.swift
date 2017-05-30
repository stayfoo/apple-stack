//
//  UIView+MYPVC.swift
//  02-Weibo
//
//  Created by apple on 2017/5/30.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import UIKit

extension UIView {
    
    //遍历响应者链条 获取导航视图控制器
    func navController() -> UINavigationController? {
        
        var next = self.next //获取视图的下一个响应者
        repeat {
            if let nextObj = next as? UINavigationController {
                return nextObj
            }
            next = next?.next //获取下一个响应者的下一个响应者
            
        } while (next != nil)
        
        return nil
    }
}
