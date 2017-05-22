//
//  TableViewController.swift
//  01-基础
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

static let ID = "ShopCellID"
    
    
// MARK: - 初始化
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.tableView.register(ShopCell.self, forCellReuseIdentifier: TableViewController.ID)  //注册Cell
        
        
        loadData { (array) in  //在闭包中,访问本类的“属性”或者“方法”,需要添加self.
            print(array)
            self.shops = array
            self.tableView.reloadData()
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
// MARK: - 数据源 Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.shops.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewController.ID, for: indexPath) as! ShopCell
        
        let model = self.shops[indexPath.row]
        
        cell.model = model
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
// MARK: - 私有方法
    
    /// 数据加载
    ///
    /// - Parameter finished: 异步加载完成回调
    func loadData(_ finished: @escaping (_ array: [ShopModel]) -> ()) {
        //1. 执行网络数据加载
        
        //2. 处理数据, 实例化 模型数组
        var list = [ShopModel]()
        for i in 0..<5 {
            let name = "麦当劳\(i)"
            let price = arc4random() % 5 + 50
            let dict:[String: AnyObject] = ["name":name as AnyObject, "price": price as AnyObject]
            
            let model = ShopModel(dict: dict)
            list.append(model)
        }
        
        //3. 回到主线程
        DispatchQueue.main.async { 
            //执行回调
            finished(list)
        }
    }
    
    
// MARK: - 懒加载
    lazy var shops = [ShopModel]()
    
}
