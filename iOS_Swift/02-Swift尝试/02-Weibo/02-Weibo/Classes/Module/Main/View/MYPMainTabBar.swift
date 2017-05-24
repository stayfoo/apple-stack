//
//  MYPMainTabBar.swift
//  02-Weibo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 MengYP. All rights reserved.
//
/*
 自定义 TabBar
 */

import UIKit

class MYPMainTabBar: UITabBar {

// MARK: - 初始化
    override init(frame: CGRect) { //实现此方法,默认当前类只通过代码的方式进行创建
        super.init(frame: frame)
        
        setupUI() //初始化UI
    }
    
    //默认不实现报错：'required' initializer 'init(coder:)' must be provided by subclass of 'UITabBar'
    required init?(coder aDecoder: NSCoder) { //支持 xib/storyboard
        super.init(coder: aDecoder)
        
        setupUI() //初始化UI
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout() //布局UI
    }
    
// MARK: - 私有方法
    
    fileprivate func setupUI() {
        addSubview(composeBtn) //添加子视图
    }
    
    fileprivate func setupLayout() {
        
        let w = kScreenW / 5
        let h = self.bounds.height
        let rect = CGRect(x: 0, y: 0, width: w, height: h)
        
        var index: CGFloat = 0
        for child in subviews {
            if child.isKind(of: NSClassFromString("UITabBarButton")!) {
                child.frame = rect.offsetBy(dx: w * index, dy: 0) //
                
                index += (index == 1 ? 2 : 1) //跳过2,预留中间位置, 0 1 2 3 4
            }
        }
        
        composeBtn.frame = rect.offsetBy(dx: 2 * w, dy: 0) //设置中间位置按钮
    }
    
// MARK: - 懒加载
    lazy var composeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), for: .normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: .highlighted)
        
        btn.sizeToFit() //根据按钮的背景图片,给定size大小
        
        return btn
    }()
    
}








