//
//  MYPOAuthController.swift
//  02-Weibo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 MengYP. All rights reserved.
//
/*
 OAuth授权请求
 */

import UIKit

class MYPOAuthController: UIViewController {

// MARK: - 属性
    let webView = UIWebView()
    
    
// MARK: - 初始化
    override func loadView() {
        view = webView
        webView.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MYPOAuthController.close))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MYPOAuthController.defaultAccount))
        
        loadOAuthPage() //加载页面
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - 私有方法
    
    /// 加载OAuth授权网页
    fileprivate func loadOAuthPage() {
        
        let urlString = "\(k_oauth_url)?client_id=\(k_client_id)&redirect_uri=\(k_redirect_uri)"
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
        
    }
    
// MARK: - 事件监听
    @objc fileprivate func close() {
        print(#function)
        
        dismiss(animated: true, completion: nil)
    }
    
    /// 自动填充账户密码
    @objc fileprivate func defaultAccount() {
        print(#function)
        
        // 与js通讯
        let jsString = "document.getElementById('userId').value = '18399226929', document.getElementById('passwd').value = 'w123456' "
        webView.stringByEvaluatingJavaScript(from: jsString)
    }
}

// MARK: - 代理 UIWebViewDelegate

// 使用 extension 为当前类直接扩展协议方法
extension MYPOAuthController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView){
        print("HUD 显示")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        print("HUD 关闭")
    }
    
    ///
    ///
    /// - Parameters:
    /// - Returns: true 持有协议的对象,可以正常工作; 否则就不行;
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    
        //js 调用本地代码
        let urlString = request.url?.absoluteString ?? ""
        
        if urlString.hasPrefix("https://api.weibo.com/") {
            return true
        }
        
        guard let query = request.url?.query else {
            //获取不到参数列表
            return false
        }
        
        let codeStr = "code="
        let code = query.substring(from: codeStr.endIndex) //获取code码
        
        //请求用户 token
        loadAccessToken(code)
        
        return false
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
    }
    
// MARK: - 网络请求
    
    /// 获取用户信息
    ///
    /// - Parameter account: 用户模型
    fileprivate func loadUserInfo(_ account: MYPUserAccount) {
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        guard let access_token = account.access_token, let userId = account.uid else {
            print("获取网络数据失败,请稍后再试")
            return
        }
        
        let parameters = ["access_token": access_token, "uid": userId]
        
        MYPNetWorking.sharedManager.get(urlString, parameters) { response, result in
            
            if let response = response {
                print("response: \(response) -- result: \(result)")
            }
            
//            account.avatar_large = result["avatar_large"] as? String
//            account.name = result["name"] as? String
        }
    }
    
    /// 获取token
    ///
    /// - Parameter code: code 码
    fileprivate func loadAccessToken(_ code: String) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id": k_client_id,
                      "client_secret" : k_client_secret,
                      "grant_type":"authorization_code",
                      "code":code,
                      "redirect_uri":k_redirect_uri]
        
        MYPNetWorking.sharedManager.get(urlString, params) { response, result in
            print("response: \(response) -- result: \(result)")
            
            //拿到用户token之后 立即请求用户信息
//            guard let dict = result as? [String: AnyObject] else {
//                return
//            }
//            let account = UserAccount(dict: dict)
            //加载用户信息
//            self.loadUserInfo(account)
        }
        
    }
}



















