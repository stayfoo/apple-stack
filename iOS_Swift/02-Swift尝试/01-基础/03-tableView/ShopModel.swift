//
//  ShopModel.swift
//  03-tableView
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import Foundation

class ShopModel: NSObject {
    
    var name: String?       //名字
    var price: Double = 0.0 //价格
    
    
    init(dict: [String : AnyObject]) {   //构造方法
        super.init()
        setValuesForKeys(dict)  //KVC设置值
    }
    
    
    
    override var description: String {  //对象描述方法
        let keys = ["name","price"]
        let dict = dictionaryWithValues(forKeys: keys) //通过属性键的数组,将对象转换成字典  kvc
        
        return dict.description
    }
}
