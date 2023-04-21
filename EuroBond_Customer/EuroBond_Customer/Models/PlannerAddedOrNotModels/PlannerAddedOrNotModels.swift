
import Foundation
struct PlannerAddedOrNotModels : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let objCatalogueList : [ObjCatalogueList3]?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case objCatalogueList = "ObjCatalogueList3"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		objCatalogueList = try values.decodeIfPresent([ObjCatalogueList3].self, forKey: .objCatalogueList)
	}

}
