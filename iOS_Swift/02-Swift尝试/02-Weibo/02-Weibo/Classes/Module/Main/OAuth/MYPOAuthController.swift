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
    
    
// MARK: - 生命周期
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
    
    deinit {
        print("deinit----OAuthVC--")
    }
    
// MARK: - 私有方法
    
    /// 加载OAuth授权网页
    fileprivate func loadOAuthPage() {
        
        let urlString = "\(k_oauth_url)?client_id=\(k_appKey)&redirect_uri=\(k_appRedirectURI)"
        
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
        let jsString = "document.getElementById('userId').value = '1134471523@qq.com', document.getElementById('passwd').value = 'MENG123456' "
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
    
    /*
     * - Returns: true 持有协议的对象,可以正常工作; 否则就不行;
     */
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    
        //js 调用本地代码
        let urlString = request.url?.absoluteString ?? ""
        
        if urlString.hasPrefix(k_api_url) {   // 判断api地址
            return true
        }
        //"http://www.mengyueping.com/?code=e51042938e74024155edd2c1e9246aca"
        if !urlString.hasPrefix(k_appRedirectURI) { // 判断回调地址
            return false
        }
        
        guard let query = request.url?.query else {
            //获取不到参数列表
            return false
        }
        //"code=a315878e143817c8fc585f2d6c637b41"
        let codeStr = "code="
        let code = query.substring(from: codeStr.endIndex) //获取code码
        
        //请求用户 token
        MYPUserAccountViewModel().loadAccessToken(code)
        
        self.dismiss(animated: false) { () -> Void in
            //发出切换页面通知
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: k_switchRootVCNotification), object: "Welcome")
            
            print("come here")
        }
        
        return false
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
    }
    
}






