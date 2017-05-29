//
//  UILabel+MYP.swift
//  02-Weibo
//
//  Created by apple on 2017/5/25.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(title: String, color: UIColor, fontSize: CGFloat) {
        self.init()
        
        text = title
        textColor = color
        font = UIFont.systemFont(ofSize: fontSize)
        numberOfLines = 0
        textAlignment = NSTextAlignment.center
        
        sizeToFit()
    }
    
    
    convenience init(title: String, color: UIColor, fontSize: CGFloat, margin: CGFloat) {
//        self.init(title: title, color: color, fontSize: fontSize)
        
        self.init()
        
        text = title
        textColor = color
        font = UIFont.systemFont(ofSize: fontSize)
        numberOfLines = 0
        textAlignment = NSTextAlignment.center
        
        if margin > 0 {
            preferredMaxLayoutWidth = kScreenW - 2 * margin
            textAlignment = NSTextAlignment.left
        }
        
        sizeToFit()
    }
}
