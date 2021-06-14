/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Order_products : Codable {
	let id : Int?
	let shop_id : Int?
	let name_ar : String?
	let name_en : String?
	let price : String?
	let enough_to : String?
	let time : String?
	let order_type : String?
	let offer_price : String?
	let disc : String?
	let extra_info : String?
	let is_active : Int?
	let created_at : String?
	let updated_at : String?
	let category_id : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case shop_id = "shop_id"
		case name_ar = "name_ar"
		case name_en = "name_en"
		case price = "price"
		case enough_to = "enough_to"
		case time = "time"
		case order_type = "order_type"
		case offer_price = "offer_price"
		case disc = "disc"
		case extra_info = "extra_info"
		case is_active = "is_active"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case category_id = "category_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		shop_id = try values.decodeIfPresent(Int.self, forKey: .shop_id)
		name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
		name_en = try values.decodeIfPresent(String.self, forKey: .name_en)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		enough_to = try values.decodeIfPresent(String.self, forKey: .enough_to)
		time = try values.decodeIfPresent(String.self, forKey: .time)
		order_type = try values.decodeIfPresent(String.self, forKey: .order_type)
		offer_price = try values.decodeIfPresent(String.self, forKey: .offer_price)
		disc = try values.decodeIfPresent(String.self, forKey: .disc)
		extra_info = try values.decodeIfPresent(String.self, forKey: .extra_info)
		is_active = try values.decodeIfPresent(Int.self, forKey: .is_active)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		category_id = try values.decodeIfPresent(Int.self, forKey: .category_id)
	}

}