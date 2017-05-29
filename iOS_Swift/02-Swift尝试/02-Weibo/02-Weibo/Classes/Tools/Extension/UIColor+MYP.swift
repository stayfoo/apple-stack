//
//  UIColor+MYP.swift
//  02-Weibo
//
//  Created by apple on 2017/5/29.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func randomColor() -> UIColor {
        
        let r = CGFloat(arc4random() % 255) / 255.0
        let g = CGFloat(arc4random() % 255) / 255.0
        let b = CGFloat(arc4random() % 255) / 255.0
        
        let randomColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        
        return randomColor
    }
    
}
