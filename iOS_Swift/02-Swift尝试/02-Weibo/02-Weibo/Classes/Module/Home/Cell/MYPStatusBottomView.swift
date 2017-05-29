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
            make.top.bottom.equalToSuperview()
        }
        
        
    }
    
// MARK: - 懒加载
    fileprivate lazy var retweetedBtn = UIButton(title: "转发", backgroundImage: nil, color: .darkGray, fontSize: 10, isNeedHighlighted: false, imageName: "timeline_icon_retweet")
    
    fileprivate lazy var composeBtn = UIButton(title: "评论", backgroundImage: nil, color: .darkGray, fontSize: 10, isNeedHighlighted: false, imageName: "timeline_icon_comment")
    
    fileprivate lazy var likeBtn = UIButton(title: "", backgroundImage: nil, color: .darkGray, fontSize: 10, isNeedHighlighted: false, imageName: "timeline_icon_unlike")
    
}
