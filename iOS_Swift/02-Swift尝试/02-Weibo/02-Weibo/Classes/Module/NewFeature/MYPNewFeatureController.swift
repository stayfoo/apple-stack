//
//  MYPNewFeatureController.swift
//  02-Weibo
//
//  Created by apple on 2017/5/24.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/*
 新特性页面
 */


import UIKit

private let reuseID_MYPNewFeatureCell = "reuseID_MYPNewFeatureCell"
private let maxImageCount = 4  //最大显示页数

class MYPNewFeatureController: UICollectionViewController {
    
// MARK: 初始化
    init() {
        //设置cell大小
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = kScreenSize
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        super.init(collectionViewLayout: layout) //调用父类方法初始化
        
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        // 注册 cell
        self.collectionView!.register(MYPNewFeatureCell.self, forCellWithReuseIdentifier: reuseID_MYPNewFeatureCell)
    }

}

// MARK: - 数据源 UICollectionViewDataSource

extension MYPNewFeatureController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxImageCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID_MYPNewFeatureCell, for: indexPath) as! MYPNewFeatureCell
        cell.index = indexPath.item
        
        return cell
    }
}

// MARK: - 代理 UICollectionViewDelegate

extension MYPNewFeatureController {
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let cell = collectionView.visibleCells.last as! MYPNewFeatureCell
        let index = collectionView.indexPath(for: cell)
        let indexItem = index?.item ?? 0
        if indexItem == maxImageCount - 1 {
            cell.startAnimation()
        }
    }
   
}

// MARK: - 自定义Cell UICollectionViewCell
class MYPNewFeatureCell: UICollectionViewCell {
// MARK: 接口
    func startAnimation() {
        
        startBtn.isHidden = false
        startBtn.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {() -> Void in
            
            self.startBtn.transform = CGAffineTransform.identity
        }, completion: nil)
        
        /*
         iOS 7.0 推出的动画效果：弹簧系数 * 10 ~= 加速度
         withDuration:           持续事件
         delay:                  延迟时间
         usingSpringWithDamping: 弹簧效果 0.1 ~ 1之间  越小越弹
         initialSpringVelocity:  加速度
         options:                动画可选项
         animations:             完成动画闭包
         completion:             动画结束后的闭包
         */
        
    }
    
// MARK: 属性
    var index: Int = 0 {
        didSet {
            iconView.image = UIImage(named: "new_feature_\(index+1)")
            startBtn.isHidden = true
        }
    }
    
    
// MARK: 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
// MARK: 私有方法
    
    /// 初始化子控件
    fileprivate func setupUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(startBtn)
        
        startBtn.addTarget(self, action: #selector(MYPNewFeatureCell.startBtnDidClick), for: UIControlEvents.touchUpInside)
    }
    
    /// 布局子控件
    fileprivate func setupLayout() {
        for child in contentView.subviews {
            child.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //图片
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[iconView]-0-|", options: [], metrics: nil, views: ["iconView": iconView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[iconView]-0-|", options: [], metrics: nil, views: ["iconView":iconView]))
        
        //开始按钮
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[startBtn]-(180)-|", options: [], metrics: nil, views: ["startBtn":startBtn]))
        addConstraint(NSLayoutConstraint(item: startBtn, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
    }

// MARK: 事件监听
    @objc fileprivate func startBtnDidClick() {
        print(#function)
        
        // 发出切换页面通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: k_switchRootVCNotification), object: nil)
    }
    
// MARK: 懒加载
    //图片
    fileprivate lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "new_feature_1"))
    
    //开始按钮
    fileprivate lazy var startBtn = UIButton(title: "开始体验", backgroundImage: "new_feature_finish_button", color: UIColor.white, fontSize: 18, isNeedHighlighted: true)
}

