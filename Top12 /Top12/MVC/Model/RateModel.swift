//
//  RateModel.swift
//  Top12
//
//  Created by Sara Ashraf on 4/4/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//
import Foundation
class  RateModel {
    var comment_id:  String? = ""
    var comment_user_id:   String? = ""
    var comment_username:  String? = ""
    var comment_user_img: String? = ""
    var comment:  String? = ""
    var comment_date:  String? = ""
    var stars : String? = ""
    
    func getObject(dicc: [String: Any]) -> RateModel {
        
        
        let dic = HandleJSON.getObject().handle(dicc: dicc)
        let model = RateModel()
        
        model.comment_id = dic["comment_id"] as! String
        model.comment_user_id = dic["comment_user_id"] as! String
        model.comment_username = dic["comment_username"] as! String
        model.comment_user_img = dic["comment_user_img"] as! String
        model.comment = dic["comment"] as! String
        model.comment_date = dic["comment_date"] as! String
        model.stars = dic["stars"] as! String
        
        return model
        
    }
}
