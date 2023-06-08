/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstRaffleDetails : Codable {
	let raffelCampaignName : String?
	let videoUrl : String?
	let lRaffelType : Int?
	let campaignType : Int?
	let pointsPerTicket : Int?
	let totalRaffelTicket : Int?
	let taffelShuffleIds : String?
	let raffelCampaignDescription : String?
	let validityFrom : String?
	let cusSegmentId : Int?
	let minMemberPart : Int?
	let noTicketPerMember : Int?
	let productIds : String?
	let bannerUrl : String?
	let validityTo : String?
	let cusSegmentType : String?
	let winCount : Int?
	let budget : Int?
	let skuIds : String?
	let merchntId : String?
	let cuSegment : String?
	let fileName : String?
	let cuSegmentTypeID : Int?
	let totalMemberCanWin : Int?
	let isActive : String?
	let raffelCampaignId : Int?
	let raffelTypeName : String?
	let winningRuleId : Int?
	let purgeRuleId : Int?
	let status : String?
	let quantity : String?
	let winnerCity : String?
	let raffelShuffleIds : String?
	let winnerName : String?
	let pointsWin : String?
	let winnerMembershipId : String?
	let totalTicketsPurchased : String?
	let totalMembersParticipated : String?
	let totalRaffelWinner : String?
	let createdBy : String?
	let createdDate : String?
	let raffelShuffleId : Int?
	let raffelShuffleValue : Int?
	let totalRows : Int?
	let isRaffleActive : Bool?
	let ticketNumber : Int?
	let winningPoints : Int?
	let ticketPoints : Int?
	let noofTicketPurchase : Int?

	enum CodingKeys: String, CodingKey {

		case raffelCampaignName = "raffelCampaignName"
		case videoUrl = "videoUrl"
		case lRaffelType = "lRaffelType"
		case campaignType = "campaignType"
		case pointsPerTicket = "pointsPerTicket"
		case totalRaffelTicket = "totalRaffelTicket"
		case taffelShuffleIds = "taffelShuffleIds"
		case raffelCampaignDescription = "raffelCampaignDescription"
		case validityFrom = "validityFrom"
		case cusSegmentId = "cusSegmentId"
		case minMemberPart = "minMemberPart"
		case noTicketPerMember = "noTicketPerMember"
		case productIds = "productIds"
		case bannerUrl = "bannerUrl"
		case validityTo = "validityTo"
		case cusSegmentType = "cusSegmentType"
		case winCount = "winCount"
		case budget = "budget"
		case skuIds = "skuIds"
		case merchntId = "merchntId"
		case cuSegment = "cuSegment"
		case fileName = "fileName"
		case cuSegmentTypeID = "cuSegmentTypeID"
		case totalMemberCanWin = "totalMemberCanWin"
		case isActive = "isActive"
		case raffelCampaignId = "raffelCampaignId"
		case raffelTypeName = "raffelTypeName"
		case winningRuleId = "winningRuleId"
		case purgeRuleId = "purgeRuleId"
		case status = "status"
		case quantity = "quantity"
		case winnerCity = "winnerCity"
		case raffelShuffleIds = "raffelShuffleIds"
		case winnerName = "winnerName"
		case pointsWin = "pointsWin"
		case winnerMembershipId = "winnerMembershipId"
		case totalTicketsPurchased = "totalTicketsPurchased"
		case totalMembersParticipated = "totalMembersParticipated"
		case totalRaffelWinner = "totalRaffelWinner"
		case createdBy = "createdBy"
		case createdDate = "createdDate"
		case raffelShuffleId = "raffelShuffleId"
		case raffelShuffleValue = "raffelShuffleValue"
		case totalRows = "totalRows"
		case isRaffleActive = "isRaffleActive"
		case ticketNumber = "ticketNumber"
		case winningPoints = "winningPoints"
		case ticketPoints = "ticketPoints"
		case noofTicketPurchase = "noofTicketPurchase"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		raffelCampaignName = try values.decodeIfPresent(String.self, forKey: .raffelCampaignName)
		videoUrl = try values.decodeIfPresent(String.self, forKey: .videoUrl)
		lRaffelType = try values.decodeIfPresent(Int.self, forKey: .lRaffelType)
		campaignType = try values.decodeIfPresent(Int.self, forKey: .campaignType)
		pointsPerTicket = try values.decodeIfPresent(Int.self, forKey: .pointsPerTicket)
		totalRaffelTicket = try values.decodeIfPresent(Int.self, forKey: .totalRaffelTicket)
		taffelShuffleIds = try values.decodeIfPresent(String.self, forKey: .taffelShuffleIds)
		raffelCampaignDescription = try values.decodeIfPresent(String.self, forKey: .raffelCampaignDescription)
		validityFrom = try values.decodeIfPresent(String.self, forKey: .validityFrom)
		cusSegmentId = try values.decodeIfPresent(Int.self, forKey: .cusSegmentId)
		minMemberPart = try values.decodeIfPresent(Int.self, forKey: .minMemberPart)
		noTicketPerMember = try values.decodeIfPresent(Int.self, forKey: .noTicketPerMember)
		productIds = try values.decodeIfPresent(String.self, forKey: .productIds)
		bannerUrl = try values.decodeIfPresent(String.self, forKey: .bannerUrl)
		validityTo = try values.decodeIfPresent(String.self, forKey: .validityTo)
		cusSegmentType = try values.decodeIfPresent(String.self, forKey: .cusSegmentType)
		winCount = try values.decodeIfPresent(Int.self, forKey: .winCount)
		budget = try values.decodeIfPresent(Int.self, forKey: .budget)
		skuIds = try values.decodeIfPresent(String.self, forKey: .skuIds)
		merchntId = try values.decodeIfPresent(String.self, forKey: .merchntId)
		cuSegment = try values.decodeIfPresent(String.self, forKey: .cuSegment)
		fileName = try values.decodeIfPresent(String.self, forKey: .fileName)
		cuSegmentTypeID = try values.decodeIfPresent(Int.self, forKey: .cuSegmentTypeID)
		totalMemberCanWin = try values.decodeIfPresent(Int.self, forKey: .totalMemberCanWin)
		isActive = try values.decodeIfPresent(String.self, forKey: .isActive)
		raffelCampaignId = try values.decodeIfPresent(Int.self, forKey: .raffelCampaignId)
		raffelTypeName = try values.decodeIfPresent(String.self, forKey: .raffelTypeName)
		winningRuleId = try values.decodeIfPresent(Int.self, forKey: .winningRuleId)
		purgeRuleId = try values.decodeIfPresent(Int.self, forKey: .purgeRuleId)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
		winnerCity = try values.decodeIfPresent(String.self, forKey: .winnerCity)
		raffelShuffleIds = try values.decodeIfPresent(String.self, forKey: .raffelShuffleIds)
		winnerName = try values.decodeIfPresent(String.self, forKey: .winnerName)
		pointsWin = try values.decodeIfPresent(String.self, forKey: .pointsWin)
		winnerMembershipId = try values.decodeIfPresent(String.self, forKey: .winnerMembershipId)
		totalTicketsPurchased = try values.decodeIfPresent(String.self, forKey: .totalTicketsPurchased)
		totalMembersParticipated = try values.decodeIfPresent(String.self, forKey: .totalMembersParticipated)
		totalRaffelWinner = try values.decodeIfPresent(String.self, forKey: .totalRaffelWinner)
		createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
		createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
		raffelShuffleId = try values.decodeIfPresent(Int.self, forKey: .raffelShuffleId)
		raffelShuffleValue = try values.decodeIfPresent(Int.self, forKey: .raffelShuffleValue)
		totalRows = try values.decodeIfPresent(Int.self, forKey: .totalRows)
		isRaffleActive = try values.decodeIfPresent(Bool.self, forKey: .isRaffleActive)
		ticketNumber = try values.decodeIfPresent(Int.self, forKey: .ticketNumber)
		winningPoints = try values.decodeIfPresent(Int.self, forKey: .winningPoints)
		ticketPoints = try values.decodeIfPresent(Int.self, forKey: .ticketPoints)
		noofTicketPurchase = try values.decodeIfPresent(Int.self, forKey: .noofTicketPurchase)
	}

}