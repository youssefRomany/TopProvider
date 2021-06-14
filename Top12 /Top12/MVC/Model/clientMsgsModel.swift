//
//  clientMsgsModel.swift
//  Top12
//
//  Created by Sara Ashraf on 3/23/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import Foundation
class clientMsgsModel {
    var id = ""
    var order = ""
    var user = ""
    var username = ""
    var avatar = ""
    var msg = ""
    var type = ""
    var sent_at = ""
    
    
    
    func getObject(dicc: [String: Any]) -> clientMsgsModel {
        let dic = HandleJSON.getObject().handle(dicc: dicc)
        let model = clientMsgsModel()
        model.id = dic["id"] as! String
        model.order = dic["order"] as! String
        model.user = dic["user"] as! String
        model.username = dic["username"] as! String
        model.avatar = dic["avatar"] as! String
        model.msg = dic["msg"] as! String
        model.type = dic["type"] as! String
        model.sent_at = dic["sent_at"] as! String
        
        return model
    }
}
