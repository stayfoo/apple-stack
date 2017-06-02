//
//  MYPPicturePickerController.swift
//  02-Weibo
//
//  Created by apple on 2017/5/31.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let rowCount: CGFloat = 4           //每行个数
private let pictureCellMargin: CGFloat = 10
private let maxImageCount = 3

class MYPPicturePickerController: UICollectionViewController {
    // MARK: 属性
    lazy var imageList = [UIImage]() //图片数组
    
    // MARK: 构造方法
    init() {
        let w = (kScreenW - (rowCount + 1) * pictureCellMargin) / rowCount
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: w, height: w)
        layout.sectionInset = UIEdgeInsets(top: pictureCellMargin, left: pictureCellMargin, bottom: 0, right: pictureCellMargin)
        layout.minimumLineSpacing = pictureCellMargin
        layout.minimumInteritemSpacing = pictureCellMargin
        
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        
        self.collectionView!.register(MYPPicturePickerCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - 代理实现
// MARK: 数据源 & 代理 UICollectionView
extension MYPPicturePickerController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let detla = (imageList.count == maxImageCount ? 0 : 1)
        let count = imageList.count + detla
        
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MYPPicturePickerCell
        
        cell.backgroundColor = UIColor.randomColor()
        cell.delegate = self
        if indexPath.item == imageList.count {
            cell.iconImage = nil
        } else {
            cell.iconImage = imageList[indexPath.item]
        }
        
        return cell
    }
}

// MARK: 代理（MYPPicturePickerCellDelegate）
extension MYPPicturePickerController: MYPPicturePickerCellDelegate {
    
    func willChosePicture(_ cell: MYPPicturePickerCell) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
//        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func willDeletePicture(_ cell: MYPPicturePickerCell) {
        
        let indexPath = collectionView!.indexPath(for: cell)!
        imageList.remove(at: indexPath.item)
        
        collectionView?.reloadData()
    }
}

// MARK: 相册选择 (UIImagePickerControllerDelegate)
extension MYPPicturePickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
//        print(info) // UIImagePickerControllerEditedImage
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageList.append(image)
        
        collectionView?.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - 自定义Cell
class MYPPicturePickerCell: UICollectionViewCell {
    // MARK: 属性
    weak var delegate: MYPPicturePickerCellDelegate?
    var iconImage: UIImage? {
        didSet {
            deleteBtn.isHidden = (iconImage == nil)
            if iconImage == nil {
                addBtn.setImage(UIImage(named: "compose_pic_add"), for: UIControlState())
            }
            addBtn.setImage(iconImage, for: UIControlState())
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
    
    // MARK: 事件监听
    @objc fileprivate func addBtnClick() {
        delegate?.willChosePicture?(self) //通知代理
    }
    
    @objc fileprivate func deleteBtnClick() {
        delegate?.willDeletePicture?(self) //通知代理
    }
    
    // MARK: 私有方法
    fileprivate func setupUI() {
        
        contentView.addSubview(addBtn)
        contentView.addSubview(deleteBtn)
        
        addBtn.imageView?.contentMode = .scaleAspectFill
        
        addBtn.addTarget(self, action: #selector(MYPPicturePickerCell.addBtnClick), for: UIControlEvents.touchUpInside)
        deleteBtn.addTarget(self, action: #selector(MYPPicturePickerCell.deleteBtnClick), for: UIControlEvents.touchUpInside)
        
        addBtn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        deleteBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    // MARK: 懒加载
    fileprivate lazy var addBtn = UIButton(imageName: "compose_pic_add", backgroundImage: nil)
    fileprivate lazy var deleteBtn = UIButton(imageName: "compose_photo_close", backgroundImage: nil)
    
}

// MARK: - 定义协议
@objc protocol MYPPicturePickerCellDelegate: NSObjectProtocol {
    
    //选择图片
    @objc optional func willChosePicture(_ cell: MYPPicturePickerCell)
    
    //删除图片
    @objc optional func willDeletePicture(_ cell: MYPPicturePickerCell)
}
