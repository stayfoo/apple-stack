//
//  MYPStatusBottomView.swift
//  02-Weibo
//
//  Created by apple on 2017/5/29.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 *  底部工具条
 */

import UIKit

class MYPStatusBottomView: UIView {
// MARK: - 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - 私有方法
    fileprivate func setupUI() {
        self.backgroundColor = UIColor(white: 0.98, alpha: 1)
        
        addSubview(retweetedBtn)
        addSubview(composeBtn)
        addSubview(likeBtn)
        
        retweetedBtn.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
        }
        composeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(retweetedBtn.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(retweetedBtn.snp.width)
        }
        likeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(composeBtn.snp.right)
            make.width.equalTo(composeBtn.snp.width)
            make.top.right.bottom.equalToSuperview()
        }
        
        let divLine1 = divLine()
        addSubview(divLine1)
        let divLine2 = divLine()
        addSubview(divLine2)
        let w = 0.5
        let scale = 0.4
        
        divLine1.snp.makeConstraints { (make) in
            make.left.equalTo(retweetedBtn.snp.right)
            make.width.equalTo(w)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(scale)
        }
        
        divLine2.snp.makeConstraints { (make) in
            make.left.equalTo(composeBtn.snp.right)
            make.width.equalTo(w)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(scale)
        }
        
        //添加点击事件
        retweetedBtn.addTarget(self, action: #selector(MYPStatusBottomView.retweetedBtnDidClick), for: .touchUpInside)
    }
    
    fileprivate func divLine() -> UIView {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }

// MARK: - 事件监听
    @objc fileprivate func retweetedBtnDidClick() {
        
        let temp = MYPTempController()
        retweetedBtn.navController()?.pushViewController(temp, animated: true)
    }

// MARK: - 懒加载
    fileprivate lazy var retweetedBtn = UIButton(title: "转发", backgroundImage: nil, color: .darkGray, fontSize: 10, isNeedHighlighted: false, imageName: "timeline_icon_retweet")
    
    fileprivate lazy var composeBtn = UIButton(title: "评论", backgroundImage: nil, color: .darkGray, fontSize: 10, isNeedHighlighted: false, imageName: "timeline_icon_comment")
    
    fileprivate lazy var likeBtn = UIButton(title: "", backgroundImage: nil, color: .darkGray, fontSize: 10, isNeedHighlighted: false, imageName: "timeline_icon_unlike")
    
}
