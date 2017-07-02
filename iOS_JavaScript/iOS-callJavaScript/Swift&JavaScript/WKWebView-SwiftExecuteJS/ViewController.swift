//
//  ViewController.swift
//  WKWebView-SwiftExecuteJS
//
//  Created by 孟跃平 on 2017/6/15.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

/*
 * 使用WKWebView执行JavaScript代码
 */

import UIKit
import WebKit

class ViewController: UIViewController {
    
    //网络加载指示器
    lazy var indicatorView: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.center = CGPoint(x: 200, y: 200)
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.scrollView.isHidden = true
        webView.backgroundColor = .gray
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(webView)
        
        let url = Bundle.main.url(forResource:"index", withExtension:"html")!
        webView.load(URLRequest(url: url))
        
        //添加网络加载指示器
        view.addSubview(indicatorView)
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(#function) //页面开始加载时调用
        
        //指示器开始显示动画
        indicatorView.startAnimating()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(#function) //页面加载完成之后调用
        
        //指示器结束显示动画
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) {
            webView.scrollView.isHidden = false
            self.indicatorView.stopAnimating()
        }
        
        //注意：JavaScript脚本字符串中不需要添加<script></script>标签
//        let jsStr_1 = "alert('JS弹框')"
//        webView.evaluateJavaScript(jsStr_1) { (value, error) in
//            print(value ?? "value",error ?? "error")
//        }
        
        
        let jsStr_1 = "var p = document.getElementsByTagName('p')[0];"
        let jsStr_2 = "p.innerHTML = '使用JavaScript很🐂';"
        let jsStr_3 = "p.style.background = 'red';document.body.appendChild(p);"
        webView.evaluateJavaScript(jsStr_1, completionHandler: nil)
        webView.evaluateJavaScript(jsStr_2) { (value, error) in
            print(value ?? "") //打印出插入的内容：使用JavaScript很🐂
        }
        webView.evaluateJavaScript(jsStr_3, completionHandler: nil)
        
        
        let jsStr_4 = "var li = document.createElement('li');li.innerHTML='执行js代码，dom操作元素';li.style.background = 'gray';document.body.appendChild(li);"
        webView.evaluateJavaScript(jsStr_4, completionHandler: nil)
    }
}
extension ViewController: WKUIDelegate {
    
}

