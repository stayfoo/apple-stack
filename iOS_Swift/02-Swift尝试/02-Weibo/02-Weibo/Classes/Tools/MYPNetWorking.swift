//
//  MYPNetWorking.swift
//  02-Weibo
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 MengYP. All rights reserved.
//

/// 网络工具类封装

import UIKit
import Alamofire

class MYPNetWorking: NSObject {
    
// MARK: - 单例
    static let sharedManager: MYPNetWorking = {
        let manager = MYPNetWorking()
        
        return manager
    }()
    
    
// MARK: - get 方法
    func get(_ url: String, _ parameters: [String: Any]?, _ completionHandler: @escaping (HTTPURLResponse?, Result<String>) -> Void) {
        
        let param: Parameters?
        if let par = parameters {
            param = par as Parameters
        }else{
            param = nil
        }
//        let param: Parameters? = parameters ? : parameters! as Parameters
        
        let request = Alamofire.request(url, method: .get, parameters: param)
        request.responseString { response in
            if let error = response.error {
                print("网络请求报错：\(error)")
                return
            }
            
            
            completionHandler(response.response, response.result)
        }
    }
    
// MARK: - post 方法
    func post(_ url: String, _ parameters: [String: Any], _ completionHandler: @escaping (HTTPURLResponse?, Result<String>) -> Void) {
        
        let param: Parameters? = parameters as Parameters
        
        let request = Alamofire.request(url, method: .post, parameters: param)
        request.responseString { response in
            if let error = response.error {
                print("网络请求报错：\(error)")
                return
            }
            
            completionHandler(response.response, response.result)
        }
        
    }
    
// MARK: - download 方法
    func download(_ url: String, _ completionHandler: @escaping (HTTPURLResponse?, Result<String>) -> Void) {
        
        let destination = DownloadRequest.suggestedDownloadDestination(
            for: FileManager.SearchPathDirectory.cachesDirectory,
            in: FileManager.SearchPathDomainMask.userDomainMask)
        
        let downloadRequest = Alamofire.download(url, to: destination)
        downloadRequest.responseString { response in
            
            if let error = response.error {
                print("网络请求报错：\(error)")
                return
            }
            
            completionHandler(response.response, response.result)
        }
        
    }
}

// MARK: - 图片下载
extension UIImageView {
    
    func myp_setImage(with url: String?, placeholderImage placeholder: UIImage) {
        
        guard let urlStr = url else {
            image = placeholder
            return
        }
//        if let dataString = MYPFileManager.get(key: urlStr, from: k_imagePath) {
//            
//            let dataImg = Data(base64Encoded: dataString, options: Data.Base64DecodingOptions(rawValue: 0))!
//            self.image = UIImage(data: dataImg)
//            
//            return
//        }

        let request = Alamofire.request(urlStr, method: .get, parameters: nil)
        request.response { response in
            if let error = response.error {
                print("网络请求报错：\(error)")
                self.image = placeholder
                return
            }
            
            if let data = response.data {
                
                let img = UIImage(data: data)!
                self.image = img
                
                var imgData: Data?
                var mimeType: String?
                let alpha = img.cgImage?.alphaInfo
                if alpha == CGImageAlphaInfo.first || alpha == CGImageAlphaInfo.last || alpha == CGImageAlphaInfo.premultipliedFirst || alpha == CGImageAlphaInfo.premultipliedLast {
                    
                    imgData = UIImagePNGRepresentation(img)
                    mimeType = "image/png"
                }else {
                    imgData = UIImageJPEGRepresentation(img, 1.0)
                    mimeType = "image/jpeg"
                }
                
                let _ = "data:\(mimeType!);base64," + (imgData?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)))!
                
//                print(base64Str)
            }
        }
    }
    
    

}



