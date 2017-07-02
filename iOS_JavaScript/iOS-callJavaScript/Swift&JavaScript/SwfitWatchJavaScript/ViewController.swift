//
//  ViewController.swift
//  SwfitWatchJavaScript
//
//  Created by 孟跃平 on 2017/6/15.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

/*
 *  Swift利用UIWebView监听JavaScript函数的触发
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = UIWebView(frame: view.bounds)
        webView.delegate = self
        webView.backgroundColor = .gray
        webView.scalesPageToFit = true
        view.addSubview(webView)
        
        let url = Bundle.main.url(forResource:"index", withExtension:"html")!
        webView.loadRequest(URLRequest(url: url))
    }
    
    // iOS原生方法访问相册
    @objc fileprivate func openCamera() {
        let pickerVC = UIImagePickerController()
        pickerVC.sourceType = .photoLibrary
        self.present(pickerVC, animated: true, completion: nil)
    }
}

extension ViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let url = request.url?.absoluteString
        let range = url?.range(of: "mengyueping.com://") //自定义协议
        guard let _ = range else {
            return true
        }
        
        let str = url?.substring(from: "mengyueping.com://".endIndex)
        guard let selStr = str else {
            return true
        }
        let selector = Selector(selStr)
        perform(selector)
        
        return true
    }
}


