/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Bills : Codable {
	let id : Int?
	let cash : String?
	let epay : String?
	let pids : String?
	let app_fee : String?
	let value : String?
	let start : String?
	let end : String?
	let provider_id : Int?
	let code : String?
	let created_at : String?
	let updated_at : String?
    let up_to_date : String?
    let orderComplaint : String?

    
    
	enum CodingKeys: String, CodingKey {
		case id = "id"
        case cash = "cash"
        case up_to_date = "up_to_date"
		case epay = "epay"
		case pids = "pids"
		case app_fee = "app_fee"
		case value = "value"
		case start = "start"
		case end = "end"
		case provider_id = "provider_id"
		case code = "code"
		case created_at = "created_at"
        case updated_at = "updated_at"
        case orderComplaint = "orderComplaint"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
        cash = try values.decodeIfPresent(String.self, forKey: .cash)
        up_to_date = try values.decodeIfPresent(String.self, forKey: .up_to_date)
		epay = try values.decodeIfPresent(String.self, forKey: .epay)
		pids = try values.decodeIfPresent(String.self, forKey: .pids)
		app_fee = try values.decodeIfPresent(String.self, forKey: .app_fee)
		value = try values.decodeIfPresent(String.self, forKey: .value)
		start = try values.decodeIfPresent(String.self, forKey: .start)
		end = try values.decodeIfPresent(String.self, forKey: .end)
		provider_id = try values.decodeIfPresent(Int.self, forKey: .provider_id)
		code = try values.decodeIfPresent(String.self, forKey: .code)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        orderComplaint = try values.decodeIfPresent(String.self, forKey: .orderComplaint)
	}

}
