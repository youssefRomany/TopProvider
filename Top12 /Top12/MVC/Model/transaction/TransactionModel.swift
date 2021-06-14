/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct TransactionModel : Codable {
	let id : String?
	let object : String?
	let live_mode : Bool?
	let api_version : String?
	let method : String?
	let status : String?
	let amount : Double?
	let currency : String?
	let threeDSecure : Bool?
	let card_threeDSecure : Bool?
	let save_card : Bool?
	let statement_descriptor : String?
	let description : String?
	let metadata : Metadata?
	let transaction : Transaction?
	let reference : Reference?
	let response : Response?
	let receipt : Receipt?
	let customer : Customer?
	let source : Source?
	let redirect : Redirect?
	let post : Post?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case object = "object"
		case live_mode = "live_mode"
		case api_version = "api_version"
		case method = "method"
		case status = "status"
		case amount = "amount"
		case currency = "currency"
		case threeDSecure = "threeDSecure"
		case card_threeDSecure = "card_threeDSecure"
		case save_card = "save_card"
		case statement_descriptor = "statement_descriptor"
		case description = "description"
		case metadata = "metadata"
		case transaction = "transaction"
		case reference = "reference"
		case response = "response"
		case receipt = "receipt"
		case customer = "customer"
		case source = "source"
		case redirect = "redirect"
		case post = "post"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		object = try values.decodeIfPresent(String.self, forKey: .object)
		live_mode = try values.decodeIfPresent(Bool.self, forKey: .live_mode)
		api_version = try values.decodeIfPresent(String.self, forKey: .api_version)
		method = try values.decodeIfPresent(String.self, forKey: .method)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		amount = try values.decodeIfPresent(Double.self, forKey: .amount)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		threeDSecure = try values.decodeIfPresent(Bool.self, forKey: .threeDSecure)
		card_threeDSecure = try values.decodeIfPresent(Bool.self, forKey: .card_threeDSecure)
		save_card = try values.decodeIfPresent(Bool.self, forKey: .save_card)
		statement_descriptor = try values.decodeIfPresent(String.self, forKey: .statement_descriptor)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		metadata = try values.decodeIfPresent(Metadata.self, forKey: .metadata)
		transaction = try values.decodeIfPresent(Transaction.self, forKey: .transaction)
		reference = try values.decodeIfPresent(Reference.self, forKey: .reference)
		response = try values.decodeIfPresent(Response.self, forKey: .response)
		receipt = try values.decodeIfPresent(Receipt.self, forKey: .receipt)
		customer = try values.decodeIfPresent(Customer.self, forKey: .customer)
		source = try values.decodeIfPresent(Source.self, forKey: .source)
		redirect = try values.decodeIfPresent(Redirect.self, forKey: .redirect)
		post = try values.decodeIfPresent(Post.self, forKey: .post)
	}

}
