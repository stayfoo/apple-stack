//
//  MYPStatusCell.swift
//  02-Weibo
//
//  Created by apple on 2017/5/28.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 * 微博Cell
 *
 * 顶部视图 + 配图 + 底部工具
 */

import UIKit
import SnapKit

let statusCellMargin: CGFloat = 12
let statusCellImageWidth: CGFloat = 35

class MYPStatusCell: UITableViewCell {
// MARK: - 属性
    var model: MYPStatus? {
        didSet {
            originalView.model = model
        }
    }
    
    
// MARK: - 构造
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setupUI()
        setupLayout()
        
//        originalView.backgroundColor = .orange
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - 私有方法
    fileprivate func setupUI() {  // 设置子控件
        contentView.addSubview(originalView)
        contentView.addSubview(bottomView)
    }
    
    func setupLayout() { // 布局子控件
        
        //顶部视图
        originalView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
        
        //底部
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(originalView.snp.bottom)
            make.height.equalTo(40)
            make.left.right.bottom.equalToSuperview()
        }
        
        
        //contentView
//        contentView.snp.makeConstraints { (make) in
//            make.bottom.equalTo(originalView.snp.bottom)
//        }
        
    }

// MARK: - 懒加载
    
    //顶部视图
    fileprivate lazy var originalView: MYPStatusOriginalView = MYPStatusOriginalView()
    
    fileprivate lazy var bottomView: MYPStatusBottomView = MYPStatusBottomView()
    
}
