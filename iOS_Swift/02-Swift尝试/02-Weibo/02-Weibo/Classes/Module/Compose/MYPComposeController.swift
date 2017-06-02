//
//  MYPComposeController.swift
//  02-Weibo
//
//  Created by apple on 2017/5/30.
//  Copyright © 2017年 MengYP. All rights reserved.
//

import UIKit
import Alamofire

class MYPComposeController: UIViewController {

// MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()  //设置UI
        registerNotification() //注册通知
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if pictureVC.imageList.count == 0 {
            textView.becomeFirstResponder()
        }
    }
    
    deinit { //析构函数
        NotificationCenter.default.removeObserver(self)
    }
    
// MARK: - 私有方法
    //注册通知
    fileprivate func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(MYPComposeController.keyboardWillChangeFrame(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
// MARK: - 事件监听
    //关闭
    @objc fileprivate func close() {
        dismiss(animated: true, completion: nil)
    }
    //发送
    @objc fileprivate func send() {
        upload() //发微博
    }
    //键盘
    @objc fileprivate func keyboardWillChangeFrame(_ noti: Notification) {
        
        let duration = noti.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let rect = (noti.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let offset = -kScreenH + rect.origin.y
        toolBar.snp.updateConstraints { (make) in
            make.bottom.equalTo(offset)
        }
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.view.layoutIfNeeded()  // 强制刷新
        })
    }
    // 工具条 - 选择图片
    @objc fileprivate func pictureToolbarItemClick() {
        textView.resignFirstResponder()
        
        pictureVC.view.snp.updateConstraints { (make) in
            make.height.equalTo(226 + 88 + 60)
        }
    }
    // 工具条 - @
    @objc fileprivate func mentionToolbarItemClick() {
        
    }
    // 工具条 - 预测话题
    @objc fileprivate func trendToolbarItemClick() {
        
    }
    // 工具条 - 表情
    @objc fileprivate func emoticonToolbarItemClick() {
        
    }
    // 工具条 - 添加
    @objc fileprivate func addToolbarItemClick() {
        
    }
    
// MARK: - 懒加载
    fileprivate lazy var textView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 18)
        view.textColor = UIColor.darkGray
        view.backgroundColor = UIColor.randomColor()
        view.alwaysBounceVertical = true
        view.keyboardDismissMode = .onDrag
        
        return view
    }()
    
    fileprivate lazy var placeHolderLabel: UILabel = UILabel(title: "What's on your mind?", color: UIColor.lightGray, fontSize: 18, margin: 0)
    
    fileprivate lazy var toolBar: UIToolbar = UIToolbar()
    
    fileprivate lazy var pictureVC = MYPPicturePickerController()

// MARK: - 网络请求
    fileprivate func upload() {
        
//        let statusStr = textView.text.addingPercentEncoding(withAllowedCharacters: CharacterSet)
        
        var urlString = "https://api.weibo.com/2/statuses/update.json"
        let params = ["access_token": MYPUserAccountViewModel().token, "status": "TEST"]
//        textView.text
        
        if pictureVC.imageList.count > 0 { // 发布图片微博
            
            urlString = "https://upload.api.weibo.com/2/statuses/upload.json"
            let imageData = UIImagePNGRepresentation(pictureVC.imageList.first!)!
            
            
//            Alamofire.upload(multipartFormData: <#T##(MultipartFormData) -> Void#>, to: <#T##URLConvertible#>, encodingCompletion: <#T##((SessionManager.MultipartFormDataEncodingResult) -> Void)?##((SessionManager.MultipartFormDataEncodingResult) -> Void)?##(SessionManager.MultipartFormDataEncodingResult) -> Void#>)
            
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                /*
                 data: 需要上传的文件二进制数据
                 withName: 服务器需要 字段
                 fileName: 服务器存储文件的文件名,可以随便写
                 mimeType: 媒体文件类型
                 */
                multipartFormData.append(imageData, withName: "pic", fileName: "fileName", mimeType: "image/jpeg")
                
            }, to: urlString, encodingCompletion: { (encodingResult) in
//                encodingResult.success
            })
        } else { //没有图片
            
//            ParameterEncoding
            
//            Alamofire.request(urlString, method: .post, parameters: pa, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>)
            
            MYPNetWorking.sharedManager.post(urlString, params) { (response, result) in
                print("result.value: \(result.value!)")
            }
        }
        
    }
    
}

// MARK: - 设置UI
extension MYPComposeController {
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        
        setupNav()      // 设置导航
        setupTextView() // 设置输入框
        setupToolBar()  // 设置工具条
        setupPicturePickerVC() // 设置照片选择
    }
    
    // 设置导航
    fileprivate func setupNav() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MYPComposeController.close))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MYPComposeController.send))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        //自定义导航条 
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        navigationItem.titleView = view
        
        let weiboLabel = UILabel(title: "发微博", color: UIColor.darkGray, fontSize: 17, margin: 0)
        let nameLabel = UILabel(title: MYPUserAccountViewModel().userName ?? "", color: UIColor.lightGray, fontSize: 14, margin: 0)
        
        view.addSubview(weiboLabel)
        view.addSubview(nameLabel)
        
        //设置布局
        weiboLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    // 设置输入框
    fileprivate func setupTextView() {
        view.addSubview(textView)
        textView.delegate = self
        
        textView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(kScreenH / 3)
        }
        
        //占位符
        textView.addSubview(placeHolderLabel)
        placeHolderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.top).offset(8)
            make.left.equalTo(textView.snp.left).offset(5)
        }
    }
    
    // 设置工具条
    fileprivate func setupToolBar() {
        let itemSettings = [
            ["imageName": "compose_toolbar_picture","actionName":"pictureToolbarItemClick"],
            ["imageName": "compose_mentionbutton_background"],
            ["imageName": "compose_trendbutton_background"],
            ["imageName": "compose_emoticonbutton_background"],
            ["imageName": "compose_add_background"]]
        
        var items = [UIBarButtonItem]() // 存放item
        for dict in itemSettings {
            
            let btn = UIButton()
            btn.setImage(UIImage(named: dict["imageName"]!), for: UIControlState())
            btn.setImage(UIImage(named: dict["imageName"]! + "_highlighted"), for: UIControlState.highlighted)
            if "pictureToolbarItemClick" == dict["actionName"] { //添加点击事件
                btn.addTarget(self, action: #selector(MYPComposeController().pictureToolbarItemClick), for: UIControlEvents.touchUpInside)
            }
            btn.sizeToFit()
            
            let item = UIBarButtonItem(customView: btn)
            items.append(item)
            
            let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
            items.append(space)
        }
        items.removeLast()
        
        toolBar.items = items
        view.addSubview(toolBar)
        
        //布局
        toolBar.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    // 设置照片选择
    fileprivate func setupPicturePickerVC() {
        addChildViewController(pictureVC)
        view.addSubview(pictureVC.view)
        
        view.bringSubview(toFront: toolBar)
        
        pictureVC.view.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0)
        }
    }
    
}

// MARK: - 代理（UITextViewDelegate）
extension MYPComposeController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
        placeHolderLabel.isHidden = textView.hasText
    }

}
