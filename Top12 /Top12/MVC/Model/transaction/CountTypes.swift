/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct CountTypes : Codable {
	let status : Int?
	let waitingApprovalOrdersCount : Int?
	let missingOrdersCount : Int?
	let underPrepareOrdersCount : Int?
	let underDeliveryOrdersCount : Int?
    let underDeliveredOrdersCount : Int?
    let inKitchenOrdersCount : Int?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case waitingApprovalOrdersCount = "WaitingApprovalOrdersCount"
		case missingOrdersCount = "MissingOrdersCount"
		case underPrepareOrdersCount = "UnderPrepareOrdersCount"
		case underDeliveryOrdersCount = "UnderDeliveryOrdersCount"
        case underDeliveredOrdersCount = "UnderDeliveredOrdersCount"
        case inKitchenOrdersCount = "inKitchenOrdersCount"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		waitingApprovalOrdersCount = try values.decodeIfPresent(Int.self, forKey: .waitingApprovalOrdersCount)
		missingOrdersCount = try values.decodeIfPresent(Int.self, forKey: .missingOrdersCount)
		underPrepareOrdersCount = try values.decodeIfPresent(Int.self, forKey: .underPrepareOrdersCount)
		underDeliveryOrdersCount = try values.decodeIfPresent(Int.self, forKey: .underDeliveryOrdersCount)
        underDeliveredOrdersCount = try values.decodeIfPresent(Int.self, forKey: .underDeliveredOrdersCount)
        inKitchenOrdersCount = try values.decodeIfPresent(Int.self, forKey: .inKitchenOrdersCount)
	}

}
