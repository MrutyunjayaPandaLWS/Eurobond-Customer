/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstRaffleDetails : Codable {
	let bannerUrl : String?
	let budget : Int?
	let campaignType : Int?
	let createdBy : String?
	let createdDate : String?
	let cuSegment : String?
	let cuSegmentTypeID : Int?
	let cusSegmentId : Int?
	let cusSegmentType : String?
	let fileName : String?
	let isActive : String?
	let isRaffleActive : Bool?
	let lRaffelType : Int?
	let merchntId : String?
	let minMemberPart : Int?
	let noTicketPerMember : Int?
	let pointsPerTicket : Int?
	let pointsWin : String?
	let productIds : String?
	let purgeRuleId : Int?
	let quantity : String?
	let raffelCampaignDescription : String?
	let raffelCampaignId : Int?
	let raffelCampaignName : String?
	let raffelShuffleId : Int?
	let raffelShuffleIds : String?
	let raffelShuffleValue : Int?
	let raffelTypeName : String?
	let skuIds : String?
	let status : String?
	let taffelShuffleIds : String?
	let ticketNumber : Int?
	let totalMemberCanWin : Int?
	let totalMembersParticipated : String?
	let totalRaffelTicket : Int?
	let totalRaffelWinner : String?
	let totalRows : Int?
	let totalTicketsPurchased : String?
	let validityFrom : String?
	let validityTo : String?
	let videoUrl : String?
	let winCount : Int?
	let winnerCity : String?
	let winnerMembershipId : String?
	let winnerName : String?
	let winningPoints : Int?
	let winningRuleId : Int?

	enum CodingKeys: String, CodingKey {

		case bannerUrl = "BannerUrl"
		case budget = "Budget"
		case campaignType = "CampaignType"
		case createdBy = "CreatedBy"
		case createdDate = "CreatedDate"
		case cuSegment = "CuSegment"
		case cuSegmentTypeID = "CuSegmentTypeID"
		case cusSegmentId = "CusSegmentId"
		case cusSegmentType = "CusSegmentType"
		case fileName = "FileName"
		case isActive = "IsActive"
		case isRaffleActive = "IsRaffleActive"
		case lRaffelType = "LRaffelType"
		case merchntId = "MerchntId"
		case minMemberPart = "MinMemberPart"
		case noTicketPerMember = "NoTicketPerMember"
		case pointsPerTicket = "PointsPerTicket"
		case pointsWin = "PointsWin"
		case productIds = "ProductIds"
		case purgeRuleId = "PurgeRuleId"
		case quantity = "Quantity"
		case raffelCampaignDescription = "RaffelCampaignDescription"
		case raffelCampaignId = "RaffelCampaignId"
		case raffelCampaignName = "RaffelCampaignName"
		case raffelShuffleId = "RaffelShuffleId"
		case raffelShuffleIds = "RaffelShuffleIds"
		case raffelShuffleValue = "RaffelShuffleValue"
		case raffelTypeName = "RaffelTypeName"
		case skuIds = "SkuIds"
		case status = "Status"
		case taffelShuffleIds = "TaffelShuffleIds"
		case ticketNumber = "TicketNumber"
		case totalMemberCanWin = "TotalMemberCanWin"
		case totalMembersParticipated = "TotalMembersParticipated"
		case totalRaffelTicket = "TotalRaffelTicket"
		case totalRaffelWinner = "TotalRaffelWinner"
		case totalRows = "TotalRows"
		case totalTicketsPurchased = "TotalTicketsPurchased"
		case validityFrom = "ValidityFrom"
		case validityTo = "ValidityTo"
		case videoUrl = "VideoUrl"
		case winCount = "WinCount"
		case winnerCity = "WinnerCity"
		case winnerMembershipId = "WinnerMembershipId"
		case winnerName = "WinnerName"
		case winningPoints = "WinningPoints"
		case winningRuleId = "WinningRuleId"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		bannerUrl = try values.decodeIfPresent(String.self, forKey: .bannerUrl)
		budget = try values.decodeIfPresent(Int.self, forKey: .budget)
		campaignType = try values.decodeIfPresent(Int.self, forKey: .campaignType)
		createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
		createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
		cuSegment = try values.decodeIfPresent(String.self, forKey: .cuSegment)
		cuSegmentTypeID = try values.decodeIfPresent(Int.self, forKey: .cuSegmentTypeID)
		cusSegmentId = try values.decodeIfPresent(Int.self, forKey: .cusSegmentId)
		cusSegmentType = try values.decodeIfPresent(String.self, forKey: .cusSegmentType)
		fileName = try values.decodeIfPresent(String.self, forKey: .fileName)
		isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
		isRaffleActive = try values.decodeIfPresent(Bool.self, forKey: .isRaffleActive)
		lRaffelType = try values.decodeIfPresent(Int.self, forKey: .lRaffelType)
		merchntId = try values.decodeIfPresent(String.self, forKey: .merchntId)
		minMemberPart = try values.decodeIfPresent(Int.self, forKey: .minMemberPart)
		noTicketPerMember = try values.decodeIfPresent(Int.self, forKey: .noTicketPerMember)
		pointsPerTicket = try values.decodeIfPresent(Int.self, forKey: .pointsPerTicket)
		pointsWin = try values.decodeIfPresent(String.self, forKey: .pointsWin)
		productIds = try values.decodeIfPresent(String.self, forKey: .productIds)
		purgeRuleId = try values.decodeIfPresent(Int.self, forKey: .purgeRuleId)
		quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
		raffelCampaignDescription = try values.decodeIfPresent(String.self, forKey: .raffelCampaignDescription)
		raffelCampaignId = try values.decodeIfPresent(Int.self, forKey: .raffelCampaignId)
		raffelCampaignName = try values.decodeIfPresent(String.self, forKey: .raffelCampaignName)
		raffelShuffleId = try values.decodeIfPresent(Int.self, forKey: .raffelShuffleId)
		raffelShuffleIds = try values.decodeIfPresent(String.self, forKey: .raffelShuffleIds)
		raffelShuffleValue = try values.decodeIfPresent(Int.self, forKey: .raffelShuffleValue)
		raffelTypeName = try values.decodeIfPresent(String.self, forKey: .raffelTypeName)
		skuIds = try values.decodeIfPresent(String.self, forKey: .skuIds)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		taffelShuffleIds = try values.decodeIfPresent(String.self, forKey: .taffelShuffleIds)
		ticketNumber = try values.decodeIfPresent(Int.self, forKey: .ticketNumber)
		totalMemberCanWin = try values.decodeIfPresent(Int.self, forKey: .totalMemberCanWin)
		totalMembersParticipated = try values.decodeIfPresent(String.self, forKey: .totalMembersParticipated)
		totalRaffelTicket = try values.decodeIfPresent(Int.self, forKey: .totalRaffelTicket)
		totalRaffelWinner = try values.decodeIfPresent(String.self, forKey: .totalRaffelWinner)
		totalRows = try values.decodeIfPresent(Int.self, forKey: .totalRows)
		totalTicketsPurchased = try values.decodeIfPresent(String.self, forKey: .totalTicketsPurchased)
		validityFrom = try values.decodeIfPresent(String.self, forKey: .validityFrom)
		validityTo = try values.decodeIfPresent(String.self, forKey: .validityTo)
		videoUrl = try values.decodeIfPresent(String.self, forKey: .videoUrl)
		winCount = try values.decodeIfPresent(Int.self, forKey: .winCount)
		winnerCity = try values.decodeIfPresent(String.self, forKey: .winnerCity)
		winnerMembershipId = try values.decodeIfPresent(String.self, forKey: .winnerMembershipId)
		winnerName = try values.decodeIfPresent(String.self, forKey: .winnerName)
		winningPoints = try values.decodeIfPresent(Int.self, forKey: .winningPoints)
		winningRuleId = try values.decodeIfPresent(Int.self, forKey: .winningRuleId)
	}

}