//
//  ProviderCategoryModel.swift
//  Top12
//
//  Created by Sara Ashraf on 1/19/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import Foundation
class  ProviderCategoryModel {
    var id: String!
    var name: String!
    var image :String!
    func getObject(dicc: [String: Any]) ->   ProviderCategoryModel {
        let dic = HandleJSON.getObject().handle(dicc: dicc)
        let model =  ProviderCategoryModel()
        
        model.id = dic["id"] as! String
        model.name = dic["name"] as! String
        model.image = dic["image"] as! String
        
        return model
        
    }
}
