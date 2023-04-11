

import Foundation
struct StateList : Codable {
	let stateId : Int?
	let stateName : String?
	let stateCode : String?
	let countryId : Int?
	let countryName : String?
	let countryCode : String?
	let isActive : Bool?
	let countryType : String?
	let mobilePrefix : String?
	let row : Int?

	enum CodingKeys: String, CodingKey {

		case stateId = "stateId"
		case stateName = "stateName"
		case stateCode = "stateCode"
		case countryId = "countryId"
		case countryName = "countryName"
		case countryCode = "countryCode"
		case isActive = "isActive"
		case countryType = "countryType"
		case mobilePrefix = "mobilePrefix"
		case row = "row"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		stateId = try values.decodeIfPresent(Int.self, forKey: .stateId)
		stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
		stateCode = try values.decodeIfPresent(String.self, forKey: .stateCode)
		countryId = try values.decodeIfPresent(Int.self, forKey: .countryId)
		countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
		countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		countryType = try values.decodeIfPresent(String.self, forKey: .countryType)
		mobilePrefix = try values.decodeIfPresent(String.self, forKey: .mobilePrefix)
		row = try values.decodeIfPresent(Int.self, forKey: .row)
	}

}
