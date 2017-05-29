//
//  MYPWelcomeController.swift
//  02-Weibo
//
//  Created by apple on 2017/5/25.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 * 登录后欢迎页 广告页
 */

import UIKit
import Alamofire

class MYPWelcomeController: UIViewController {
    
// MARK: - 生命周期
    
    override func loadView() {
        view = backgroundImageView // 切换根视图
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        
        
        iconView.myp_setImage(with: MYPUserAccountViewModel().headImageURL, placeholderImage: UIImage(named: "avatar_default_big")!)
        
    }
    
    override func viewDidAppear(_ animated: Bool) { //动画效果建议在 ViewDidAppear方法中执行
        super.viewDidAppear(animated)
        
        startAnimation() //执行动画效果
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("--控制器销毁了--")
    }
    
// MARK: - 私有方法
    
    /// 创建子控件
    fileprivate func setupUI() {
        view.addSubview(iconView)
        view.addSubview(welcomeLabel)
        
        iconView.layer.masksToBounds = true
        iconView.layer.cornerRadius = 45
//        iconView.backgroundColor = UIColor.red //测试
    }
    
    /// 布局子控件
    fileprivate func setupLayout() {
        
        for child in view.subviews {
            child.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //头像
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[iconView(==90)]-(180)-|", options: [], metrics: nil, views: ["iconView":iconView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[iconView(==90)]", options: [], metrics: nil, views: ["iconView":iconView]))
        view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        
        //欢迎语
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[iconView]-(16)-[welcomeLabel]", options: [], metrics: nil, views: ["iconView":iconView,"welcomeLabel":welcomeLabel]))
        view.addConstraint(NSLayoutConstraint(item: welcomeLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
    }
    
    /// 执行动画效果
    fileprivate func startAnimation() {
        
        let offset = -kScreenH + 180
        view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: offset))
        
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 9.8, options: [], animations: { () -> Void in
            
//            self.view.removeConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[iconView]-(180)-|", options: [], metrics: nil, views: ["iconView":self.iconView]))
            
            //强制提前刷新页面
            self.view.layoutIfNeeded()
            
        }, completion: { (_ : Bool) -> Void in
            
            //发出切换页面通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: k_switchRootVCNotification), object: nil)
        })
    }
// MARK: - 懒加载
    
    /// 背景
    fileprivate lazy var backgroundImageView = UIImageView(image: UIImage(named: "ad_background"))
    
    /// 头像
    fileprivate lazy var iconView = UIImageView()
    
    /// 欢迎语
    fileprivate lazy var welcomeLabel = UILabel(title: (MYPUserAccountViewModel().userName ?? "") + " 欢迎归来", color: UIColor.darkGray, fontSize: 19)
    
}


/*
 使用自动布局设置动画效果需要注意:
    所有设置自动布局的空间,在添加动画效果的时候,不要直接设置 frame
 原因:
    1.自动布局系统,会根据设置的约束,自动计算空间的frame
    2.在layoutsubViews方法中,给所有的子控件根据设置好的约束修改相应的frame值
    3.如果主动修改frame会引起自动布局系统计算错误
 
 每一次运行循环的开启,自动布局系统都会'收集'所有控件约束的变化
 在运行循环结束前,调用 layoutsubViews , 统一一次性将所有收集到的变化进行更新
 如果希望提前更新,就需要调用强制刷新布局方法 layoutIfNeeded
 */



