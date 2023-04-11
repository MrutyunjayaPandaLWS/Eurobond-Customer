

import Foundation
struct QRCodeSaveResponseList : Codable {
	let actionType : Int?
	let actorId : Int?
	let actorRole : String?
	let isActive : Bool?
	let token : String?
	let address : String?
	let city : String?
	let codeStatus : Int?
	let country : String?
	let customerName : String?
	let isNotional : Int?
	let isScanedSource : Int?
	let latitude : String?
	let longitude : String?
	let loyaltyID : String?
	let mobile : String?
	let pinCode : String?
	let pointAwarded : String?
	let qRCode : String?
	let remarks : String?
	let sourceType : Int?
	let state : String?
	let status : String?

	enum CodingKeys: String, CodingKey {

		case actionType = "ActionType"
		case actorId = "ActorId"
		case actorRole = "ActorRole"
		case isActive = "IsActive"
		case token = "Token"
		case address = "Address"
		case city = "City"
		case codeStatus = "CodeStatus"
		case country = "Country"
		case customerName = "CustomerName"
		case isNotional = "IsNotional"
		case isScanedSource = "IsScanedSource"
		case latitude = "Latitude"
		case longitude = "Longitude"
		case loyaltyID = "LoyaltyID"
		case mobile = "Mobile"
		case pinCode = "PinCode"
		case pointAwarded = "PointAwarded"
		case qRCode = "QRCode"
		case remarks = "Remarks"
		case sourceType = "SourceType"
		case state = "State"
		case status = "Status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
		actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
		actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		codeStatus = try values.decodeIfPresent(Int.self, forKey: .codeStatus)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		customerName = try values.decodeIfPresent(String.self, forKey: .customerName)
		isNotional = try values.decodeIfPresent(Int.self, forKey: .isNotional)
		isScanedSource = try values.decodeIfPresent(Int.self, forKey: .isScanedSource)
		latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
		loyaltyID = try values.decodeIfPresent(String.self, forKey: .loyaltyID)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		pinCode = try values.decodeIfPresent(String.self, forKey: .pinCode)
		pointAwarded = try values.decodeIfPresent(String.self, forKey: .pointAwarded)
		qRCode = try values.decodeIfPresent(String.self, forKey: .qRCode)
		remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
		sourceType = try values.decodeIfPresent(Int.self, forKey: .sourceType)
		state = try values.decodeIfPresent(String.self, forKey: .state)
		status = try values.decodeIfPresent(String.self, forKey: .status)
	}

}
