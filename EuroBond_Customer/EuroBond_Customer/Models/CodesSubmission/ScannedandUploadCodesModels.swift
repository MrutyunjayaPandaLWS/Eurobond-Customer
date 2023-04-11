

import Foundation
struct ScannedandUploadCodesModels : Codable {
	let qRCodeSaveResponseList : [QRCodeSaveResponseList]?

	enum CodingKeys: String, CodingKey {

		case qRCodeSaveResponseList = "QRCodeSaveResponseList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		qRCodeSaveResponseList = try values.decodeIfPresent([QRCodeSaveResponseList].self, forKey: .qRCodeSaveResponseList)
	}

}
