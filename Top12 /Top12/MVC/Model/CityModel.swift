//
//  CityModel.swift
//  Top12
//
//  Created by Sara Ashraf on 3/15/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//
import Foundation
class  CityModel {
    var id: String!
    var name: String!
    func getObject(dicc: [String: Any]) ->   CityModel {
        let dic = HandleJSON.getObject().handle(dicc: dicc)
        let model =  CityModel()
        
        model.id = dic["id"] as! String
        model.name = dic["name"] as! String
        return model
        
    }
}
