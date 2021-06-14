//
//  AddAditionsModel.swift
//  Top12
//
//  Created by Sara Ashraf on 3/26/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import Foundation

class AddAditionsModel {

    var price = "0"
    var addition_name = ""
    
    
    func getObject(dicc: [String: Any]) -> AddAditionsModel {
        let dic = HandleJSON.getObject().handle(dicc: dicc)
        let model = AddAditionsModel()
        model.addition_name = dic["addition_name"] as! String
    
        return model
    }
}
