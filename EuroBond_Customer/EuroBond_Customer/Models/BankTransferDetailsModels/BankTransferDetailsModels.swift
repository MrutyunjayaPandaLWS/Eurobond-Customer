

import Foundation
struct BankTransferDetailsModels : Codable {
	let lstCustBankDetailsApproval : [LstCustBankDetailsApproval]?
	let returnValue : Int?
	let returnMessage : String?
	let totalRecords : Int?

	enum CodingKeys: String, CodingKey {

		case lstCustBankDetailsApproval = "lstCustBankDetailsApproval"
		case returnValue = "returnValue"
		case returnMessage = "returnMessage"
		case totalRecords = "totalRecords"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		lstCustBankDetailsApproval = try values.decodeIfPresent([LstCustBankDetailsApproval].self, forKey: .lstCustBankDetailsApproval)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
	}

}
