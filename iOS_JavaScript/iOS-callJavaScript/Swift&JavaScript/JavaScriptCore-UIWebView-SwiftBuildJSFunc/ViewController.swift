//
//  ViewController.swift
//  JavaScriptCore-UIWebView-SwiftBuildJSFunc
//
//  Created by 孟跃平 on 2017/6/24.
//  Copyright © 2017年 www.mengyueping.com. All rights reserved.
//

/*
 * JavaScriptCore结合UIWebView 当点击js函数时，响应Swift操作
 *
     jscontext.setObject(block, forKeyedSubscript: NSString(string: "handleJSToiOS"))
         其中，block是自己定义的一个@convention(block)的Closure
             handleJSToiOS 是JS中触发事件的方法名字；
             这个自定义的闭包通过JSContext对象，将存储的代码块变成名字为jsMethodName的JS方法；所以当触发Html点击事件所监听的jsMethodName方法时，就等于触发了Swift的Closure中的代码。
 
 
     Closure中的执行环境是子线程。可以更新部分UI：view设置背景色、调用webView执行js。弹出原生alertView会Crash子线程操作UI的错误信息。
 
     Closure避免循环引用，因为Closure会持有外部变量，而JSContext也会强引用它所有的变量，闭包中声明self为弱引用[weak self]。Closure内不要使用外部的JSContext对象、JSValue对象。如果要使用JSContext对象，可以使用JSContext.current()，也可以把JSContext对象、JSValue对象当做Closure的参数传入。
 */

import UIKit
import JavaScriptCore
import AVFoundation

class ViewController: UIViewController {
    deinit {
        print(#function)
    }
    lazy var webView: UIWebView = {
        let web = UIWebView(frame: CGRect(x: 30, y: 80, width: UIScreen.main.bounds.width-60, height: UIScreen.main.bounds.height-160))
        web.delegate = self
        return web
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(webView)
//        let url = URL(string: "https://www..com")!
        let url = Bundle.main.url(forResource:"index", withExtension:"html")!
        webView.loadRequest(URLRequest(url: url))
    }
}
// MARK: 代理 UIWebViewDelegate
extension ViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print(#function)
        
        let context = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext")
        guard let jsContext = context else { return }
        let jscontext = jsContext as! JSContext
        
        let block: @convention(block) () -> () = { [weak self] in
            print("CurrentThread: \(Thread.current)") //此Closure是子线程
            
            // 获取js函数传入的参数
            let args = JSContext.currentArguments()
            guard let argments = args else { return }
            var i = 0
            for item in argments {
                print("args[\(i)]: \(item)")
                i += 1
            }
            
            // 使用JSContext执行JS代码，将JS传递给OC/Swift的数据，传递回JS
            //方法一：
//            JSContext.current().evaluateScript("showAlert('\(argments[0])')")
            //方法二：
            JSContext.current().objectForKeyedSubscript("showAlert").call(withArguments: argments)
//            JSContext.current().objectForKeyedSubscript("alert").call(withArguments: argments)
            
            
            
            // 修改原生UI
            DispatchQueue.main.async { //回到主线程
                self!.view.backgroundColor = UIColor.orange
                
                // BOM操作
//                self!.webView.reload()
//                self!.webView.goForward()
//                self!.webView.goBack()
            }
            
            // 播放系统音效
            AudioServicesPlaySystemSound(1007)
            
            /*
             此处可以执行的任务：
                 获取地理位置信息、调用相机、扫一扫二维码、调用系统分享面板、更改原生控件属性样式（回到主线程）、
                 原生调用支付（JS把支付参数传递给OC/Swfit进行支付、OC/Swfit把支付结果反馈给JS）、
                 摇一摇、播放系统音效、
             */
        }
        jscontext.setObject(block, forKeyedSubscript: NSString(string: "handleJSToiOS"))
        
//        jscontext.setObject({
//
//        }, forKeyedSubscript: NSString(string: "handleJSToiOS"))
        
        
    }
}




