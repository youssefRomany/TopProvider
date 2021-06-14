/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Final : Codable {
        let order_id : Int?
        let order_created_at : String?
        let order_delivery_time : Int?
        let order_city : String?
        let order_payment : String?
        let order_products : [Order_products]?
        let order_status: String?
        let order_delegate: String?
        let order_user: User?
        let have_delegate: String?
        let order_address: String?
        let isEarly: Bool?
        enum CodingKeys: String, CodingKey {

            case order_id = "order_id"
            case isEarly = "isEarly"
            case order_status = "order_status"
            case order_created_at = "order_created_at"
            case order_delivery_time = "order_delivery_time"
            case order_city = "order_city"
            case order_payment = "order_payment"
            case order_products = "order_products"
            case order_delegate = "order_delegate"
            case order_user = "order_user"
            case have_delegate = "have_delegate"
            case order_address = "order_address"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            order_id = try values.decodeIfPresent(Int.self, forKey: .order_id)
            order_created_at = try values.decodeIfPresent(String.self, forKey: .order_created_at)
            order_status = try values.decodeIfPresent(String.self, forKey: .order_status)
            order_delivery_time = try values.decodeIfPresent(Int.self, forKey: .order_delivery_time)
            order_city = try values.decodeIfPresent(String.self, forKey: .order_city)
            order_payment = try values.decodeIfPresent(String.self, forKey: .order_payment)
            order_delegate = try values.decodeIfPresent(String.self, forKey: .order_delegate)
            order_products = try values.decodeIfPresent([Order_products].self, forKey: .order_products)
            order_user = try values.decodeIfPresent(User.self, forKey: .order_user)
            have_delegate = try values.decodeIfPresent(String.self, forKey: .have_delegate)
            order_address = try values.decodeIfPresent(String.self, forKey: .order_address)
            isEarly = try values.decodeIfPresent(Bool.self, forKey: .isEarly)
        }

    }
