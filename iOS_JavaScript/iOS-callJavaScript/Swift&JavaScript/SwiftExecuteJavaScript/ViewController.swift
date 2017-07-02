//
//  ViewController.swift
//  SwiftExecuteJavaScript
//
//  Created by 孟跃平 on 2017/6/14.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

/*
 * 使用UIWebView执行JavaScript代码
 */

import UIKit

class ViewController: UIViewController {
    
    //网络加载指示器
    lazy var indicatorView: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.center = CGPoint(x: 200, y: 200)
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = UIWebView(frame: view.bounds)
        webView.delegate = self
        webView.scrollView.isHidden = true
        webView.backgroundColor = .gray
        webView.scalesPageToFit = true
        view.addSubview(webView)
        
        let url = Bundle.main.url(forResource:"index", withExtension:"html")!
        webView.loadRequest(URLRequest(url: url))
        
        //添加网络加载指示器
        view.addSubview(indicatorView)
    }
}


extension ViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {//网页开始加载时调用
        
        //指示器开始显示动画
        indicatorView.startAnimating()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {//网页加载完成时调用
        
        //指示器结束显示动画
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) { 
            webView.scrollView.isHidden = false
            self.indicatorView.stopAnimating()
        }
        
        //注意：JavaScript脚本字符串中不需要添加<script></script>标签
        let jsStr_1 = "alert('JS弹框')"
        webView.stringByEvaluatingJavaScript(from: jsStr_1)
        
        
        let jsStr_2 = "var p = document.getElementsByTagName('p')[0];"
        let jsStr_3 = "p.innerHTML = '使用JavaScript很🐂';"
        let jsStr_4 = "p.style.background = 'red';document.body.appendChild(p);"
        webView.stringByEvaluatingJavaScript(from: jsStr_2)
        webView.stringByEvaluatingJavaScript(from: jsStr_3)
        webView.stringByEvaluatingJavaScript(from: jsStr_4)
        
        
        let jsStr_5 = "var li = document.createElement('li');li.innerHTML='执行js代码，dom操作元素';li.style.background = 'gray';document.body.appendChild(li);"
        webView.stringByEvaluatingJavaScript(from: jsStr_5)
    }
}


