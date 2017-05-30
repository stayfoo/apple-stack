//
//  MYPStatusRetweetedView.swift
//  02-Weibo
//
//  Created by apple on 2017/5/30.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 * 转发微博
 */

import UIKit
import SnapKit

class MYPStatusRetweetedView: UIView {
// MARK: - 属性
    var bottomConstraints: Constraint? //底部约束
    
    
    var retweetedStatus: MYPStatus? {
        didSet {
            
            retweetedLabel.text = "@\(retweetedStatus?.user?.name ?? ""):\(retweetedStatus?.text ?? "")"
            bottomConstraints?.deactivate() // 解除可能复用的约束
            
            if let urls = retweetedStatus?.imageURLs, urls.count != 0 {
                
                pictureView.imageURLs = urls
                pictureView.isHidden = false
                
//                guard let _ = self.bottomConstraints else {
                    self.snp.makeConstraints({ (make) in
                        self.bottomConstraints = make.bottom.equalTo(pictureView.snp.bottom).offset(statusCellMargin).constraint
                    })
//                    return
//                }
//                self.snp.updateConstraints({ (make) in
//                    self.bottomConstraints = make.bottom.equalTo(pictureView.snp.bottom).offset(statusCellMargin).constraint
//                })
                
            } else { //没有配图
                
                pictureView.isHidden = true
                
//                guard let _ = self.bottomConstraints else {
                    self.snp.makeConstraints({ (make) in
                        self.bottomConstraints = make.bottom.equalTo(retweetedLabel.snp.bottom).offset(statusCellMargin).constraint
                    })
//                    return
//                }
//                self.snp.updateConstraints({ (make) in
//                    self.bottomConstraints = make.bottom.equalTo(retweetedLabel.snp.bottom).offset(statusCellMargin).constraint
//                })
            }
        }
    }
    
    
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
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        addSubview(retweetedLabel)
        addSubview(pictureView)
        
        retweetedLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(statusCellMargin)
        }
        pictureView.snp.makeConstraints { (make) in
            make.left.equalTo(retweetedLabel.snp.left)
            make.top.equalTo(retweetedLabel.snp.bottom).offset(statusCellMargin)
//            make.bottom.equalToSuperview().offset(statusCellMargin)
        }
        
        //底部约束
        self.snp.makeConstraints { (make) in
            self.bottomConstraints = make.bottom.equalTo(pictureView.snp.bottom).offset(statusCellMargin).constraint
        }
    }
    
// MARK: - 懒加载
    fileprivate lazy var retweetedLabel = UILabel(title: "转发微博", color: .darkGray, fontSize: 14, margin: statusCellMargin)
    
    fileprivate lazy var pictureView: MYPPictureView = MYPPictureView()
}
