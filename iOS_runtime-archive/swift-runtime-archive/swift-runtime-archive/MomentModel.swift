//
//  MomentModel.swift
//  swift-runtime-archive
//
//  Created by 孟跃平 on 2017/7/17.
//  Copyright © 2017年 com.mengyueping.www. All rights reserved.

// 一般归档

import UIKit

class MomentModel: NSObject, NSCoding {
    var content: String?
    var time: String?
    var pic: String?
    var place: String?
    
    override init() {
        super.init()
    }
    
    // MARK: - 归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(content, forKey: "content")
        aCoder.encode(time, forKey: "time")
        aCoder.encode(pic, forKey: "pic")
        aCoder.encode(place, forKey: "place")
    }
    // MARK: - 解档
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        content = aDecoder.decodeObject(forKey: "content") as? String
        time = aDecoder.decodeObject(forKey: "time") as? String
        pic = aDecoder.decodeObject(forKey: "pic") as? String
        place = aDecoder.decodeObject(forKey: "place") as? String
    }
}

