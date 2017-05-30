//
//  MYPStatusOriginalView.swift
//  02-Weibo
//
//  Created by apple on 2017/5/28.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import UIKit
import SnapKit

class MYPStatusOriginalView: UIView {
// MARK: - 属性
    var bottomConstraints: Constraint? //底部约束
    
    var model: MYPStatus? {
        
        //模型赋值
        didSet {
            guard let status = model else { return }
            guard let user = status.user else { return }
            
//            headView.myp_setImage(with: user.profile_image_url, placeholderImage: UIImage(named: "avatar_default_big")!)
            headView.image = UIImage(named: "avatar_default_big")
            nameLabel.text = user.name
            mbrankView.image = user.mbrankImage
            verifiedView.image = user.verified_type_image
            
//            timeLabel.text = status.created_at
//            sourceLabel.text = status.source
            contentLabel.text = status.text
            
            bottomConstraints?.deactivate() //解除可能复用的约束
            
            //配图
            if let urls = status.imageURLs, urls.count != 0 {
                
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
                
            } else { //无配图
                pictureView.isHidden = true
                
//                guard let _ = self.bottomConstraints else {
                    self.snp.makeConstraints({ (make) in
                        self.bottomConstraints = make.bottom.equalTo(contentLabel.snp.bottom).offset(statusCellMargin).constraint
                    })
//                    return
//                }
//                self.snp.updateConstraints({ (make) in
//                    self.bottomConstraints = make.bottom.equalTo(contentLabel.snp.bottom).offset(statusCellMargin).constraint
//                })
                
            }
            
        }
    }

// MARK: - 构造
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        setupUI()
        setupLayout()
        
        headView.backgroundColor = .blue
        nameLabel.backgroundColor = .gray
        verifiedView.backgroundColor = UIColor.brown
        mbrankView.backgroundColor = UIColor.cyan
        timeLabel.backgroundColor = UIColor.darkGray
        sourceLabel.backgroundColor = UIColor.green
        contentLabel.backgroundColor = UIColor.orange
//        pictureView
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
// MARK: - 私有方法
    fileprivate func setupUI() {  // 设置子控件
        addSubview(headView)
        addSubview(nameLabel)
        addSubview(verifiedView)
        addSubview(mbrankView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        addSubview(contentLabel)
        addSubview(pictureView)
    }
    
    func setupLayout() { // 布局子控件
        
//        for child in subviews {
//            child.translatesAutoresizingMaskIntoConstraints = false //使用VFL,必须将此属性关闭（frame 设置视图位置的属性）
//        }
//        pictureView.translatesAutoresizingMaskIntoConstraints = true
        
        
        //头像
        headView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(statusCellMargin)
            make.width.height.equalTo(statusCellImageWidth)
        }
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(12)-[headView(35)]", options: [], metrics: nil, views: ["headView":headView]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(12)-[headView(35)]", options: [], metrics: nil, views: ["headView":headView]))
        
        //名字
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headView.snp.right).offset(statusCellMargin)
            make.top.equalTo(headView.snp.top)
        }
        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[headView]-(12)-[nameLabel]", options: [], metrics: nil, views: ["headView": headView, "nameLabel": nameLabel]))
//        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: headView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
        
        //vip徽章
        verifiedView.snp.makeConstraints { (make) in
            make.centerX.equalTo(headView.snp.right)
            make.centerY.equalTo(headView.snp.bottom)
        }
        
//        addConstraint(NSLayoutConstraint(item: verifiedView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: headView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: verifiedView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: headView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
        
        //等级徽章
        mbrankView.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(statusCellMargin)
            make.top.equalTo(nameLabel.snp.top)
        }
        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[nameLabel]-(12)-[mbrankView]", options: [], metrics: nil, views: ["mbrankView":mbrankView,"nameLabel":nameLabel]))
//        addConstraint(NSLayoutConstraint(item: mbrankView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: nameLabel, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
        
        //时间
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headView.snp.right).offset(statusCellMargin)
            make.bottom.equalTo(headView.snp.bottom)
        }
        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[headView]-(12)-[timeLabel]", options: [], metrics: nil, views: ["timeLabel":timeLabel,"headView":headView]))
//        addConstraint(NSLayoutConstraint(item: timeLabel, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: headView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
        
        //来源
        sourceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(timeLabel.snp.right).offset(statusCellMargin)
            make.bottom.equalTo(timeLabel.snp.bottom)
        }
        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[timeLabel]-(12)-[sourceLabel]", options: [], metrics: nil, views: ["sourceLabel":sourceLabel,"timeLabel":timeLabel]))
//        addConstraint(NSLayoutConstraint(item: sourceLabel, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: timeLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
        
        //内容
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(statusCellMargin)
            make.right.equalToSuperview().offset(-statusCellMargin)
            make.top.equalTo(headView.snp.bottom).offset(statusCellMargin)
        }
        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(12)-[contentLabel]-(12)-|", options: [], metrics: nil, views: ["contentLabel":contentLabel]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[headView]-(12)-[contentLabel]", options: [], metrics: nil, views: ["contentLabel":contentLabel,"headView":headView]))
        
        //配图
        pictureView.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(statusCellMargin)
            make.left.equalTo(contentLabel.snp.left)
//            make.size.equalTo(CGSize(width: 100, height: 100))
//            make.bottom.equalTo(self.snp.bottom)
        }
        
        
        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[contentLabel]-(12)-[pictureView]-(12)-|", options: [], metrics: nil, views: ["pictureView":pictureView,"contentLabel":contentLabel]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[pictureView(100)]", options: [], metrics: nil, views: ["pictureView":pictureView]))
//        addConstraint(NSLayoutConstraint(item: pictureView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: contentLabel, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0))
        
        //底部约束
        self.snp.makeConstraints { (make) in
            self.bottomConstraints = make.bottom.equalTo(pictureView.snp.bottom).offset(statusCellMargin).constraint
        }
        
    }
    
// MARK: - 懒加载
    //头像
    fileprivate lazy var headView = UIImageView()
    //名字
    fileprivate lazy var nameLabel = UILabel(title: "狐狸", color: .darkGray, fontSize: 14)
    //vip徽章
    fileprivate lazy var verifiedView = UIImageView(image: UIImage(named: "avatar_vip"))
    //等级徽章
    fileprivate lazy var mbrankView = UIImageView(image: UIImage(named: "common_icon_membership"))
    //时间
    fileprivate lazy var timeLabel = UILabel(title: "11:11", color: .orange, fontSize: 10)
    //来源
    fileprivate lazy var sourceLabel = UILabel(title: "兔子", color: .darkGray, fontSize: 10)
    //内容
    fileprivate lazy var contentLabel = UILabel(title: "疯狂动物园", color: .darkGray, fontSize: 14, margin: statusCellMargin)
    //配图
    fileprivate lazy var pictureView: MYPPictureView = MYPPictureView()
    
}
