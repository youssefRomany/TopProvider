//
//  temp.swift
//  Ayadena
//
//  Created by Sara Ashraf on 11/22/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import Foundation
//
//  temp.swift
//  DwratMatn
//
//  Created by Sara Ashraf on 11/7/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//


import UIKit
import Alamofire

class temp: NSObject {
    
    static var token:String  = ""
    static var code:String = ""
    
    static var method:String = ""
    
    //vc to go
    static var vcID:String = ""
    
    //Alamofire
    static var header: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
    
    //for market & bag
    static var market_name:String = ""
    static var market_desc:String = ""
    static var market_image:String = ""
    static var market_id:Int = 0
    
    static var cat_name:String = ""
    static var cat_id:String = ""
    
    static var product_id:Int = 0
    static var prod_name:String = ""
    static var product_price:String = ""
    static var product_img:String = ""
    
    static var invoice_id:String = ""
    
    //for bag2
    static var market_selectedID:Int = 0
    static var market_Totalprice:Double = 0
    
    
    //for search Results
    static var searchResults:Any = ""
    
    //img viwer
    static var imgLink:String = "0"
    
    //chat
    static var chatid:Int? = 0
    
    //content
    static var content_id:Int = 0
    static var content_name:String = ""
    static var content_desc:String = ""
    static var content_img:String = ""
    
    
}
