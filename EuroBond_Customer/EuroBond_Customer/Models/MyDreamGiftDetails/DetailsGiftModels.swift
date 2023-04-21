import Foundation
struct DetailsGiftModels : Codable {
	let lstDreamGift : [LstDreamGift1]?

	enum CodingKeys: String, CodingKey {

		case lstDreamGift = "lstDreamGift"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		lstDreamGift = try values.decodeIfPresent([LstDreamGift1].self, forKey: .lstDreamGift)
	}

}
