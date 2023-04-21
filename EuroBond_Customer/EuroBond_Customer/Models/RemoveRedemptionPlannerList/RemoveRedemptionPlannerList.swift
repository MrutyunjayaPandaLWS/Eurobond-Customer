
import Foundation
struct RemoveRedemptionPlannerList : Codable {
	let objCatalogueList : String?
	let returnValue : Int?
	let returnMessage : String?
	let totalRecords : Int?

	enum CodingKeys: String, CodingKey {

		case objCatalogueList = "objCatalogueList"
		case returnValue = "returnValue"
		case returnMessage = "returnMessage"
		case totalRecords = "totalRecords"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		objCatalogueList = try values.decodeIfPresent(String.self, forKey: .objCatalogueList)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
	}

}
