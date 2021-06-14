//
//  Product_Additions.swift
//  Top12
//
//  Created by YoussefRomany on 4/27/20.
//  Copyright © 2020 Sara Ashraf. All rights reserved.
//

import Foundation

class Product_Additions : Codable{
    
    var addition_id : Int?
    var addition_name : String?
    var addition_count : Int?
    var addition_price : Int?
    
    
    enum CodingKeys: String, CodingKey {

        case addition_id = "addition_id"
        case addition_name = "addition_name"
        case addition_count = "addition_count"
        case addition_price = "addition_price"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        addition_id = try values.decodeIfPresent(Int.self, forKey: .addition_id)
        addition_name = try values.decodeIfPresent(String.self, forKey: .addition_name)
        addition_count = try values.decodeIfPresent(Int.self, forKey: .addition_count)
        addition_price = try values.decodeIfPresent(Int.self, forKey: .addition_price)
    }

}
