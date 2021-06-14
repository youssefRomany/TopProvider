//
//  ClientOrders.swift
//  Top12
//
//  Created by Sara Ashraf on 3/23/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import Foundation

class ClientOrders {
    var order_id = ""
    var order_provider_id = ""
    var order_provider_name = ""
    var order_provider_avatar = ""
    var order_delegate_id = ""
    var order_delegate_name = ""
    var order_delegate_price = ""
    var order_created_at = ""
    var order_status = ""
    var order_products_count = ""
    var order_refused_reason = ""
    var shop_id = ""
    
    func getObject(dicc: [String: Any]) -> ClientOrders {
        let dic = HandleJSON.getObject().handle(dicc: dicc)
        let model = ClientOrders()
        model.order_id = dic["order_id"] as! String
        model.order_provider_id = dic["order_provider_id"] as! String
        model.order_provider_name = dic["order_provider_name"] as! String
        model.order_provider_avatar = dic["order_provider_avatar"] as! String
        model.order_delegate_id = dic["order_delegate_id"] as! String
        model.order_delegate_name = dic["order_delegate_name"] as! String
        model.order_delegate_price = dic["order_delegate_price"] as! String
        model.order_created_at = dic["order_created_at"] as! String
        model.order_products_count = dic["order_products_count"] as! String
        model.order_status = dic["order_status"] as! String
        model.order_refused_reason = dic["order_refused_reason"] as! String
        model.shop_id = dic["shop_id"] as! String
        
        
        return model
    }
}
