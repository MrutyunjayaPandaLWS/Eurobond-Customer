/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstGamificationTransaction : Codable {
	let customerGamifyTransactionId : Int?
	let gamifyCampaignId : Int?
	let loyaltyId : String?
	let gamifyRuleId : Int?
	let gameId : Int?
	let awardRewardId : Int?
	let referenceType : String?
	let referenceId : String?
	let isPlayed : Bool?
	let isView : Bool?
	let pointResult : Int?
	let fromRange : Int?
	let toRange : Int?
	let gameName : String?
	let rangeValues : String?
	let gameImage : String?
	let gamePlayedDate : String?

	enum CodingKeys: String, CodingKey {

		case customerGamifyTransactionId = "customerGamifyTransactionId"
		case gamifyCampaignId = "gamifyCampaignId"
		case loyaltyId = "loyaltyId"
		case gamifyRuleId = "gamifyRuleId"
		case gameId = "gameId"
		case awardRewardId = "awardRewardId"
		case referenceType = "referenceType"
		case referenceId = "referenceId"
		case isPlayed = "isPlayed"
		case isView = "isView"
		case pointResult = "pointResult"
		case fromRange = "fromRange"
		case toRange = "toRange"
		case gameName = "gameName"
		case rangeValues = "rangeValues"
		case gameImage = "gameImage"
		case gamePlayedDate = "gamePlayedDate"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		customerGamifyTransactionId = try values.decodeIfPresent(Int.self, forKey: .customerGamifyTransactionId)
		gamifyCampaignId = try values.decodeIfPresent(Int.self, forKey: .gamifyCampaignId)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
		gamifyRuleId = try values.decodeIfPresent(Int.self, forKey: .gamifyRuleId)
		gameId = try values.decodeIfPresent(Int.self, forKey: .gameId)
		awardRewardId = try values.decodeIfPresent(Int.self, forKey: .awardRewardId)
		referenceType = try values.decodeIfPresent(String.self, forKey: .referenceType)
		referenceId = try values.decodeIfPresent(String.self, forKey: .referenceId)
		isPlayed = try values.decodeIfPresent(Bool.self, forKey: .isPlayed)
		isView = try values.decodeIfPresent(Bool.self, forKey: .isView)
		pointResult = try values.decodeIfPresent(Int.self, forKey: .pointResult)
		fromRange = try values.decodeIfPresent(Int.self, forKey: .fromRange)
		toRange = try values.decodeIfPresent(Int.self, forKey: .toRange)
		gameName = try values.decodeIfPresent(String.self, forKey: .gameName)
		rangeValues = try values.decodeIfPresent(String.self, forKey: .rangeValues)
		gameImage = try values.decodeIfPresent(String.self, forKey: .gameImage)
		gamePlayedDate = try values.decodeIfPresent(String.self, forKey: .gamePlayedDate)
	}

}