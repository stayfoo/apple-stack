//
//  ViewController.swift
//  Swift&JavaScript
//
//  Created by 孟跃平 on 2017/6/13.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

/*
 * 使用UIWebView加载HTML
 */

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = UIWebView(frame: view.bounds)
        webView.delegate = self
        view.addSubview(webView)
        let url = URL(string: "https://www.baidu.com")!
        webView.loadRequest(URLRequest(url: url))
        
    }
}

extension ViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print(#function)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print(#function)
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(#function)
    }
}
