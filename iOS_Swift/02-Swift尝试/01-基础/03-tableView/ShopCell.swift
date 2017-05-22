//
//  ShopCell.swift
//  03-tableView
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import UIKit


class ShopCell: UITableViewCell {
// MARK: - 接口
    
    
    var model: ShopModel? {
        willSet {
            print("newValue--\(newValue)--- ShopModel==\(model)")
            
            guard newValue != nil else {
                return
            }
            self.nameLabel.text = newValue!.name
            self.priceLabel.text = newValue!.price.description
        }
        didSet {
            print("oldValue---\(oldValue)--- ShopModel==\(model)")
        }
    }
    
    
// MARK: - 懒加载
    lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = UIColor.orange
        label.frame = CGRect(origin: CGPoint(x: 15, y: 15),size: CGSize(width: 100, height: 30))
        
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = UIColor.gray
        label.frame = CGRect(origin: CGPoint(x: 115, y: 15),size: CGSize(width: 100, height: 30))
        return label
    }()
    
    
// MARK: - 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        //初始化
        self.addSubview(self.nameLabel)
        self.addSubview(self.priceLabel)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

