/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct DataModelss : Codable {
	let order_id : Int?
	let order_user_id : Int?
	let order_user_name : String?
	let order_user_avatar : String?
	let order_user_phone : String?
	let order_user_city : String?
	let order_user_lat : String?
	let order_user_lng : String?
	let order_provider_id : Int?
	let shop_id : Int?
	let order_provider_name : String?
	let order_provider_avatar : String?
	let order_provider_phone : String?
	let order_provider_city : String?
	let order_provider_lat : String?
	let order_provider_lng : String?
	let order_delegate_id : Int?
	let order_delegate_name : String?
	let order_delegate_phone : String?
	let order_delegate_city : String?
	let order_delegate_lat : String?
	let order_delegate_lng : String?
	let order_created_at : String?
	let order_status : String?
	let order_delivery_price : String?
	let order_delegate_price : String?
	let order_have_delegate : String?
	let order_refused_reason : String?
	let order_products : [joeOrder_products]?
	let total_price : Int?
	let provider_commission : Int?
	let delegate_price : Int?
	let disc_price : Int?
	let net_price : Int?
    let orderDeliveryTime: OrderDeliveryTime?

	enum CodingKeys: String, CodingKey {

        case order_id = "order_id"
        case orderDeliveryTime = "orderDeliveryTime"
		case order_user_id = "order_user_id"
		case order_user_name = "order_user_name"
		case order_user_avatar = "order_user_avatar"
		case order_user_phone = "order_user_phone"
		case order_user_city = "order_user_city"
		case order_user_lat = "order_user_lat"
		case order_user_lng = "order_user_lng"
		case order_provider_id = "order_provider_id"
		case shop_id = "shop_id"
		case order_provider_name = "order_provider_name"
		case order_provider_avatar = "order_provider_avatar"
		case order_provider_phone = "order_provider_phone"
		case order_provider_city = "order_provider_city"
		case order_provider_lat = "order_provider_lat"
		case order_provider_lng = "order_provider_lng"
		case order_delegate_id = "order_delegate_id"
		case order_delegate_name = "order_delegate_name"
		case order_delegate_phone = "order_delegate_phone"
		case order_delegate_city = "order_delegate_city"
		case order_delegate_lat = "order_delegate_lat"
		case order_delegate_lng = "order_delegate_lng"
		case order_created_at = "order_created_at"
		case order_status = "order_status"
		case order_delivery_price = "order_delivery_price"
		case order_delegate_price = "order_delegate_price"
		case order_have_delegate = "order_have_delegate"
		case order_refused_reason = "order_refused_reason"
		case order_products = "order_products"
		case total_price = "total_price"
		case provider_commission = "provider_commission"
		case delegate_price = "delegate_price"
		case disc_price = "disc_price"
		case net_price = "net_price"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		order_id = try values.decodeIfPresent(Int.self, forKey: .order_id)
		order_user_id = try values.decodeIfPresent(Int.self, forKey: .order_user_id)
		order_user_name = try values.decodeIfPresent(String.self, forKey: .order_user_name)
		order_user_avatar = try values.decodeIfPresent(String.self, forKey: .order_user_avatar)
		order_user_phone = try values.decodeIfPresent(String.self, forKey: .order_user_phone)
		order_user_city = try values.decodeIfPresent(String.self, forKey: .order_user_city)
		order_user_lat = try values.decodeIfPresent(String.self, forKey: .order_user_lat)
		order_user_lng = try values.decodeIfPresent(String.self, forKey: .order_user_lng)
		order_provider_id = try values.decodeIfPresent(Int.self, forKey: .order_provider_id)
		shop_id = try values.decodeIfPresent(Int.self, forKey: .shop_id)
		order_provider_name = try values.decodeIfPresent(String.self, forKey: .order_provider_name)
		order_provider_avatar = try values.decodeIfPresent(String.self, forKey: .order_provider_avatar)
		order_provider_phone = try values.decodeIfPresent(String.self, forKey: .order_provider_phone)
		order_provider_city = try values.decodeIfPresent(String.self, forKey: .order_provider_city)
		order_provider_lat = try values.decodeIfPresent(String.self, forKey: .order_provider_lat)
		order_provider_lng = try values.decodeIfPresent(String.self, forKey: .order_provider_lng)
		order_delegate_id = try values.decodeIfPresent(Int.self, forKey: .order_delegate_id)
		order_delegate_name = try values.decodeIfPresent(String.self, forKey: .order_delegate_name)
		order_delegate_phone = try values.decodeIfPresent(String.self, forKey: .order_delegate_phone)
		order_delegate_city = try values.decodeIfPresent(String.self, forKey: .order_delegate_city)
		order_delegate_lat = try values.decodeIfPresent(String.self, forKey: .order_delegate_lat)
		order_delegate_lng = try values.decodeIfPresent(String.self, forKey: .order_delegate_lng)
		order_created_at = try values.decodeIfPresent(String.self, forKey: .order_created_at)
		order_status = try values.decodeIfPresent(String.self, forKey: .order_status)
		order_delivery_price = try values.decodeIfPresent(String.self, forKey: .order_delivery_price)
		order_delegate_price = try values.decodeIfPresent(String.self, forKey: .order_delegate_price)
		order_have_delegate = try values.decodeIfPresent(String.self, forKey: .order_have_delegate)
		order_refused_reason = try values.decodeIfPresent(String.self, forKey: .order_refused_reason)
		order_products = try values.decodeIfPresent([joeOrder_products].self, forKey: .order_products)
		total_price = try values.decodeIfPresent(Int.self, forKey: .total_price)
		provider_commission = try values.decodeIfPresent(Int.self, forKey: .provider_commission)
		delegate_price = try values.decodeIfPresent(Int.self, forKey: .delegate_price)
		disc_price = try values.decodeIfPresent(Int.self, forKey: .disc_price)
        net_price = try values.decodeIfPresent(Int.self, forKey: .net_price)
        orderDeliveryTime = try values.decodeIfPresent(OrderDeliveryTime.self, forKey: .orderDeliveryTime)
        
	}

}


class OrderDeliveryTime : Codable{
    var isEarly: Bool?
    var deliveryTime: String?
    var deliveryTimeFormat: String?
}
