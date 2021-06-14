/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct User : Codable {
	let id : Int?
	let name : String?
	let email : String?
	let phone : String?
	let type : String?
	let city_id : Int?
	let nationality_id : String?
	let code : String?
	let civil_number : String?
	let checked : String?
	let avatar : String?
	let active : Int?
	let lat : String?
	let long : String?
	let address : String?
	let description : String?
	let ind : String?
	let lang : String?
	let created_at : String?
	let updated_at : String?
	let banned : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case email = "email"
		case phone = "phone"
		case type = "type"
		case city_id = "city_id"
		case nationality_id = "nationality_id"
		case code = "code"
		case civil_number = "civil_number"
		case checked = "checked"
		case avatar = "avatar"
		case active = "active"
		case lat = "lat"
		case long = "long"
		case address = "address"
		case description = "description"
		case ind = "ind"
		case lang = "lang"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case banned = "banned"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		city_id = try values.decodeIfPresent(Int.self, forKey: .city_id)
		nationality_id = try values.decodeIfPresent(String.self, forKey: .nationality_id)
		code = try values.decodeIfPresent(String.self, forKey: .code)
		civil_number = try values.decodeIfPresent(String.self, forKey: .civil_number)
		checked = try values.decodeIfPresent(String.self, forKey: .checked)
		avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
		active = try values.decodeIfPresent(Int.self, forKey: .active)
		lat = try values.decodeIfPresent(String.self, forKey: .lat)
		long = try values.decodeIfPresent(String.self, forKey: .long)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		ind = try values.decodeIfPresent(String.self, forKey: .ind)
		lang = try values.decodeIfPresent(String.self, forKey: .lang)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		banned = try values.decodeIfPresent(String.self, forKey: .banned)
	}

}