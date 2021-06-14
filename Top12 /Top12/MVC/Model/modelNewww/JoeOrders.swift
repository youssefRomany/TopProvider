/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct JoeOrders : Codable {
	let id : Int?
	let user_id : Int?
	let provider_id : Int?
	let have_delegate : String?
	let delegate_id : String?
	let delegate_phone : String?
	let cart_id : Int?
	let price : String?
	let payment_type : String?
	let delivery_price : String?
	let status : String?
	let transfered : Int?
	let delegate_price : String?
	let refused_reason : String?
	let ordered_at : String?
	let created_at : String?
	let updated_at : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case user_id = "user_id"
		case provider_id = "provider_id"
		case have_delegate = "have_delegate"
		case delegate_id = "delegate_id"
		case delegate_phone = "delegate_phone"
		case cart_id = "cart_id"
		case price = "price"
		case payment_type = "payment_type"
		case delivery_price = "delivery_price"
		case status = "status"
		case transfered = "transfered"
		case delegate_price = "delegate_price"
		case refused_reason = "refused_reason"
		case ordered_at = "ordered_at"
		case created_at = "created_at"
		case updated_at = "updated_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
		provider_id = try values.decodeIfPresent(Int.self, forKey: .provider_id)
		have_delegate = try values.decodeIfPresent(String.self, forKey: .have_delegate)
		delegate_id = try values.decodeIfPresent(String.self, forKey: .delegate_id)
		delegate_phone = try values.decodeIfPresent(String.self, forKey: .delegate_phone)
		cart_id = try values.decodeIfPresent(Int.self, forKey: .cart_id)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		payment_type = try values.decodeIfPresent(String.self, forKey: .payment_type)
		delivery_price = try values.decodeIfPresent(String.self, forKey: .delivery_price)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		transfered = try values.decodeIfPresent(Int.self, forKey: .transfered)
		delegate_price = try values.decodeIfPresent(String.self, forKey: .delegate_price)
		refused_reason = try values.decodeIfPresent(String.self, forKey: .refused_reason)
		ordered_at = try values.decodeIfPresent(String.self, forKey: .ordered_at)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
	}

}
