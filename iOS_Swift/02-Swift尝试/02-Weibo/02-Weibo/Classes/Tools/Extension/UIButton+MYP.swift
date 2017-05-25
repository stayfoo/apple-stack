//
//  UIButton+MYP.swift
//  02-Weibo
//
//  Created by apple on 2017/5/24.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 * 给 UIButton 扩展构造方法
 */

/*
  扩展构造方法：
    分类中不能够添加指定的构造方法；不能够添加存储型属性；只能够添加只读属性和方法；
    convenience 只能够调用本类的构造方法，针对指定的构造函数进行额外操作（扩展）；
 */

import UIKit

extension UIButton {
    
    
    /// 便利构造 button
    ///
    /// - Parameters:
    ///   - title: 文字
    ///   - backgroundImage: 按钮背景图片
    ///   - color: 文字颜色
    ///   - fontSize: 文字字号
    ///   - isNeedHighlighted: 是否需要高亮背景图片
    convenience init(title: String, backgroundImage: String, color: UIColor, fontSize: CGFloat = 15, isNeedHighlighted: Bool = false) {
        
        self.init() //便利构造方法可以访问 self 对象
        
        setTitle(title, for: UIControlState())
        setBackgroundImage(UIImage(named: backgroundImage), for: UIControlState.normal)
        if isNeedHighlighted {
            setBackgroundImage(UIImage(named: backgroundImage + "_highlighted"), for: UIControlState.highlighted)
        }
        setTitleColor(color, for: UIControlState())
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        sizeToFit()
    }
    
    
    /// 便利构造 button
    ///
    /// - Parameters:
    ///   - imageName: 按钮图片
    ///   - backgroundImage: 按钮背景图片
    convenience init(imageName: String, backgroundImage: String) {
        self.init()
        
        setBackgroundImage(UIImage(named: imageName), for: UIControlState.normal)
        setBackgroundImage(UIImage(named: imageName + "_highlighted"), for: UIControlState.highlighted)
        setImage(UIImage(named: imageName), for: UIControlState.normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: UIControlState.highlighted)
        
        sizeToFit()
    }
}




