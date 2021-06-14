//
//  ProviderBaseService.swift
//  Ayadena
//
//  Created by Sara Ashraf on 10/31/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class ProviderBaseService : NSObject{
   
    
    class func getNotfications(user_id:String,vc:UIViewController,completion: @escaping (_ error: Error?, _ Notfications: [NotficationModel]?)->Void){
        
        let url = Notfications_URL
        let params: Parameters = [
            
            "user_id": user_id,
            "lang":getServerLang()
        ]
        Alamofire.request(url, method: .post, parameters: params).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].int
                print("🌹\(response)")
                if(status == 1){
                    
                    
                    guard let dataArray = json["data"].array else {
                        completion(nil, nil)
                        return
                    }
                    var Notifcations = [NotficationModel]()
                    
                    for data in dataArray{
                        guard let data = data.dictionary else {return}
                        let notfi = NotficationModel()
                        notfi.id = data["id"]?.int
                        notfi.msg = (data["msg"]?.string)!
                        notfi.date = (data["date"]?.string)!
                        notfi.order_id = (data["order_id"]?.int)!
                       // notfi.taggable_id = (data["taggable_id"]?.string)!
                        notfi.type = (data["type"]?.string)!
                        notfi.seen = (data["seen"]?.bool)!
                        notfi.status = (data["order_status"]?.string)!
                        Notifcations.append(notfi)
                        
                    }
                    completion(nil, Notifcations)
                    print(value)
                }else{
                    let alert = UIAlertController(title: "Error".localized(), message: "Error", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Done".localized(), style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                        case .cancel:
                            print("cancel")
                        case .destructive:
                            print("destructive")
                            
                        }}))
                    vc.present(alert, animated: true, completion: nil)
                    
                }
            case .failure(let error):
                completion(error, nil)
                print(error)
            }
            
        }
        
    }
    
    
    
    
}
