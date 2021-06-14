//
//  API.swift
//  BeepBeep
//
//  Created by Sara Ashraf on 11/27/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import NVActivityIndicatorView

class API: NSObject {
    
    class func POST(url: String, parameters: [String:Any], headers: [String:Any]?,withIndicator: Bool = true, completion: @escaping (_ succeeded: Bool, _ result: [String: AnyObject]) -> Void) {
        if withIndicator {
            //        KRProgressHUD.show()
        }
        request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: (headers as? HTTPHeaders)).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(false, [:])
            //                KRProgressHUD.dismiss()
            case .success(let value):
                print(value)
                completion(true, value as! [String: AnyObject])
                //                KRProgressHUD.dismiss()
            }
        }
        
    }
    
    class func GETGooglePlaces(url: String, parameters: [String:Any]?, headers: [String:Any]?,withIndicator: Bool = true, completion: @escaping (_ succeeded: Bool, _ result: [String: AnyObject]) -> Void) {
        if withIndicator {
            //        KRProgressHUD.show()
        }
        request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: (headers as? HTTPHeaders)).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(false, [:])
            //                KRProgressHUD.dismiss()
            case .success(let value):
                print(value)
                completion(true, value as! [String: AnyObject])
                //                KRProgressHUD.dismiss()
            }
        }
        
    }
    
    
    class func GET(url: String, completion: @escaping (_ succeeded: Bool, _ result: [String: AnyObject]) -> Void) {
        //        KRProgressHUD.show()
        request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (respone) in
            switch respone.result {
            case .failure(let error):
                print(error)
                completion(false, [:])
            //                KRProgressHUD.dismiss()
            case .success(let value):
                print(value)
                completion(true, value as! [String: AnyObject])
                //                KRProgressHUD.dismiss()
            }
        }
    }
    
    class func GETwithHeader(url: String, header:[String:Any]? ,completion: @escaping (_ succeeded: Bool, _ result: [String: AnyObject]) -> Void) {
        //        KRProgressHUD.show()
        request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header as? HTTPHeaders).responseJSON { (respone) in
            switch respone.result {
            case .failure(let error):
                print(error)
                completion(false, [:])
            //                KRProgressHUD.dismiss()
            case .success(let value):
                print(value)
                completion(true, value as! [String: AnyObject])
                //                KRProgressHUD.dismiss()
            }
        }
    }
    
    
    
    /// POST Image To Server with keys
    class func POSTImage(url: String, Images: [Data]?,Keys: [String]?,header:[String:Any]?, parameters:[String: Any]?, completion: @escaping (_ succeeded: Bool, _ result: [String: AnyObject]) -> Void) {
        //        KRProgressHUD.show()
        upload(multipartFormData: { (multipartFromData) in
            if parameters != nil{
                for (key, value) in parameters! {
                    multipartFromData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            if Images != nil{
                for (img ,key) in zip(Images!,Keys!){
                    multipartFromData.append(img, withName: key, fileName: "image.jpg", mimeType: "image/jpg")
                }
            }
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url , method: .post, headers: header as? HTTPHeaders) { (result) in
            switch result {
            case .failure(let error):
                print(error)
                completion(false, [:])
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success(let value):
                        print("💰\(value)")
                        completion(true,  value as! [String : AnyObject])
                    //                        KRProgressHUD.dismiss()
                    case .failure(let error):
                        print(error)
                        completion(false, [:])
                        //                        KRProgressHUD.dismiss()
                    }
                })
            }
        }
    }
    /// POST Image To Server with keys
    class func POSTSound(url: String, sound: Data?,Keys: String?,header:[String:Any]?, parameters:[String: Any]?, completion: @escaping (_ succeeded: Bool, _ result: [String: AnyObject]) -> Void) {
        //        KRProgressHUD.show()
        upload(multipartFormData: { (multipartFromData) in
            if parameters != nil{
                for (key, value) in parameters! {
                    multipartFromData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            if sound != nil{
//                for (img ,key) in zip(sound!,Keys!){
//                    multipartFromData.append(data: img, withName: key, fileName: "Image.jpg", mimeType: "image/jpg")
                    multipartFromData.append(sound!, withName: Keys!, fileName: "audio.3gp", mimeType: "audio/3gp")
//                }
            }
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url , method: .post, headers: header as? HTTPHeaders) { (result) in
            switch result {
            case .failure(let error):
                print(error)
                completion(false, [:])
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success(let value):
                        print("💰\(value)")
                        completion(true,  value as! [String : AnyObject])
                    //                        KRProgressHUD.dismiss()
                    case .failure(let error):
                        print(error)
                        completion(false, [:])
                        //                        KRProgressHUD.dismiss()
                    }
                })
            }
        }
    }
    
}

