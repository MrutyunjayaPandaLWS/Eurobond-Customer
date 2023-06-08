

import Foundation
struct LstCustBankDetailsApproval : Codable {
	let bankDetailsID : Int?
	let accountNumber : String?
	let acountHolderName : String?
	let bankName : String?
	let bankBranch : String?
	let ifscCode : String?
	let accountStatus : String?
	let accountStatusID : Int?
	let customerID : Int?
	let firstName : String?
	let lastName : String?
	let mobile : String?
	let cityName : String?
	let loyaltyID : String?
	let walletNumber : String?
	let walletStatus : String?
	let walletFullName : String?
	let walletAccountStatus : Int?
	let walletVerifiedStatus : Bool?
	let verificationStatus : Int?
	let nameStatus : String?
	let bankDetailImage : String?
	let remarks : String?

	enum CodingKeys: String, CodingKey {

		case bankDetailsID = "bankDetailsID"
		case accountNumber = "accountNumber"
		case acountHolderName = "acountHolderName"
		case bankName = "bankName"
		case bankBranch = "bankBranch"
		case ifscCode = "ifscCode"
		case accountStatus = "accountStatus"
		case accountStatusID = "accountStatusID"
		case customerID = "customerID"
		case firstName = "firstName"
		case lastName = "lastName"
		case mobile = "mobile"
		case cityName = "cityName"
		case loyaltyID = "loyaltyID"
		case walletNumber = "walletNumber"
		case walletStatus = "walletStatus"
		case walletFullName = "walletFullName"
		case walletAccountStatus = "walletAccountStatus"
		case walletVerifiedStatus = "walletVerifiedStatus"
		case verificationStatus = "verificationStatus"
		case nameStatus = "nameStatus"
		case bankDetailImage = "bankDetailImage"
		case remarks = "remarks"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		bankDetailsID = try values.decodeIfPresent(Int.self, forKey: .bankDetailsID)
		accountNumber = try values.decodeIfPresent(String.self, forKey: .accountNumber)
		acountHolderName = try values.decodeIfPresent(String.self, forKey: .acountHolderName)
		bankName = try values.decodeIfPresent(String.self, forKey: .bankName)
		bankBranch = try values.decodeIfPresent(String.self, forKey: .bankBranch)
		ifscCode = try values.decodeIfPresent(String.self, forKey: .ifscCode)
		accountStatus = try values.decodeIfPresent(String.self, forKey: .accountStatus)
		accountStatusID = try values.decodeIfPresent(Int.self, forKey: .accountStatusID)
		customerID = try values.decodeIfPresent(Int.self, forKey: .customerID)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
		loyaltyID = try values.decodeIfPresent(String.self, forKey: .loyaltyID)
		walletNumber = try values.decodeIfPresent(String.self, forKey: .walletNumber)
		walletStatus = try values.decodeIfPresent(String.self, forKey: .walletStatus)
		walletFullName = try values.decodeIfPresent(String.self, forKey: .walletFullName)
		walletAccountStatus = try values.decodeIfPresent(Int.self, forKey: .walletAccountStatus)
		walletVerifiedStatus = try values.decodeIfPresent(Bool.self, forKey: .walletVerifiedStatus)
		verificationStatus = try values.decodeIfPresent(Int.self, forKey: .verificationStatus)
		nameStatus = try values.decodeIfPresent(String.self, forKey: .nameStatus)
		bankDetailImage = try values.decodeIfPresent(String.self, forKey: .bankDetailImage)
		remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
	}

}
