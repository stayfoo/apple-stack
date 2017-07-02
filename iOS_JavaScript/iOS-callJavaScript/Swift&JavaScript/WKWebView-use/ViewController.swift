//
//  ViewController.swift
//  WKWebView-use
//
//  Created by 孟跃平 on 2017/6/13.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(webView)
        let url = URL(string: "https://www.baidu.com")!
        webView.load(URLRequest(url: url))
        
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
        //页面开始加载时调用
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print(#function)
        //当内容开始返回时调用
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(#function)
        //页面加载完成之后调用
    }
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
        //服务器重定向页面时调用,并且在 didStartProvisionalNavigation 之后，didCommitNavigation之前调用。
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(#function)
        //页面加载失败时调用
    }
}
extension ViewController: WKUIDelegate {
    
}
