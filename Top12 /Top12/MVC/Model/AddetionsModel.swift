//
//  AddetionsModel.swift
//  Top12
//
//  Created by Sara Ashraf on 1/15/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import Foundation
struct AddetionsModel {
   
    var name_en:String
    var price:String
    var name_ar:String
    
    func toDic()->[String:Any]{
        let dic = [
            
            "name_en":name_en,
            "price":price,
            "name_ar":name_ar,
        ]
        return dic
    }
}
