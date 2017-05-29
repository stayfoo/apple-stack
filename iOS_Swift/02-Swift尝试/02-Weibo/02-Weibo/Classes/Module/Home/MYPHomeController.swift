//
//  MYPHomeController.swift
//  02-Weibo
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import UIKit
import Alamofire

private let HomeCellId = "HomeCellId"

class MYPHomeController: MYPBaseController {

// MARK: - 初始化
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorLoginView?.setWithInfo("周边看一看", imageName: nil)
        
        setupTableView()
        
        //网络请求
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - 私有方法
    fileprivate func setupTableView() {
        tableView.register(MYPStatusCell.self, forCellReuseIdentifier: HomeCellId)
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension // 自动计算行高
//        tableView.separatorStyle = .none
 
    }
    
//MARK: - 懒加载
    fileprivate lazy var statuses = [MYPStatus]()
    
//MARK: - 数据加载
    fileprivate func loadData() {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        guard let token = MYPUserAccountViewModel().token else {
            print("您暂未登录")
            return
        }
        
        let params = ["access_token" : token]
        
        Alamofire.request(urlString, method: .get, parameters: params).responseData { response in
            
            let jsonStr = try? JSONSerialization.jsonObject(with: response.data!, options: [])
            
            guard let json = jsonStr as? [String : AnyObject] else{
                print("数据类型有误")
                return
            }
            
            guard let jsonArr = json["statuses"] as? [[String : AnyObject]] else {
                print("数据类型有误")
                return
            }
            
            var list = [MYPStatus]()
            for item in jsonArr {
                let s = MYPStatus(dict: item) //字典转模型
                list.append(s)
            }
            
            self.statuses = list
            self.tableView.reloadData()
        }
    }
    
}

extension MYPHomeController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return statuses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCellId, for: indexPath) as! MYPStatusCell
//        cell.backgroundColor = .red
        
        cell.model = statuses[indexPath.row]
        
        return cell
    }
}
