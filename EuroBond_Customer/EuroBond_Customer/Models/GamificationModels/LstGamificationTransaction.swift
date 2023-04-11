/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstGamificationTransaction : Codable {
	let awardRewardId : Int?
	let customerGamifyTransactionId : Int?
	let fromRange : Int?
	let gameId : Int?
	let gameImage : String?
	let gameName : String?
	let gamePlayedDate : String?
	let gamifyCampaignId : Int?
	let gamifyRuleId : Int?
	let isPlayed : Bool?
	let isView : Bool?
	let loyaltyId : String?
	let pointResult : Int?
	let rangeValues : String?
	let referenceId : String?
	let referenceType : String?
	let toRange : Int?

	enum CodingKeys: String, CodingKey {

		case awardRewardId = "AwardRewardId"
		case customerGamifyTransactionId = "CustomerGamifyTransactionId"
		case fromRange = "FromRange"
		case gameId = "GameId"
		case gameImage = "GameImage"
		case gameName = "GameName"
		case gamePlayedDate = "GamePlayedDate"
		case gamifyCampaignId = "GamifyCampaignId"
		case gamifyRuleId = "GamifyRuleId"
		case isPlayed = "IsPlayed"
		case isView = "IsView"
		case loyaltyId = "LoyaltyId"
		case pointResult = "PointResult"
		case rangeValues = "RangeValues"
		case referenceId = "ReferenceId"
		case referenceType = "ReferenceType"
		case toRange = "ToRange"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		awardRewardId = try values.decodeIfPresent(Int.self, forKey: .awardRewardId)
		customerGamifyTransactionId = try values.decodeIfPresent(Int.self, forKey: .customerGamifyTransactionId)
		fromRange = try values.decodeIfPresent(Int.self, forKey: .fromRange)
		gameId = try values.decodeIfPresent(Int.self, forKey: .gameId)
		gameImage = try values.decodeIfPresent(String.self, forKey: .gameImage)
		gameName = try values.decodeIfPresent(String.self, forKey: .gameName)
		gamePlayedDate = try values.decodeIfPresent(String.self, forKey: .gamePlayedDate)
		gamifyCampaignId = try values.decodeIfPresent(Int.self, forKey: .gamifyCampaignId)
		gamifyRuleId = try values.decodeIfPresent(Int.self, forKey: .gamifyRuleId)
		isPlayed = try values.decodeIfPresent(Bool.self, forKey: .isPlayed)
		isView = try values.decodeIfPresent(Bool.self, forKey: .isView)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
		pointResult = try values.decodeIfPresent(Int.self, forKey: .pointResult)
		rangeValues = try values.decodeIfPresent(String.self, forKey: .rangeValues)
		referenceId = try values.decodeIfPresent(String.self, forKey: .referenceId)
		referenceType = try values.decodeIfPresent(String.self, forKey: .referenceType)
		toRange = try values.decodeIfPresent(Int.self, forKey: .toRange)
	}

}