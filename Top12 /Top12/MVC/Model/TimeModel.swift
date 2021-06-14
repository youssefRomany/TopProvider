//
//  TimeModel.swift
//  Top12
//
//  Created by Sara Ashraf on 3/27/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import Foundation
class  TimeModel {
    var id: String!
    var name: String!
    
    func getObject(dicc: [String: Any]) ->   TimeModel {
        let dic = HandleJSON.getObject().handle(dicc: dicc)
        let model =  TimeModel()
        
        model.id = dic["id"] as! String
        model.name = dic["name"] as! String
       
        
        return model
        
    }
}
