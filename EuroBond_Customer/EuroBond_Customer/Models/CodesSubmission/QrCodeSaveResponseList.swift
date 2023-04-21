/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct QrCodeSaveResponseList : Codable {
	let loyaltyID : String?
	let qrCode : String?
	let sourceType : Int?
	let longitude : String?
	let latitude : String?
	let address : String?
	let city : String?
	let state : String?
	let country : String?
	let pinCode : String?
	let isScanedSource : Int?
	let codeStatus : Int?
	let isNotional : Int?
	let status : String?
	let remarks : String?
	let customerName : String?
	let pointAwarded : String?
	let mobile : String?
	let locationID : Int?
	let product : String?
	let batchNo : String?
	let token : String?
	let actorId : Int?
	let isActive : Bool?
	let actorRole : String?
	let actionType : Int?

	enum CodingKeys: String, CodingKey {

		case loyaltyID = "loyaltyID"
		case qrCode = "qrCode"
		case sourceType = "sourceType"
		case longitude = "longitude"
		case latitude = "latitude"
		case address = "address"
		case city = "city"
		case state = "state"
		case country = "country"
		case pinCode = "pinCode"
		case isScanedSource = "isScanedSource"
		case codeStatus = "codeStatus"
		case isNotional = "isNotional"
		case status = "status"
		case remarks = "remarks"
		case customerName = "customerName"
		case pointAwarded = "pointAwarded"
		case mobile = "mobile"
		case locationID = "locationID"
		case product = "product"
		case batchNo = "batchNo"
		case token = "token"
		case actorId = "actorId"
		case isActive = "isActive"
		case actorRole = "actorRole"
		case actionType = "actionType"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		loyaltyID = try values.decodeIfPresent(String.self, forKey: .loyaltyID)
		qrCode = try values.decodeIfPresent(String.self, forKey: .qrCode)
		sourceType = try values.decodeIfPresent(Int.self, forKey: .sourceType)
		longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
		latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		state = try values.decodeIfPresent(String.self, forKey: .state)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		pinCode = try values.decodeIfPresent(String.self, forKey: .pinCode)
		isScanedSource = try values.decodeIfPresent(Int.self, forKey: .isScanedSource)
		codeStatus = try values.decodeIfPresent(Int.self, forKey: .codeStatus)
		isNotional = try values.decodeIfPresent(Int.self, forKey: .isNotional)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
		customerName = try values.decodeIfPresent(String.self, forKey: .customerName)
		pointAwarded = try values.decodeIfPresent(String.self, forKey: .pointAwarded)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		locationID = try values.decodeIfPresent(Int.self, forKey: .locationID)
		product = try values.decodeIfPresent(String.self, forKey: .product)
		batchNo = try values.decodeIfPresent(String.self, forKey: .batchNo)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
		actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
	}

}