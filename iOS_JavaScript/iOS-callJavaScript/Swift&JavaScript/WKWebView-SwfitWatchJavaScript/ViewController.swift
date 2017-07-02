//
//  ViewController.swift
//  WKWebView-SwfitWatchJavaScript
//
//  Created by 孟跃平 on 2017/6/15.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

/*
 *  Swift利用WKWebView监听JavaScript函数的触发
 */

import UIKit
import WebKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.backgroundColor = .gray
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(webView)
        
        let url = Bundle.main.url(forResource:"index", withExtension:"html")!
        webView.load(URLRequest(url: url))
    }
    
    // iOS原生方法访问相册
    @objc fileprivate func openCamera() {
        let pickerVC = UIImagePickerController()
        pickerVC.sourceType = .photoLibrary
        self.present(pickerVC, animated: true, completion: nil)
    }
}

// 代理 WKNavigationDelegate
extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) { //页面重定向时调用，不是每次都调用，不准确
        
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) { // 在发送请求之前，决定是否跳转，可以截获发送的请求
        
        decisionHandler(.allow)
        
        let url = navigationAction.request.url?.absoluteString
        let range = url?.range(of: "mengyueping.com://") //自定义协议
        guard let _ = range else {
            return
        }
        
        let str = url?.substring(from: "mengyueping.com://".endIndex)
        guard let selStr = str else {
            return
        }
        let selector = Selector(selStr)
        perform(selector)
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) { // 在收到响应后，决定是否跳转，可以截获服务器的响应数据
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(#function) //页面开始加载时调用
        // 不是每次都调用，只有decisionHandler(.allow)时才能调用此方法
    }
}
extension ViewController: WKUIDelegate {
        
}
