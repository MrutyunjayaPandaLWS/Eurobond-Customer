/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ObjCatalogueList3 : Codable {
	let actionType : Int?
	let actorId : Int?
	let actorRole : String?
	let isActive : Bool?
	let brandTermsAndConditions : String?
	let catalogueBrandCode : String?
	let catalogueBrandDesc : String?
	let catalogueBrandId : Int?
	let catalogueBrandName : String?
	let categoryParentID : Int?
	let catogoryId : Int?
	let catogoryImage : String?
	let catogoryName : String?
	let color_Code : String?
	let color_Id : Int?
	let color_Name : String?
	let fromDate : String?
	let jFromDate : String?
	let jToDate : String?
	let merchantId : Int?
	let merchantName : String?
	let modelId : Int?
	let modelName : String?
	let status : Int?
	let subCategoryID : Int?
	let subCategoryName : String?
	let termsCondition : String?
	let toDate : String?
	let userAccess : Int?
	let activeStatus : Bool?
	let actualRedemptionDate : String?
	let additionalRemarks : String?
	let approverName : String?
	let averageEarning : String?
	let avgExpDate : String?
	let avgGreaterExpDate : String?
	let avgLesserExpDate : String?
	let barcode : String?
	let cashPerUnit : Int?
	let cashValue : Int?
	let catalogueId : Int?
	let catalogueIdExist : Int?
	let catalogueType : Int?
	let catalougeBrandName : String?
	let categoryID : Int?
	let categoryName : String?
	let commandName : String?
	let comments : String?
	let countryCurrencyCode : String?
	let countryID : Int?
	let createdBy : String?
	let createdDate : String?
	let customerCartId : Int?
	let dailyAvgCash : String?
	let deliveryType : String?
	let dreamGiftId : Int?
	let expectedDelivery : String?
	let expiryDate : String?
	let expiryOn : Int?
	let greaterAvgCash : String?
	let hasPartialPayment : Bool?
	let isAddPlanner : Bool?
	let isApproved : Bool?
	let isCash : Bool?
	let isPlanner : Bool?
	let isPopularCount : Int?
	let jRedemptionDate : String?
	let lesserAvgCash : String?
	let locationId : Int?
	let loyaltyId : String?
	let mSQA : Int?
	let memberName : String?
	let minimumStockQunty : Int?
	let mobile : String?
	let multipleRedIds : String?
	let noOfPointsDebit : Int?
	let noOfQuantity : Int?
	let partialPaymentCash : Int?
	let plannerStatus : String?
	let pointBalance : Int?
	let pointRedem : Int?
	let pointReqToAcheiveProduct : Int?
	let pointsPerUnit : Int?
	let pointsRequired : Int?
	let productCode : String?
	let productDesc : String?
	let productImage : String?
	let productImageServerPath : String?
	let productName : String?
	let product_type : Int?
	let redeemableAverageEarning : String?
	let redeemableAverageEarning12 : Int?
	let redeemableAverageEarning6 : Int?
	let redeemableEncashBalance : Int?
	let redeemablePointBalance : Int?
	let redemptionDate : String?
	let redemptionId : Int?
	let redemptionPlannerId : Int?
	let redemptionRefno : String?
	let redemptionStatus : String?
	let redemptionTypeId : Int?
	let segmentDetails : String?
	let selectedStatus : Int?
	let sumOfTotalPointsRequired : Int?
	let totalCash : Int?
	let total_Row : Int?
	let vendorId : Int?
	let vendorName : String?
	let max_points : String?
	let min_points : String?

	enum CodingKeys: String, CodingKey {

		case actionType = "ActionType"
		case actorId = "ActorId"
		case actorRole = "ActorRole"
		case isActive = "IsActive"
		case brandTermsAndConditions = "BrandTermsAndConditions"
		case catalogueBrandCode = "CatalogueBrandCode"
		case catalogueBrandDesc = "CatalogueBrandDesc"
		case catalogueBrandId = "CatalogueBrandId"
		case catalogueBrandName = "CatalogueBrandName"
		case categoryParentID = "CategoryParentID"
		case catogoryId = "CatogoryId"
		case catogoryImage = "CatogoryImage"
		case catogoryName = "CatogoryName"
		case color_Code = "Color_Code"
		case color_Id = "Color_Id"
		case color_Name = "Color_Name"
		case fromDate = "FromDate"
		case jFromDate = "JFromDate"
		case jToDate = "JToDate"
		case merchantId = "MerchantId"
		case merchantName = "MerchantName"
		case modelId = "ModelId"
		case modelName = "ModelName"
		case status = "Status"
		case subCategoryID = "SubCategoryID"
		case subCategoryName = "SubCategoryName"
		case termsCondition = "TermsCondition"
		case toDate = "ToDate"
		case userAccess = "UserAccess"
		case activeStatus = "ActiveStatus"
		case actualRedemptionDate = "ActualRedemptionDate"
		case additionalRemarks = "AdditionalRemarks"
		case approverName = "ApproverName"
		case averageEarning = "AverageEarning"
		case avgExpDate = "AvgExpDate"
		case avgGreaterExpDate = "AvgGreaterExpDate"
		case avgLesserExpDate = "AvgLesserExpDate"
		case barcode = "Barcode"
		case cashPerUnit = "CashPerUnit"
		case cashValue = "CashValue"
		case catalogueId = "CatalogueId"
		case catalogueIdExist = "CatalogueIdExist"
		case catalogueType = "CatalogueType"
		case catalougeBrandName = "CatalougeBrandName"
		case categoryID = "CategoryID"
		case categoryName = "CategoryName"
		case commandName = "CommandName"
		case comments = "Comments"
		case countryCurrencyCode = "CountryCurrencyCode"
		case countryID = "CountryID"
		case createdBy = "CreatedBy"
		case createdDate = "CreatedDate"
		case customerCartId = "CustomerCartId"
		case dailyAvgCash = "DailyAvgCash"
		case deliveryType = "DeliveryType"
		case dreamGiftId = "DreamGiftId"
		case expectedDelivery = "ExpectedDelivery"
		case expiryDate = "ExpiryDate"
		case expiryOn = "ExpiryOn"
		case greaterAvgCash = "GreaterAvgCash"
		case hasPartialPayment = "HasPartialPayment"
		case isAddPlanner = "IsAddPlanner"
		case isApproved = "IsApproved"
		case isCash = "IsCash"
		case isPlanner = "IsPlanner"
		case isPopularCount = "IsPopularCount"
		case jRedemptionDate = "JRedemptionDate"
		case lesserAvgCash = "LesserAvgCash"
		case locationId = "LocationId"
		case loyaltyId = "LoyaltyId"
		case mSQA = "MSQA"
		case memberName = "MemberName"
		case minimumStockQunty = "MinimumStockQunty"
		case mobile = "Mobile"
		case multipleRedIds = "MultipleRedIds"
		case noOfPointsDebit = "NoOfPointsDebit"
		case noOfQuantity = "NoOfQuantity"
		case partialPaymentCash = "PartialPaymentCash"
		case plannerStatus = "PlannerStatus"
		case pointBalance = "PointBalance"
		case pointRedem = "PointRedem"
		case pointReqToAcheiveProduct = "PointReqToAcheiveProduct"
		case pointsPerUnit = "PointsPerUnit"
		case pointsRequired = "PointsRequired"
		case productCode = "ProductCode"
		case productDesc = "ProductDesc"
		case productImage = "ProductImage"
		case productImageServerPath = "ProductImageServerPath"
		case productName = "ProductName"
		case product_type = "Product_type"
		case redeemableAverageEarning = "RedeemableAverageEarning"
		case redeemableAverageEarning12 = "RedeemableAverageEarning12"
		case redeemableAverageEarning6 = "RedeemableAverageEarning6"
		case redeemableEncashBalance = "RedeemableEncashBalance"
		case redeemablePointBalance = "RedeemablePointBalance"
		case redemptionDate = "RedemptionDate"
		case redemptionId = "RedemptionId"
		case redemptionPlannerId = "RedemptionPlannerId"
		case redemptionRefno = "RedemptionRefno"
		case redemptionStatus = "RedemptionStatus"
		case redemptionTypeId = "RedemptionTypeId"
		case segmentDetails = "SegmentDetails"
		case selectedStatus = "SelectedStatus"
		case sumOfTotalPointsRequired = "SumOfTotalPointsRequired"
		case totalCash = "TotalCash"
		case total_Row = "Total_Row"
		case vendorId = "VendorId"
		case vendorName = "VendorName"
		case max_points = "max_points"
		case min_points = "min_points"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
		actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
		actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		brandTermsAndConditions = try values.decodeIfPresent(String.self, forKey: .brandTermsAndConditions)
		catalogueBrandCode = try values.decodeIfPresent(String.self, forKey: .catalogueBrandCode)
		catalogueBrandDesc = try values.decodeIfPresent(String.self, forKey: .catalogueBrandDesc)
		catalogueBrandId = try values.decodeIfPresent(Int.self, forKey: .catalogueBrandId)
		catalogueBrandName = try values.decodeIfPresent(String.self, forKey: .catalogueBrandName)
		categoryParentID = try values.decodeIfPresent(Int.self, forKey: .categoryParentID)
		catogoryId = try values.decodeIfPresent(Int.self, forKey: .catogoryId)
		catogoryImage = try values.decodeIfPresent(String.self, forKey: .catogoryImage)
		catogoryName = try values.decodeIfPresent(String.self, forKey: .catogoryName)
		color_Code = try values.decodeIfPresent(String.self, forKey: .color_Code)
		color_Id = try values.decodeIfPresent(Int.self, forKey: .color_Id)
		color_Name = try values.decodeIfPresent(String.self, forKey: .color_Name)
		fromDate = try values.decodeIfPresent(String.self, forKey: .fromDate)
		jFromDate = try values.decodeIfPresent(String.self, forKey: .jFromDate)
		jToDate = try values.decodeIfPresent(String.self, forKey: .jToDate)
		merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
		merchantName = try values.decodeIfPresent(String.self, forKey: .merchantName)
		modelId = try values.decodeIfPresent(Int.self, forKey: .modelId)
		modelName = try values.decodeIfPresent(String.self, forKey: .modelName)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		subCategoryID = try values.decodeIfPresent(Int.self, forKey: .subCategoryID)
		subCategoryName = try values.decodeIfPresent(String.self, forKey: .subCategoryName)
		termsCondition = try values.decodeIfPresent(String.self, forKey: .termsCondition)
		toDate = try values.decodeIfPresent(String.self, forKey: .toDate)
		userAccess = try values.decodeIfPresent(Int.self, forKey: .userAccess)
		activeStatus = try values.decodeIfPresent(Bool.self, forKey: .activeStatus)
		actualRedemptionDate = try values.decodeIfPresent(String.self, forKey: .actualRedemptionDate)
		additionalRemarks = try values.decodeIfPresent(String.self, forKey: .additionalRemarks)
		approverName = try values.decodeIfPresent(String.self, forKey: .approverName)
		averageEarning = try values.decodeIfPresent(String.self, forKey: .averageEarning)
		avgExpDate = try values.decodeIfPresent(String.self, forKey: .avgExpDate)
		avgGreaterExpDate = try values.decodeIfPresent(String.self, forKey: .avgGreaterExpDate)
		avgLesserExpDate = try values.decodeIfPresent(String.self, forKey: .avgLesserExpDate)
		barcode = try values.decodeIfPresent(String.self, forKey: .barcode)
		cashPerUnit = try values.decodeIfPresent(Int.self, forKey: .cashPerUnit)
		cashValue = try values.decodeIfPresent(Int.self, forKey: .cashValue)
		catalogueId = try values.decodeIfPresent(Int.self, forKey: .catalogueId)
		catalogueIdExist = try values.decodeIfPresent(Int.self, forKey: .catalogueIdExist)
		catalogueType = try values.decodeIfPresent(Int.self, forKey: .catalogueType)
		catalougeBrandName = try values.decodeIfPresent(String.self, forKey: .catalougeBrandName)
		categoryID = try values.decodeIfPresent(Int.self, forKey: .categoryID)
		categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
		commandName = try values.decodeIfPresent(String.self, forKey: .commandName)
		comments = try values.decodeIfPresent(String.self, forKey: .comments)
		countryCurrencyCode = try values.decodeIfPresent(String.self, forKey: .countryCurrencyCode)
		countryID = try values.decodeIfPresent(Int.self, forKey: .countryID)
		createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
		createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
		customerCartId = try values.decodeIfPresent(Int.self, forKey: .customerCartId)
		dailyAvgCash = try values.decodeIfPresent(String.self, forKey: .dailyAvgCash)
		deliveryType = try values.decodeIfPresent(String.self, forKey: .deliveryType)
		dreamGiftId = try values.decodeIfPresent(Int.self, forKey: .dreamGiftId)
		expectedDelivery = try values.decodeIfPresent(String.self, forKey: .expectedDelivery)
		expiryDate = try values.decodeIfPresent(String.self, forKey: .expiryDate)
		expiryOn = try values.decodeIfPresent(Int.self, forKey: .expiryOn)
		greaterAvgCash = try values.decodeIfPresent(String.self, forKey: .greaterAvgCash)
		hasPartialPayment = try values.decodeIfPresent(Bool.self, forKey: .hasPartialPayment)
		isAddPlanner = try values.decodeIfPresent(Bool.self, forKey: .isAddPlanner)
		isApproved = try values.decodeIfPresent(Bool.self, forKey: .isApproved)
		isCash = try values.decodeIfPresent(Bool.self, forKey: .isCash)
		isPlanner = try values.decodeIfPresent(Bool.self, forKey: .isPlanner)
		isPopularCount = try values.decodeIfPresent(Int.self, forKey: .isPopularCount)
		jRedemptionDate = try values.decodeIfPresent(String.self, forKey: .jRedemptionDate)
		lesserAvgCash = try values.decodeIfPresent(String.self, forKey: .lesserAvgCash)
		locationId = try values.decodeIfPresent(Int.self, forKey: .locationId)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
		mSQA = try values.decodeIfPresent(Int.self, forKey: .mSQA)
		memberName = try values.decodeIfPresent(String.self, forKey: .memberName)
		minimumStockQunty = try values.decodeIfPresent(Int.self, forKey: .minimumStockQunty)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		multipleRedIds = try values.decodeIfPresent(String.self, forKey: .multipleRedIds)
		noOfPointsDebit = try values.decodeIfPresent(Int.self, forKey: .noOfPointsDebit)
		noOfQuantity = try values.decodeIfPresent(Int.self, forKey: .noOfQuantity)
		partialPaymentCash = try values.decodeIfPresent(Int.self, forKey: .partialPaymentCash)
		plannerStatus = try values.decodeIfPresent(String.self, forKey: .plannerStatus)
		pointBalance = try values.decodeIfPresent(Int.self, forKey: .pointBalance)
		pointRedem = try values.decodeIfPresent(Int.self, forKey: .pointRedem)
		pointReqToAcheiveProduct = try values.decodeIfPresent(Int.self, forKey: .pointReqToAcheiveProduct)
		pointsPerUnit = try values.decodeIfPresent(Int.self, forKey: .pointsPerUnit)
		pointsRequired = try values.decodeIfPresent(Int.self, forKey: .pointsRequired)
		productCode = try values.decodeIfPresent(String.self, forKey: .productCode)
		productDesc = try values.decodeIfPresent(String.self, forKey: .productDesc)
		productImage = try values.decodeIfPresent(String.self, forKey: .productImage)
		productImageServerPath = try values.decodeIfPresent(String.self, forKey: .productImageServerPath)
		productName = try values.decodeIfPresent(String.self, forKey: .productName)
		product_type = try values.decodeIfPresent(Int.self, forKey: .product_type)
		redeemableAverageEarning = try values.decodeIfPresent(String.self, forKey: .redeemableAverageEarning)
		redeemableAverageEarning12 = try values.decodeIfPresent(Int.self, forKey: .redeemableAverageEarning12)
		redeemableAverageEarning6 = try values.decodeIfPresent(Int.self, forKey: .redeemableAverageEarning6)
		redeemableEncashBalance = try values.decodeIfPresent(Int.self, forKey: .redeemableEncashBalance)
		redeemablePointBalance = try values.decodeIfPresent(Int.self, forKey: .redeemablePointBalance)
		redemptionDate = try values.decodeIfPresent(String.self, forKey: .redemptionDate)
		redemptionId = try values.decodeIfPresent(Int.self, forKey: .redemptionId)
		redemptionPlannerId = try values.decodeIfPresent(Int.self, forKey: .redemptionPlannerId)
		redemptionRefno = try values.decodeIfPresent(String.self, forKey: .redemptionRefno)
		redemptionStatus = try values.decodeIfPresent(String.self, forKey: .redemptionStatus)
		redemptionTypeId = try values.decodeIfPresent(Int.self, forKey: .redemptionTypeId)
		segmentDetails = try values.decodeIfPresent(String.self, forKey: .segmentDetails)
		selectedStatus = try values.decodeIfPresent(Int.self, forKey: .selectedStatus)
		sumOfTotalPointsRequired = try values.decodeIfPresent(Int.self, forKey: .sumOfTotalPointsRequired)
		totalCash = try values.decodeIfPresent(Int.self, forKey: .totalCash)
		total_Row = try values.decodeIfPresent(Int.self, forKey: .total_Row)
		vendorId = try values.decodeIfPresent(Int.self, forKey: .vendorId)
		vendorName = try values.decodeIfPresent(String.self, forKey: .vendorName)
		max_points = try values.decodeIfPresent(String.self, forKey: .max_points)
		min_points = try values.decodeIfPresent(String.self, forKey: .min_points)
	}

}
