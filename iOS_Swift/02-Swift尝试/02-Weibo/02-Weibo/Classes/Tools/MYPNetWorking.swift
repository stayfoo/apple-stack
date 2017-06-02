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

// MARK: - Alamofire
    
// MARK: 单例
    static let sharedManager: MYPNetWorking = {
        let manager = MYPNetWorking()
        
        return manager
    }()
    
    
    // get 方法
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
    
    // post 方法
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
    
    // download 方法
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

// MARK: 图片下载
extension UIImageView {
    
    func myp_setImage(with url: URL?, placeholderImage placeholder: UIImage) {
        
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


// MARK: - URLSession

extension MYPNetWorking {
    
    func fetchData(url: String) { // ,@escaping ()
        let urlObj = URL(string: url)!
        
        var urlRequest = URLRequest(
            url: urlObj,
            cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
//        open func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
        
        let task: URLSessionDataTask = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: urlRequest) { (data, response, error) in
            
            guard error == nil else {
                print("Error : \(error)")
                return
            }
            
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] else {
                print("data is nil(数据为空)")
                return
            }
            
            print("json: \(json)")
        }
        
        task.resume()
    }
}

