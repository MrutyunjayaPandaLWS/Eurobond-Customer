
import Foundation
struct LstDreamGift1 : Codable {
	let actionType : Int?
	let actorId : Int?
	let actorRole : String?
	let isActive : Bool?
	let address : String?
	let avgEarningPoints : Int?
	let contractorName : String?
	let dreamGiftDescription : String?
	let dreamGiftId : Int?
	let dreamGiftName : String?
	let earlyExpectedDate : String?
	let earlyExpectedPoints : Int?
	let expectedDate : String?
	let giftImage : String?
	let giftStatusId : Int?
	let giftType : String?
	let jCreatedDate : String?
	let jDesiredDate : String?
	let lateExpectedDate : String?
	let lateExpectedPoints : Int?
	let loyaltyID : String?
	let mobile : String?
	let pointsBalance : Int?
	let pointsRequired : Int?
	let remark : String?
	let role : String?
	let status : String?
	let totRow : Int?

	enum CodingKeys: String, CodingKey {

		case actionType = "ActionType"
		case actorId = "ActorId"
		case actorRole = "ActorRole"
		case isActive = "IsActive"
		case address = "Address"
		case avgEarningPoints = "AvgEarningPoints"
		case contractorName = "ContractorName"
		case dreamGiftDescription = "DreamGiftDescription"
		case dreamGiftId = "DreamGiftId"
		case dreamGiftName = "DreamGiftName"
		case earlyExpectedDate = "EarlyExpectedDate"
		case earlyExpectedPoints = "EarlyExpectedPoints"
		case expectedDate = "ExpectedDate"
		case giftImage = "GiftImage"
		case giftStatusId = "GiftStatusId"
		case giftType = "GiftType"
		case jCreatedDate = "JCreatedDate"
		case jDesiredDate = "JDesiredDate"
		case lateExpectedDate = "LateExpectedDate"
		case lateExpectedPoints = "LateExpectedPoints"
		case loyaltyID = "LoyaltyID"
		case mobile = "Mobile"
		case pointsBalance = "PointsBalance"
		case pointsRequired = "PointsRequired"
		case remark = "Remark"
		case role = "Role"
		case status = "Status"
		case totRow = "TotRow"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
		actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
		actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		avgEarningPoints = try values.decodeIfPresent(Int.self, forKey: .avgEarningPoints)
		contractorName = try values.decodeIfPresent(String.self, forKey: .contractorName)
		dreamGiftDescription = try values.decodeIfPresent(String.self, forKey: .dreamGiftDescription)
		dreamGiftId = try values.decodeIfPresent(Int.self, forKey: .dreamGiftId)
		dreamGiftName = try values.decodeIfPresent(String.self, forKey: .dreamGiftName)
		earlyExpectedDate = try values.decodeIfPresent(String.self, forKey: .earlyExpectedDate)
		earlyExpectedPoints = try values.decodeIfPresent(Int.self, forKey: .earlyExpectedPoints)
		expectedDate = try values.decodeIfPresent(String.self, forKey: .expectedDate)
		giftImage = try values.decodeIfPresent(String.self, forKey: .giftImage)
		giftStatusId = try values.decodeIfPresent(Int.self, forKey: .giftStatusId)
		giftType = try values.decodeIfPresent(String.self, forKey: .giftType)
		jCreatedDate = try values.decodeIfPresent(String.self, forKey: .jCreatedDate)
		jDesiredDate = try values.decodeIfPresent(String.self, forKey: .jDesiredDate)
		lateExpectedDate = try values.decodeIfPresent(String.self, forKey: .lateExpectedDate)
		lateExpectedPoints = try values.decodeIfPresent(Int.self, forKey: .lateExpectedPoints)
		loyaltyID = try values.decodeIfPresent(String.self, forKey: .loyaltyID)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		pointsBalance = try values.decodeIfPresent(Int.self, forKey: .pointsBalance)
		pointsRequired = try values.decodeIfPresent(Int.self, forKey: .pointsRequired)
		remark = try values.decodeIfPresent(String.self, forKey: .remark)
		role = try values.decodeIfPresent(String.self, forKey: .role)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		totRow = try values.decodeIfPresent(Int.self, forKey: .totRow)
	}

}
