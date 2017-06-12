//
//  EmoticonKeyboardView.swift
//  Emoji
//
//  Created by apple on 2017/6/4.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 表情键盘
 */

import UIKit

fileprivate let toolBarHeight: CGFloat = 36
fileprivate let emoticonCellId = "emoticonCellId"


class EmoticonKeyboardView: UIView {
// MARK: 属性
    fileprivate lazy var packages = EmoticonManager().packages
    var selectEmoticon: (_ em: Emoticon) -> ()
    
    fileprivate lazy var toolBar = UIToolbar()
    fileprivate lazy var collectionView: UICollectionView = {
        
        let w = UIScreen.main.bounds.width / 7
        let margin = (self.bounds.height - 3 * w - toolBarHeight) / 4
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: w, height: w)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        
        cv.dataSource = self
        cv.delegate = self
        cv.register(EmoticonCell.self, forCellWithReuseIdentifier: emoticonCellId)
        
        return cv
    }()
    
// MARK: 构造方法
    init(selectEmoticon: @escaping (_ em: Emoticon) -> ()) {
        self.selectEmoticon = selectEmoticon
        
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 220)
        super.init(frame: rect)
        
        self.layer.borderColor = UIColor.orange.cgColor
        self.layer.borderWidth = 2
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: 事件监听
    @objc fileprivate func itemSelected(_ item: UIBarButtonItem) {
        let indexPath = IndexPath(item: 0, section: item.tag)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
}

// MARK: - 初始化UI
extension EmoticonKeyboardView {
    
    fileprivate func setupUI() {
        addSubview(toolBar)
        addSubview(collectionView)
        
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
        let w = UIScreen.main.bounds.width
        toolBar.frame = CGRect(x: 0, y: self.bounds.height-toolBarHeight, width: w, height: toolBarHeight);
        collectionView.frame = CGRect(x: 0, y: 0, width: w, height: self.bounds.height-toolBarHeight)
        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[toolBar(\(toolBarHeight))]-|", options: [], metrics: nil, views: ["toolBar" : toolBar]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[toolBar]-|", options: [], metrics: nil, views: ["toolBar" : toolBar]))
//        
//        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[collectionView]-|", options: [], metrics: nil, views: ["collectionView" : collectionView]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[collectionView]-[toolBar]", options: [], metrics: nil, views: ["collectionView" : collectionView,"toolBar" : toolBar]))
        
        setupToolBar() // 设置toolBar
    }
    
    fileprivate func setupToolBar() {
        toolBar.tintColor = UIColor.lightGray
        var items = [UIBarButtonItem]()
        
        //设置数据源
        var index = 0
        for p in packages {
            let item = UIBarButtonItem(title: p.group_name_cn, style: UIBarButtonItemStyle.plain, target: self, action: #selector(EmoticonKeyboardView.itemSelected(_:)))
            items.append(item)
            items.last?.tag = index
            index += 1
            
            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            items.append(space)
        }
        
        items.removeLast() //移除最后一个弹簧
        toolBar.items = items
    }
}

// MARK: - 代理 & 数据源 （UICollectionView）
extension EmoticonKeyboardView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packages[section].emoticons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emoticonCellId, for: indexPath) as! EmoticonCell
        let e = packages[indexPath.section].emoticons[indexPath.item]
        cell.emoticon = e
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let e = packages[indexPath.section].emoticons[indexPath.item]
        selectEmoticon(e)  //执行闭包
    }
}

// MARK: - 自定义Cell
class EmoticonCell: UICollectionViewCell {
// MARK: 属性
    
    var emoticon: Emoticon? { //模型
        didSet {
            emoticonBtn.setImage(UIImage(contentsOfFile: emoticon?.imagePath ?? ""), for: UIControlState())
            emoticonBtn.setTitle(emoticon?.emojiStr ?? "", for: UIControlState())
            
            if let e = emoticon, e.isDelete {
                emoticonBtn.setImage(UIImage(named: "compose_emotion_delete"), for: UIControlState())
            }
        }
    }
    
    fileprivate lazy var emoticonBtn = UIButton()
    
// MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI() // 初始化UI
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: 私有方法
    fileprivate func setupUI() {
        emoticonBtn.backgroundColor = UIColor.white
        emoticonBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        emoticonBtn.setTitleColor(UIColor.lightGray, for: UIControlState())
        contentView.addSubview(emoticonBtn)
        
        emoticonBtn.frame = bounds.insetBy(dx: 4, dy: 4) //中心不变，宽+dx，高+dy
        emoticonBtn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        
        emoticonBtn.isUserInteractionEnabled = false
    }
}


