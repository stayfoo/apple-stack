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
        
        if !userLogin {
            visitorLoginView?.setWithInfo("周边看一看", imageName: nil)
            return
        }
        
        setupTableView()
        //网络请求
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !userLogin {
            return
        }
        
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
        tableView.separatorStyle = .none
        
        //刷新
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(MYPHomeController.loadData), for: UIControlEvents.valueChanged)
        
        tableView.tableFooterView = indicatorView
        
    }
    
//MARK: - 懒加载
    fileprivate lazy var statuses = [MYPStatus]()
    
    fileprivate lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        return indicator
    }()
    
//MARK: - 数据加载
    @objc fileprivate func loadData() {
        
        refreshControl?.beginRefreshing() // 主动触发动画，不能够主动触发相应事件
        
        var since_id = 0  // 返回ID比since_id大的微博
        var max_id = 0    // 返回ID小于或等于max_id的微博
        if indicatorView.isAnimating { //上拉加载更多
            
            since_id = 0
            max_id = statuses.last?.id ?? 0
        } else {
            
            max_id = 0
            since_id = statuses.first?.id ?? 0
        }
        
        
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        guard let token = MYPUserAccountViewModel().token else {
            print("您暂未登录")
            return
        }
        
        let params = ["access_token" : token,
                      "since_id": since_id,
                      "max_id": max_id] as [String : Any]
        
        Alamofire.request(urlString, method: .get, parameters: params).responseData { response in
            
            self.refreshControl?.endRefreshing()
            
            
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
            
            if since_id > 0 {//下拉刷新,拼接
                
                self.statuses = list + self.statuses
            } else if max_id > 0 {//上拉加载更多
                
                self.statuses += list
                self.indicatorView.stopAnimating() // 停止动画
            } else {//首次
                
                self.statuses = list
            }
            
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
        
        //最后一条，加载更多
        if indexPath.row == statuses.count - 2 && !indicatorView.isAnimating {
            indicatorView.startAnimating()
            loadData()
        }
        return cell
    }
}
