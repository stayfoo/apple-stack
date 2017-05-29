//
//  MYPPictureView.swift
//  02-Weibo
//
//  Created by apple on 2017/5/29.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 *  图片展示
 */

import UIKit

private let pictureCellID = "pictureCellID"
private let pictureCellMargin: CGFloat = 5

class MYPPictureView: UICollectionView {
    // MARK: 属性
    var imageURLs: [URL]? {
        didSet {
//            testLabel.text = "\(imageURLs?.count ?? 0)"
            
            
//            removeConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view]", options: [], metrics: nil, views: ["view":self]))
//            removeConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view]", options: [], metrics: nil, views: ["view":self]))
            
            
            let pSize = calculatePictureViewSize()
            
            self.snp.makeConstraints { (make) in
                make.size.equalTo(pSize)
            }
            
//            self.snp.updateConstraints { (make) in
//                make.size.equalTo(pSize)
//            }
            
//            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(\(pSize.height))]", options: [], metrics: nil, views: ["view":self]))
//            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view(\(pSize.width))]", options: [], metrics: nil, views: ["view":self]))
            
            reloadData()
        }
    }
    
    // MARK: 构造方法
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = pictureCellMargin
        layout.minimumLineSpacing = pictureCellMargin
        
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 私有方法
    fileprivate func setupUI() {
        
        register(MYPPictureCell.self, forCellWithReuseIdentifier: pictureCellID)
        dataSource = self
        backgroundColor = UIColor.randomColor()
        
        
//        addSubview(testLabel)
//        testLabel.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//        }
    }
    
    /*
     *
        1张：图片等比例显示
            多图图片大小固定
        4张： 2 * 2 显示
        其他：3 * 3
     *
     */
    fileprivate func calculatePictureViewSize() -> CGSize {
        
        let imageCount = imageURLs?.count ?? 0
        let maxWidth = kScreenW - 2 * statusCellMargin
        let itemWidth = (maxWidth - 2 * pictureCellMargin) / 3
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        if imageCount == 0 {
            return CGSize.zero
        }
        
        if imageCount == 1 {
            let imageSize = CGSize(width: 180, height: 120)
            layout.itemSize = imageSize
            return imageSize
        }
        
        if imageCount == 4 {
            let pw = itemWidth * 2 + pictureCellMargin
            return CGSize(width: pw, height: pw)
        }
        
        /*
         其他:
            2,3,  5,6,7,8,9
         */
        let row = CGFloat((imageCount - 1) / 3 + 1)
        return CGSize(width: maxWidth, height: itemWidth * row + pictureCellMargin * (row - 1))
    }
    
    // MARK: 懒加载
    fileprivate lazy var testLabel = UILabel(title: "", color: .red, fontSize: 30)
}

// MARK: - 数据源方法
extension MYPPictureView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageURLs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pictureCellID, for: indexPath) as! MYPPictureCell
        cell.imageURL = imageURLs![indexPath.item]
        
        return cell
    }

}

// MARK: - 自定义Cell
class MYPPictureCell: UICollectionViewCell {
    // MARK: 属性
    var imageURL: URL? {
        didSet {
            iconView.myp_setImage(with: imageURL, placeholderImage: UIImage(named: "visitordiscover_feed_image_house")!)
        }
    }
    
    // MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 私有方法
    //设置子控件
    fileprivate func setupUI() {
        contentView.addSubview(iconView)
        
        iconView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: 懒加载
    fileprivate lazy var iconView = { () -> UIImageView in
        let iconV = UIImageView()
        iconV.clipsToBounds = true
        iconV.contentMode = .scaleAspectFill
        return iconV
    }()
}


