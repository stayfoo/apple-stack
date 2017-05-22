//
//  ViewController.swift
//  02-构造函数
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 MengYP. All rights reserved.
//


/*
 在swift中,使用命名空间, 在同一个命名空间下所有的“文件”和“方法”都是共享的不需要导入头文件。
 */

import UIKit

class ViewController: UIViewController {

// MARK: - 初始化
    override func loadView() {
//        print(view) //此时 View还没有创建，报错
        super.loadView()
        print(view)   //此时 View已经创建
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let p = Person(name: "小明", age: 16)
        print(p, p.name,p.age)
        
        
        let s = Student(name: "小刚", age: 18, no: "110")
        print(s, s.name, s.age, s.no)
        
        
        // this class is not key value coding-compliant for the key title.
        let a = Animal(dict: ["name":"Tom" as AnyObject, "age":20 as AnyObject, "title":"Coder" as AnyObject])
        print(a.name!, a.age)
        
        
        //懒加载控件
        print(nameLabel)
        print(imageView)
        
        
        //单例
        let tools = NetworkTools.shareTools
        let t = NetworkTools.tools
        print(tools) // 0x60000004fe70
        print(t)     // 0x60000004fe70
        
        
        //setget
        let r = Rider()
        r.name = "骑车"
        print(r.name!, r.title!)
        
        
        //控件
        let v = UIView(frame:CGRect(x:50, y:50, width: 100, height: 100))
        v.backgroundColor = UIColor.orange
        self.view.addSubview(v)
        
        let btn = UIButton(type: UIButtonType.contactAdd)
        btn.center = v.center
        self.view.addSubview(btn)
        
        
    }
    
// MARK: - 懒加载
    lazy var nameLabel: UILabel = {
        print("懒。。。。")
        let label = UILabel()
        return label
    }()
    
    lazy var imageView: UIImageView = UIImageView()
    
    
    
}

