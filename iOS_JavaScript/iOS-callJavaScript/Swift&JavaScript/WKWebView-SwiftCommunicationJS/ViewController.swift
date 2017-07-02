//
//  ViewController.swift
//  WKWebView-SwiftCommunicationJS
//
//  Created by 孟跃平 on 2017/6/17.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//
/*
 *  Swift与JS之间的通信
 */

import UIKit
import WebKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 为JS提供了一个发送消息的通道，且可以向页面注入JS的类。
        let userContentController = WKUserContentController()
        userContentController.add(self, name: "JSMessageToIOS")
        // 添加一个脚本信息处理器。self遵守协议WKScriptMessageHandler
        // 脚本信息处理器，可以接收JS脚本发送过来的消息。JS脚本通过`window.webkit.messageHandlers.<name>.postMessage(<messageBody>)`发送消息。
        // 脚本处理器中监听的名字是js脚本里面消息发送的名字。                 window.webkit.messageHandlers.JSMessageToIOS.postMessage(message);
        
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        
        let webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.backgroundColor = .gray
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(webView)
        
        let url = Bundle.main.url(forResource:"index", withExtension:"html")!
        webView.load(URLRequest(url: url))
    }
    
}

extension ViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // 当JS给OC发送消息时，此回调中执行消息处理
        print("JS传递过来的消息-message.body:\(message.body), name：\(message.name)");
        //iOS和js统一好的名字：message.name
        
        //收到JS传递过来的消息回调，可以做一些原生想要做的事情。--> JS向原生OC传递消息。
        //发送网络请求，页面跳转，打开相机等
        let vc = UIViewController()
        vc.title = "name：\(message.name)"
        vc.view = {
            let v = UITextView(frame: self.view.bounds)
            v.text = "body: \(message.body)"
            return v
        }()
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
}

extension ViewController: WKNavigationDelegate {
    
}
extension ViewController: WKUIDelegate {
    
}
