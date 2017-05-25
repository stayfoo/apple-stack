//
//  MYPUserAccountViewModel.swift
//  02-Weibo
//
//  Created by apple on 2017/5/25.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import UIKit

class MYPUserAccountViewModel: NSObject {
// MARK: - 属性 
    // 计算性属性
    var account: MYPUserAccount? // 模型
    
    var userLogin: Bool {        // 用户是否登录
        return account?.access_token != nil
    }
    
    var token: String? {
        return account?.access_token
    }
    
    var userName: String? {   // 用户名
        return account?.name
    }
    
    var headImageURL: URL? {  // 用户头像 url
        let url = URL(string: account?.avatar_large ?? "")
		return url
    }
    
// MARK: - 初始化
    override init() {
        super.init()
        account = MYPUserAccount.loadAccount()
        // 沙盒获取模型成功,代表已经授权；获取nil,代表没有授权|授权过期;
    }
    
    deinit {
        print("deinit----UserViewModel--")
    }

// MARK: - 网络请求
    
    /*
     * 获取token
     *
     * - Parameter code: code 码
     */
    func loadAccessToken(_ code: String) {
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id": k_appKey,
                      "client_secret" : k_appSecret,
                      "grant_type":"authorization_code",
                      "code":code,
                      "redirect_uri":k_appRedirectURI]
        
        MYPNetWorking.sharedManager.post(urlString, params) { response, result in
//            print("response: \(response) -- result: \(result)")
//            print("result: \(result.value!)")
            /*
             
             response: Optional(<NSHTTPURLResponse: 0x60000022fd60> 
             { 
                URL: https://api.weibo.com/oauth2/access_token
             } 
             { status code: 200, 
                headers {
                    "Cache-Control"  = "no-cache";
                    "Content-Length" = 117;
                    "Content-Type"   = "text/plain;charset=UTF-8";
                    Date             = "Thu, 25 May 2017 06:40:41 GMT";
                    Expires          = "Thu, 01 Jan 1970 00:00:00 GMT";
                    Pragma           = "No-cache";
                    Server           = "nginx/1.6.1";
                    "api-server-ip"  = "10.75.25.115";
                }
             })
             result: SUCCESS
             
             result.value! : 
             {
                "access_token"  : "2.006THbZCXOZ8zDb0b772e9492IXhJD",
                "remind_in"     : "157679999",
                "expires_in"    : 157679999,
                "uid"           : "2358284291"
             }
             */
            
            //            if !JSONSerialization.isValidJSONObject(result.value!) {
            //                return
            //            }
            
            //解析JSON
            let data = result.value?.data(using: String.Encoding.utf8)
            
            let jsonDict = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
            
            //拿到用户token之后 立即请求用户信息
            guard let dict = jsonDict as? [String: AnyObject] else {
                return
            }
            let account = MYPUserAccount(dict: dict)
            
            //请求：用户信息
            self.loadUserInfo(account)
        }
        
    }
    
    /*
     * 获取用户信息
     *
     * - Parameter account: 用户模型
     */
    fileprivate func loadUserInfo(_ account: MYPUserAccount) {
        
        guard let access_token = account.access_token, let userId = account.uid else {
            print("获取网络数据失败,请稍后再试")
            return
        }
        
        let urlString = "https://api.weibo.com/2/users/show.json"
        let parameters = ["access_token": access_token,
                          "uid": userId]
        
        MYPNetWorking.sharedManager.get(urlString, parameters) { response, result in
            
            if let response = response {
                print("response: \(response) -- result: \(result.value!)")
            }
            
            /*
             response: <NSHTTPURLResponse: 0x608000031760> 
             { 
                URL: https://api.weibo.com/2/users/show.json?access_token=2.006THbZCXOZ8zDb0b772e9492IXhJD&uid=2358284291 
             } 
             { 
                status code: 200,
                headers {
                    "Content-Encoding" = gzip;
                    "Content-Type" = "application/json;charset=UTF-8";
                    Date = "Thu, 25 May 2017 07:48:42 GMT";
                    Server = "nginx/1.6.1";
                    Vary = "Accept-Encoding";
                    "api-server-ip" = "10.75.71.233";
                }
             } 
             result.value!: 
             {
                \"id\":2358284291,
                \"idstr\":\"2358284291\",
                \"class\":1,
                \"screen_name\":\"Meng大虾\",
                \"name\":\"Meng大虾\",
                \"province\":\"41\",
                \"city\":\"1\",
                \"location\":\"河南 郑州\",
                \"description\":\"\",
                \"url\":\"\",
                \"profile_image_url\":\"http://tva2.sinaimg.cn/crop.0.0.180.180.50/8c909003jw1e8qgp5bmzyj2050050aa8.jpg\",
                \"profile_url\":\"u/2358284291\",
                \"domain\":\"\",
                \"weihao\":\"\",
                \"gender\":\"m\",
                \"followers_count\":21,
                \"friends_count\":113,
                \"pagefriends_count\":2,
                \"statuses_count\":120,
                \"favourites_count\":2,
                \"created_at\":\"Fri Nov 18 15:10:49 +0800 2011\",
                \"following\":false,
             }
             
             */
            
            
            //解析JSON
            let data = result.value?.data(using: String.Encoding.utf8)
            let jsonDict = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
            
            guard let dict = jsonDict as? [String: AnyObject] else {
                return
            }

            account.avatar_large = dict["avatar_large"] as? String
            account.name = dict["name"] as? String
            account.saveAccount() // 保存到沙盒（用户信息）
        }
    }


}
