//
//  ClientModel.swift
//  Top12
//
//  Created by Sara Ashraf on 3/23/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//
//
//  ClientModel.swift
//  Top_Client
//
//  Created by Engy Bakr on 1/10/19.
//  Copyright © 2019 Engy Bakr. All rights reserved.
//

import Foundation
class ClientModel {
    var type = ""
    var user_id = ""
    var name = ""
    var email = ""
    var phone = ""
    var city_id = ""
    var city_name = ""
    var nationality_id = ""
    var nationality_name = ""
    var code = ""
    var civil_number = ""
    var avatar = ""
    var lat = ""
    var lng = ""
    //var shop = ""
    
    
    
    func getObject(dicc: [String: Any]) -> ClientModel {
        let dic = HandleJSON.getObject().handle(dicc: dicc)
        let model = ClientModel()
        model.type = dic["type"] as! String
        model.user_id = dic["user_id"] as! String
        model.name = dic["name"] as! String
        model.email = dic["email"] as! String
        model.phone = dic["phone"] as! String
        model.city_id = dic["city_id"] as! String
        model.city_name = dic["city_name"] as! String
        model.nationality_id = dic["nationality_id"] as! String
        model.nationality_name = dic["nationality_name"] as! String
        model.code = dic["code"] as! String
        model.civil_number = dic["civil_number"] as! String
        model.avatar = dic["avatar"] as! String
        model.lat = dic["lat"] as! String
        model.lng = dic["lng"] as! String
        // model.shop = dic["shop"] as! String
        return model
    }
}
