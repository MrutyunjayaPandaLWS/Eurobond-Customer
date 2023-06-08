/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ObjCustomerDashboardListCust : Codable {
    let actionType : Int?
    let actorId : Int?
    let actorRole : String?
    let isActive : Bool?
    let token : String?
    let accessedDate : String?
    let activeRaffelCount : Int?
    let approvedClaimCount : Int?
    let bDEUserMobile : String?
    let bDEUserName : String?
    let behaviourImage : String?
    let behaviourWisePoints : Int?
    let cashBackEarned : String?
    let cashBackEligibility : Double?
    let cashBackType : String?
    let convertedCurrencyValue : Int?
    let createdBy : Int?
    let createdDate : String?
    let customerBonusCampaignStatus : Bool?
    let customerCartCount : Int?
    let customerCredit : Int?
    let customerGrade : String?
    let customerId : Int?
    let customerOrderStatusId : Int?
    let customerOrdersCartCount : Int?
    let customerPendingGamesCount : Int?
    let customerRaffleCount : Int?
    let customerType : String?
    let customerVerifiedStatus : Bool?
    let feedBackSurveyId : Int?
    let giftDonateCount : Int?
    let giftEvoucherCount : Int?
    let giftingEvoucherCount : Int?
    let graphMonth : String?
    let graphYear : Int?
    let identityProofsNotification : Int?
    let isFeedBackGave : Bool?
    let isNotionalPoints : Int?
    let isReply : Int?
    let lifeTimeEarningsAchi : String?
    let lifeTimeEarningsDamages : String?
    let lifeTimeEarningsDue : String?
    let lifeTimeEarningsMissed : String?
    let lifeTimeEarningsOppor : String?
    let mappedBalance : String?
    let mappedRetailerCount : Int?
    let mappedType : String?
    let mappedUserMobile : String?
    let mappedUserName : String?
    let memberSince : String?
    let messageCount : Int?
    let name : String?
    let nextTeirUpgradeMessage : String?
    let notificationCount : Int?
    let notionalPointQuarter : Int?
    let objActivityDetailsList : String?
    let objPromotionCommonList : String?
    let overAllPoints : Int?
    let payBackPoints : Int?
    let pointExpiryCount : Int?
    let profileImage : String?
    let programBehaviour : String?
    let programBehaviourId : Int?
    let qR_Code : String?
    let redeemPoints : Int?
    let redeemableEncashBalance : Int?
    let redeemablePointsBalance : Int?
    let referralBonusPoints : Int?
    let referralCount : Int?
    let remarks : String?
    let retailerId : Int?
    let subscriberCount : Int?
    let sumOfBarChartPoints : Int?
    let sumOfPointsForLineChart : Int?
    let teirUpgradeMessage : String?
    let totalBrokarage : String?
    let totalEarnedPoints : Int?
    let totalMappedCSM : Int?
    let totalMappedPlumbers : Int?
    let totalMappedSubDealers : Int?
    let totalRedeemed : Int?
    let totalRows : Int?
    let totalWithDrawl : Int?
    let verificationStatus : Int?
    let warningCount : Int?

    enum CodingKeys: String, CodingKey {

        case actionType = "ActionType"
        case actorId = "ActorId"
        case actorRole = "ActorRole"
        case isActive = "IsActive"
        case token = "Token"
        case accessedDate = "AccessedDate"
        case activeRaffelCount = "ActiveRaffelCount"
        case approvedClaimCount = "ApprovedClaimCount"
        case bDEUserMobile = "BDEUserMobile"
        case bDEUserName = "BDEUserName"
        case behaviourImage = "BehaviourImage"
        case behaviourWisePoints = "BehaviourWisePoints"
        case cashBackEarned = "CashBackEarned"
        case cashBackEligibility = "CashBackEligibility"
        case cashBackType = "CashBackType"
        case convertedCurrencyValue = "ConvertedCurrencyValue"
        case createdBy = "CreatedBy"
        case createdDate = "CreatedDate"
        case customerBonusCampaignStatus = "CustomerBonusCampaignStatus"
        case customerCartCount = "CustomerCartCount"
        case customerCredit = "CustomerCredit"
        case customerGrade = "CustomerGrade"
        case customerId = "CustomerId"
        case customerOrderStatusId = "CustomerOrderStatusId"
        case customerOrdersCartCount = "CustomerOrdersCartCount"
        case customerPendingGamesCount = "CustomerPendingGamesCount"
        case customerRaffleCount = "CustomerRaffleCount"
        case customerType = "CustomerType"
        case customerVerifiedStatus = "CustomerVerifiedStatus"
        case feedBackSurveyId = "FeedBackSurveyId"
        case giftDonateCount = "GiftDonateCount"
        case giftEvoucherCount = "GiftEvoucherCount"
        case giftingEvoucherCount = "GiftingEvoucherCount"
        case graphMonth = "GraphMonth"
        case graphYear = "GraphYear"
        case identityProofsNotification = "IdentityProofsNotification"
        case isFeedBackGave = "IsFeedBackGave"
        case isNotionalPoints = "IsNotionalPoints"
        case isReply = "IsReply"
        case lifeTimeEarningsAchi = "LifeTimeEarningsAchi"
        case lifeTimeEarningsDamages = "LifeTimeEarningsDamages"
        case lifeTimeEarningsDue = "LifeTimeEarningsDue"
        case lifeTimeEarningsMissed = "LifeTimeEarningsMissed"
        case lifeTimeEarningsOppor = "LifeTimeEarningsOppor"
        case mappedBalance = "MappedBalance"
        case mappedRetailerCount = "MappedRetailerCount"
        case mappedType = "MappedType"
        case mappedUserMobile = "MappedUserMobile"
        case mappedUserName = "MappedUserName"
        case memberSince = "MemberSince"
        case messageCount = "MessageCount"
        case name = "Name"
        case nextTeirUpgradeMessage = "NextTeirUpgradeMessage"
        case notificationCount = "NotificationCount"
        case notionalPointQuarter = "NotionalPointQuarter"
        case objActivityDetailsList = "ObjActivityDetailsList"
        case objPromotionCommonList = "ObjPromotionCommonList"
        case overAllPoints = "OverAllPoints"
        case payBackPoints = "PayBackPoints"
        case pointExpiryCount = "PointExpiryCount"
        case profileImage = "ProfileImage"
        case programBehaviour = "ProgramBehaviour"
        case programBehaviourId = "ProgramBehaviourId"
        case qR_Code = "QR_Code"
        case redeemPoints = "RedeemPoints"
        case redeemableEncashBalance = "RedeemableEncashBalance"
        case redeemablePointsBalance = "RedeemablePointsBalance"
        case referralBonusPoints = "ReferralBonusPoints"
        case referralCount = "ReferralCount"
        case remarks = "Remarks"
        case retailerId = "RetailerId"
        case subscriberCount = "SubscriberCount"
        case sumOfBarChartPoints = "SumOfBarChartPoints"
        case sumOfPointsForLineChart = "SumOfPointsForLineChart"
        case teirUpgradeMessage = "TeirUpgradeMessage"
        case totalBrokarage = "TotalBrokarage"
        case totalEarnedPoints = "TotalEarnedPoints"
        case totalMappedCSM = "TotalMappedCSM"
        case totalMappedPlumbers = "TotalMappedPlumbers"
        case totalMappedSubDealers = "TotalMappedSubDealers"
        case totalRedeemed = "TotalRedeemed"
        case totalRows = "TotalRows"
        case totalWithDrawl = "TotalWithDrawl"
        case verificationStatus = "VerificationStatus"
        case warningCount = "WarningCount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
        actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
        actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        accessedDate = try values.decodeIfPresent(String.self, forKey: .accessedDate)
        activeRaffelCount = try values.decodeIfPresent(Int.self, forKey: .activeRaffelCount)
        approvedClaimCount = try values.decodeIfPresent(Int.self, forKey: .approvedClaimCount)
        bDEUserMobile = try values.decodeIfPresent(String.self, forKey: .bDEUserMobile)
        bDEUserName = try values.decodeIfPresent(String.self, forKey: .bDEUserName)
        behaviourImage = try values.decodeIfPresent(String.self, forKey: .behaviourImage)
        behaviourWisePoints = try values.decodeIfPresent(Int.self, forKey: .behaviourWisePoints)
        cashBackEarned = try values.decodeIfPresent(String.self, forKey: .cashBackEarned)
        cashBackEligibility = try values.decodeIfPresent(Double.self, forKey: .cashBackEligibility)
        cashBackType = try values.decodeIfPresent(String.self, forKey: .cashBackType)
        convertedCurrencyValue = try values.decodeIfPresent(Int.self, forKey: .convertedCurrencyValue)
        createdBy = try values.decodeIfPresent(Int.self, forKey: .createdBy)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        customerBonusCampaignStatus = try values.decodeIfPresent(Bool.self, forKey: .customerBonusCampaignStatus)
        customerCartCount = try values.decodeIfPresent(Int.self, forKey: .customerCartCount)
        customerCredit = try values.decodeIfPresent(Int.self, forKey: .customerCredit)
        customerGrade = try values.decodeIfPresent(String.self, forKey: .customerGrade)
        customerId = try values.decodeIfPresent(Int.self, forKey: .customerId)
        customerOrderStatusId = try values.decodeIfPresent(Int.self, forKey: .customerOrderStatusId)
        customerOrdersCartCount = try values.decodeIfPresent(Int.self, forKey: .customerOrdersCartCount)
        customerPendingGamesCount = try values.decodeIfPresent(Int.self, forKey: .customerPendingGamesCount)
        customerRaffleCount = try values.decodeIfPresent(Int.self, forKey: .customerRaffleCount)
        customerType = try values.decodeIfPresent(String.self, forKey: .customerType)
        customerVerifiedStatus = try values.decodeIfPresent(Bool.self, forKey: .customerVerifiedStatus)
        feedBackSurveyId = try values.decodeIfPresent(Int.self, forKey: .feedBackSurveyId)
        giftDonateCount = try values.decodeIfPresent(Int.self, forKey: .giftDonateCount)
        giftEvoucherCount = try values.decodeIfPresent(Int.self, forKey: .giftEvoucherCount)
        giftingEvoucherCount = try values.decodeIfPresent(Int.self, forKey: .giftingEvoucherCount)
        graphMonth = try values.decodeIfPresent(String.self, forKey: .graphMonth)
        graphYear = try values.decodeIfPresent(Int.self, forKey: .graphYear)
        identityProofsNotification = try values.decodeIfPresent(Int.self, forKey: .identityProofsNotification)
        isFeedBackGave = try values.decodeIfPresent(Bool.self, forKey: .isFeedBackGave)
        isNotionalPoints = try values.decodeIfPresent(Int.self, forKey: .isNotionalPoints)
        isReply = try values.decodeIfPresent(Int.self, forKey: .isReply)
        lifeTimeEarningsAchi = try values.decodeIfPresent(String.self, forKey: .lifeTimeEarningsAchi)
        lifeTimeEarningsDamages = try values.decodeIfPresent(String.self, forKey: .lifeTimeEarningsDamages)
        lifeTimeEarningsDue = try values.decodeIfPresent(String.self, forKey: .lifeTimeEarningsDue)
        lifeTimeEarningsMissed = try values.decodeIfPresent(String.self, forKey: .lifeTimeEarningsMissed)
        lifeTimeEarningsOppor = try values.decodeIfPresent(String.self, forKey: .lifeTimeEarningsOppor)
        mappedBalance = try values.decodeIfPresent(String.self, forKey: .mappedBalance)
        mappedRetailerCount = try values.decodeIfPresent(Int.self, forKey: .mappedRetailerCount)
        mappedType = try values.decodeIfPresent(String.self, forKey: .mappedType)
        mappedUserMobile = try values.decodeIfPresent(String.self, forKey: .mappedUserMobile)
        mappedUserName = try values.decodeIfPresent(String.self, forKey: .mappedUserName)
        memberSince = try values.decodeIfPresent(String.self, forKey: .memberSince)
        messageCount = try values.decodeIfPresent(Int.self, forKey: .messageCount)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        nextTeirUpgradeMessage = try values.decodeIfPresent(String.self, forKey: .nextTeirUpgradeMessage)
        notificationCount = try values.decodeIfPresent(Int.self, forKey: .notificationCount)
        notionalPointQuarter = try values.decodeIfPresent(Int.self, forKey: .notionalPointQuarter)
        objActivityDetailsList = try values.decodeIfPresent(String.self, forKey: .objActivityDetailsList)
        objPromotionCommonList = try values.decodeIfPresent(String.self, forKey: .objPromotionCommonList)
        overAllPoints = try values.decodeIfPresent(Int.self, forKey: .overAllPoints)
        payBackPoints = try values.decodeIfPresent(Int.self, forKey: .payBackPoints)
        pointExpiryCount = try values.decodeIfPresent(Int.self, forKey: .pointExpiryCount)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
        programBehaviour = try values.decodeIfPresent(String.self, forKey: .programBehaviour)
        programBehaviourId = try values.decodeIfPresent(Int.self, forKey: .programBehaviourId)
        qR_Code = try values.decodeIfPresent(String.self, forKey: .qR_Code)
        redeemPoints = try values.decodeIfPresent(Int.self, forKey: .redeemPoints)
        redeemableEncashBalance = try values.decodeIfPresent(Int.self, forKey: .redeemableEncashBalance)
        redeemablePointsBalance = try values.decodeIfPresent(Int.self, forKey: .redeemablePointsBalance)
        referralBonusPoints = try values.decodeIfPresent(Int.self, forKey: .referralBonusPoints)
        referralCount = try values.decodeIfPresent(Int.self, forKey: .referralCount)
        remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
        retailerId = try values.decodeIfPresent(Int.self, forKey: .retailerId)
        subscriberCount = try values.decodeIfPresent(Int.self, forKey: .subscriberCount)
        sumOfBarChartPoints = try values.decodeIfPresent(Int.self, forKey: .sumOfBarChartPoints)
        sumOfPointsForLineChart = try values.decodeIfPresent(Int.self, forKey: .sumOfPointsForLineChart)
        teirUpgradeMessage = try values.decodeIfPresent(String.self, forKey: .teirUpgradeMessage)
        totalBrokarage = try values.decodeIfPresent(String.self, forKey: .totalBrokarage)
        totalEarnedPoints = try values.decodeIfPresent(Int.self, forKey: .totalEarnedPoints)
        totalMappedCSM = try values.decodeIfPresent(Int.self, forKey: .totalMappedCSM)
        totalMappedPlumbers = try values.decodeIfPresent(Int.self, forKey: .totalMappedPlumbers)
        totalMappedSubDealers = try values.decodeIfPresent(Int.self, forKey: .totalMappedSubDealers)
        totalRedeemed = try values.decodeIfPresent(Int.self, forKey: .totalRedeemed)
        totalRows = try values.decodeIfPresent(Int.self, forKey: .totalRows)
        totalWithDrawl = try values.decodeIfPresent(Int.self, forKey: .totalWithDrawl)
        verificationStatus = try values.decodeIfPresent(Int.self, forKey: .verificationStatus)
        warningCount = try values.decodeIfPresent(Int.self, forKey: .warningCount)
    }

}
