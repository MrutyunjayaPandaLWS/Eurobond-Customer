/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct QrUsegereport : Codable {
	let scratchCode : String?
	let printDate : String?
	let printDateFormat : String?
	let mobile : String?
	let memberName : String?
	let customerType : String?
	let bankingBy : String?
	let bankingSource : String?
	let bankingDate : String?
	let bankingDateFormat : String?
	let isMember : String?
	let accessedDate : String?
	let totalRows : String?
	let remarks : String?
	let address : String?
	let state : String?
	let city : String?
	let loyaltyId : String?
	let sku : String?
	let mapURL : String?
	let latitude : String?
	let totalCode : String?
	let lastDate : String?
	let usedMembershipId : String?
	let usedBankingBy : String?
	let usedBankingSource : String?
	let usedBankingDate : String?
	let usedRemarks : String?
	let transactiondate : String?
	let warehouse : String?
	let distributor : String?
	let retailer : String?
	let pointsawarded : Int?
	let status : String?
	let latitudeCount : Int?
	let addressCount : Int?
	let longitude : String?
	let country : String?
	let pinCode : String?
	let membershipId : String?
	let userImage : String?
	let productName : String?
	let locationName : String?
	let thickness : String?
	let size : String?
	let brandId : Int?
	let productId : Int?
	let qrCodeStatusID : Int?
	let codeStatusWiseCount : Int?

	enum CodingKeys: String, CodingKey {

		case scratchCode = "scratchCode"
		case printDate = "printDate"
		case printDateFormat = "printDateFormat"
		case mobile = "mobile"
		case memberName = "memberName"
		case customerType = "customerType"
		case bankingBy = "bankingBy"
		case bankingSource = "bankingSource"
		case bankingDate = "bankingDate"
		case bankingDateFormat = "bankingDateFormat"
		case isMember = "isMember"
		case accessedDate = "accessedDate"
		case totalRows = "totalRows"
		case remarks = "remarks"
		case address = "address"
		case state = "state"
		case city = "city"
		case loyaltyId = "loyaltyId"
		case sku = "sku"
		case mapURL = "mapURL"
		case latitude = "latitude"
		case totalCode = "totalCode"
		case lastDate = "lastDate"
		case usedMembershipId = "usedMembershipId"
		case usedBankingBy = "usedBankingBy"
		case usedBankingSource = "usedBankingSource"
		case usedBankingDate = "usedBankingDate"
		case usedRemarks = "usedRemarks"
		case transactiondate = "transactiondate"
		case warehouse = "warehouse"
		case distributor = "distributor"
		case retailer = "retailer"
		case pointsawarded = "pointsawarded"
		case status = "status"
		case latitudeCount = "latitudeCount"
		case addressCount = "addressCount"
		case longitude = "longitude"
		case country = "country"
		case pinCode = "pinCode"
		case membershipId = "membershipId"
		case userImage = "userImage"
		case productName = "productName"
		case locationName = "locationName"
		case thickness = "thickness"
		case size = "size"
		case brandId = "brandId"
		case productId = "productId"
		case qrCodeStatusID = "qrCodeStatusID"
		case codeStatusWiseCount = "codeStatusWiseCount"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		scratchCode = try values.decodeIfPresent(String.self, forKey: .scratchCode)
		printDate = try values.decodeIfPresent(String.self, forKey: .printDate)
		printDateFormat = try values.decodeIfPresent(String.self, forKey: .printDateFormat)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		memberName = try values.decodeIfPresent(String.self, forKey: .memberName)
		customerType = try values.decodeIfPresent(String.self, forKey: .customerType)
		bankingBy = try values.decodeIfPresent(String.self, forKey: .bankingBy)
		bankingSource = try values.decodeIfPresent(String.self, forKey: .bankingSource)
		bankingDate = try values.decodeIfPresent(String.self, forKey: .bankingDate)
		bankingDateFormat = try values.decodeIfPresent(String.self, forKey: .bankingDateFormat)
		isMember = try values.decodeIfPresent(String.self, forKey: .isMember)
		accessedDate = try values.decodeIfPresent(String.self, forKey: .accessedDate)
		totalRows = try values.decodeIfPresent(String.self, forKey: .totalRows)
		remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		state = try values.decodeIfPresent(String.self, forKey: .state)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
		sku = try values.decodeIfPresent(String.self, forKey: .sku)
		mapURL = try values.decodeIfPresent(String.self, forKey: .mapURL)
		latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
		totalCode = try values.decodeIfPresent(String.self, forKey: .totalCode)
		lastDate = try values.decodeIfPresent(String.self, forKey: .lastDate)
		usedMembershipId = try values.decodeIfPresent(String.self, forKey: .usedMembershipId)
		usedBankingBy = try values.decodeIfPresent(String.self, forKey: .usedBankingBy)
		usedBankingSource = try values.decodeIfPresent(String.self, forKey: .usedBankingSource)
		usedBankingDate = try values.decodeIfPresent(String.self, forKey: .usedBankingDate)
		usedRemarks = try values.decodeIfPresent(String.self, forKey: .usedRemarks)
		transactiondate = try values.decodeIfPresent(String.self, forKey: .transactiondate)
		warehouse = try values.decodeIfPresent(String.self, forKey: .warehouse)
		distributor = try values.decodeIfPresent(String.self, forKey: .distributor)
		retailer = try values.decodeIfPresent(String.self, forKey: .retailer)
		pointsawarded = try values.decodeIfPresent(Int.self, forKey: .pointsawarded)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		latitudeCount = try values.decodeIfPresent(Int.self, forKey: .latitudeCount)
		addressCount = try values.decodeIfPresent(Int.self, forKey: .addressCount)
		longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		pinCode = try values.decodeIfPresent(String.self, forKey: .pinCode)
		membershipId = try values.decodeIfPresent(String.self, forKey: .membershipId)
		userImage = try values.decodeIfPresent(String.self, forKey: .userImage)
		productName = try values.decodeIfPresent(String.self, forKey: .productName)
		locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
		thickness = try values.decodeIfPresent(String.self, forKey: .thickness)
		size = try values.decodeIfPresent(String.self, forKey: .size)
		brandId = try values.decodeIfPresent(Int.self, forKey: .brandId)
		productId = try values.decodeIfPresent(Int.self, forKey: .productId)
		qrCodeStatusID = try values.decodeIfPresent(Int.self, forKey: .qrCodeStatusID)
		codeStatusWiseCount = try values.decodeIfPresent(Int.self, forKey: .codeStatusWiseCount)
	}

}