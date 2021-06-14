//
//  NewOrdersModel.swift
//  Top12
//
//  Created by Sara Ashraf on 1/13/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import Foundation
class NewOrdersModel: NSObject {
    
    var order_id:  Int? = 0
    var order_user_id:  Int? = 0
    var order_delegate_id: Int? = 0
    var total_price: Int? = 0
    var delegate_price: Int? = 0
    var disc_price: Int? = 0
    var net_price: Int? = 0
    var order_user_name: String? = ""
    var order_user_avatar:  String? = ""
    var order_user_city:  String? = ""
    var order_delegate_name:  String? = ""
    var order_created_at: String? = ""
    var order_way_type:  Int? = 0
    var order_status:   String? = ""
    var order_refused_reason: String? = ""
    var order_foreign_delegate: Bool? = false
    var order_products = [OrderProductsModel]()
    
    
}
