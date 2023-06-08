/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstCustomerCartORDER : Codable {
	let address : String?
	let allowDemoCharge : Bool?
	let cancelledOrder : Int?
	let cityName : String?
	let color : String?
	let comment : String?
	let companyName : String?
	let completedOrder : Int?
	let countryName : String?
	let customerCartId : Int?
	let demoCharge : Int?
	let discountCriteria : Int?
	let discountValue : Int?
	let email : String?
	let finalAmount : Int?
	let firmTypeName : String?
	let fullName : String?
	let gST : Double?
	let gstPercentage : String?
	let invoiceNo : String?
	let itemType : String?
	let jCartDate : String?
	let landingDiscount : Int?
	let landingPrice : Int?
	let landingQuantityPrice : Int?
	let landingTotalGST : Int?
	let landingTotalPrice : Double?
	let locationName : String?
	let loyaltyId : String?
	let mobile : String?
	let netAmount : Int?
	let orderDate : String?
	let orderDetailsId : Int?
	let orderId : Int?
	let orderNumber : String?
	let orderStatus : String?
	let orderStatusId : Int?
	let paymentMode : String?
	let paymentStatus : String?
	let paymentTranID : String?
	let pendingOrder : Int?
	let prodAvailabilityStatus : String?
	let prodCode : String?
	let prodDescription : String?
	let prodImg : String?
	let prodMiscellaneousCode : String?
	let prodPrice : Double?
	let productGroupInfoId : Int?
	let productId : Int?
	let productImg : String?
	let productName : String?
	let productStockQuantity : Int?
	let promoCode : String?
	let promoCodeId : Int?
	let quantity : Int?
	let rate : Int?
	let rowNo : Int?
	let rowTotalPrice : Int?
	let sKU : String?
	let sKUDesc : String?
	let sapCode : String?
	let shippedOrder : Int?
	let shippingName : String?
	let skuId : Int?
	let stateName : String?
	let statusName : String?
	let sumLandingQuantityPrice : Int?
	let toPassStatus : Int?
	let totalRows : Int?
	let totalTransaction : Int?
	let uOM : String?
	let userID : Int?
	let zip : String?
	let jEnrolledDate : String?
	let lsrCartProductDetails : String?

	enum CodingKeys: String, CodingKey {

		case address = "Address"
		case allowDemoCharge = "AllowDemoCharge"
		case cancelledOrder = "CancelledOrder"
		case cityName = "CityName"
		case color = "Color"
		case comment = "Comment"
		case companyName = "CompanyName"
		case completedOrder = "CompletedOrder"
		case countryName = "CountryName"
		case customerCartId = "CustomerCartId"
		case demoCharge = "DemoCharge"
		case discountCriteria = "DiscountCriteria"
		case discountValue = "DiscountValue"
		case email = "Email"
		case finalAmount = "FinalAmount"
		case firmTypeName = "FirmTypeName"
		case fullName = "FullName"
		case gST = "GST"
		case gstPercentage = "GstPercentage"
		case invoiceNo = "InvoiceNo"
		case itemType = "ItemType"
		case jCartDate = "JCartDate"
		case landingDiscount = "LandingDiscount"
		case landingPrice = "LandingPrice"
		case landingQuantityPrice = "LandingQuantityPrice"
		case landingTotalGST = "LandingTotalGST"
		case landingTotalPrice = "LandingTotalPrice"
		case locationName = "LocationName"
		case loyaltyId = "LoyaltyId"
		case mobile = "Mobile"
		case netAmount = "NetAmount"
		case orderDate = "OrderDate"
		case orderDetailsId = "OrderDetailsId"
		case orderId = "OrderId"
		case orderNumber = "OrderNumber"
		case orderStatus = "OrderStatus"
		case orderStatusId = "OrderStatusId"
		case paymentMode = "PaymentMode"
		case paymentStatus = "PaymentStatus"
		case paymentTranID = "PaymentTranID"
		case pendingOrder = "PendingOrder"
		case prodAvailabilityStatus = "ProdAvailabilityStatus"
		case prodCode = "ProdCode"
		case prodDescription = "ProdDescription"
		case prodImg = "ProdImg"
		case prodMiscellaneousCode = "ProdMiscellaneousCode"
		case prodPrice = "ProdPrice"
		case productGroupInfoId = "ProductGroupInfoId"
		case productId = "ProductId"
		case productImg = "ProductImg"
		case productName = "ProductName"
		case productStockQuantity = "ProductStockQuantity"
		case promoCode = "PromoCode"
		case promoCodeId = "PromoCodeId"
		case quantity = "Quantity"
		case rate = "Rate"
		case rowNo = "RowNo"
		case rowTotalPrice = "RowTotalPrice"
		case sKU = "SKU"
		case sKUDesc = "SKUDesc"
		case sapCode = "SapCode"
		case shippedOrder = "ShippedOrder"
		case shippingName = "ShippingName"
		case skuId = "SkuId"
		case stateName = "StateName"
		case statusName = "StatusName"
		case sumLandingQuantityPrice = "SumLandingQuantityPrice"
		case toPassStatus = "ToPassStatus"
		case totalRows = "TotalRows"
		case totalTransaction = "TotalTransaction"
		case uOM = "UOM"
		case userID = "UserID"
		case zip = "Zip"
		case jEnrolledDate = "jEnrolledDate"
		case lsrCartProductDetails = "lsrCartProductDetails"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		allowDemoCharge = try values.decodeIfPresent(Bool.self, forKey: .allowDemoCharge)
		cancelledOrder = try values.decodeIfPresent(Int.self, forKey: .cancelledOrder)
		cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
		color = try values.decodeIfPresent(String.self, forKey: .color)
		comment = try values.decodeIfPresent(String.self, forKey: .comment)
		companyName = try values.decodeIfPresent(String.self, forKey: .companyName)
		completedOrder = try values.decodeIfPresent(Int.self, forKey: .completedOrder)
		countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
		customerCartId = try values.decodeIfPresent(Int.self, forKey: .customerCartId)
		demoCharge = try values.decodeIfPresent(Int.self, forKey: .demoCharge)
		discountCriteria = try values.decodeIfPresent(Int.self, forKey: .discountCriteria)
		discountValue = try values.decodeIfPresent(Int.self, forKey: .discountValue)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		finalAmount = try values.decodeIfPresent(Int.self, forKey: .finalAmount)
		firmTypeName = try values.decodeIfPresent(String.self, forKey: .firmTypeName)
		fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
		gST = try values.decodeIfPresent(Double.self, forKey: .gST)
		gstPercentage = try values.decodeIfPresent(String.self, forKey: .gstPercentage)
		invoiceNo = try values.decodeIfPresent(String.self, forKey: .invoiceNo)
		itemType = try values.decodeIfPresent(String.self, forKey: .itemType)
		jCartDate = try values.decodeIfPresent(String.self, forKey: .jCartDate)
		landingDiscount = try values.decodeIfPresent(Int.self, forKey: .landingDiscount)
		landingPrice = try values.decodeIfPresent(Int.self, forKey: .landingPrice)
		landingQuantityPrice = try values.decodeIfPresent(Int.self, forKey: .landingQuantityPrice)
		landingTotalGST = try values.decodeIfPresent(Int.self, forKey: .landingTotalGST)
		landingTotalPrice = try values.decodeIfPresent(Double.self, forKey: .landingTotalPrice)
		locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		netAmount = try values.decodeIfPresent(Int.self, forKey: .netAmount)
		orderDate = try values.decodeIfPresent(String.self, forKey: .orderDate)
		orderDetailsId = try values.decodeIfPresent(Int.self, forKey: .orderDetailsId)
		orderId = try values.decodeIfPresent(Int.self, forKey: .orderId)
		orderNumber = try values.decodeIfPresent(String.self, forKey: .orderNumber)
		orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
		orderStatusId = try values.decodeIfPresent(Int.self, forKey: .orderStatusId)
		paymentMode = try values.decodeIfPresent(String.self, forKey: .paymentMode)
		paymentStatus = try values.decodeIfPresent(String.self, forKey: .paymentStatus)
		paymentTranID = try values.decodeIfPresent(String.self, forKey: .paymentTranID)
		pendingOrder = try values.decodeIfPresent(Int.self, forKey: .pendingOrder)
		prodAvailabilityStatus = try values.decodeIfPresent(String.self, forKey: .prodAvailabilityStatus)
		prodCode = try values.decodeIfPresent(String.self, forKey: .prodCode)
		prodDescription = try values.decodeIfPresent(String.self, forKey: .prodDescription)
		prodImg = try values.decodeIfPresent(String.self, forKey: .prodImg)
		prodMiscellaneousCode = try values.decodeIfPresent(String.self, forKey: .prodMiscellaneousCode)
		prodPrice = try values.decodeIfPresent(Double.self, forKey: .prodPrice)
		productGroupInfoId = try values.decodeIfPresent(Int.self, forKey: .productGroupInfoId)
		productId = try values.decodeIfPresent(Int.self, forKey: .productId)
		productImg = try values.decodeIfPresent(String.self, forKey: .productImg)
		productName = try values.decodeIfPresent(String.self, forKey: .productName)
		productStockQuantity = try values.decodeIfPresent(Int.self, forKey: .productStockQuantity)
		promoCode = try values.decodeIfPresent(String.self, forKey: .promoCode)
		promoCodeId = try values.decodeIfPresent(Int.self, forKey: .promoCodeId)
		quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
		rate = try values.decodeIfPresent(Int.self, forKey: .rate)
		rowNo = try values.decodeIfPresent(Int.self, forKey: .rowNo)
		rowTotalPrice = try values.decodeIfPresent(Int.self, forKey: .rowTotalPrice)
		sKU = try values.decodeIfPresent(String.self, forKey: .sKU)
		sKUDesc = try values.decodeIfPresent(String.self, forKey: .sKUDesc)
		sapCode = try values.decodeIfPresent(String.self, forKey: .sapCode)
		shippedOrder = try values.decodeIfPresent(Int.self, forKey: .shippedOrder)
		shippingName = try values.decodeIfPresent(String.self, forKey: .shippingName)
		skuId = try values.decodeIfPresent(Int.self, forKey: .skuId)
		stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
		statusName = try values.decodeIfPresent(String.self, forKey: .statusName)
		sumLandingQuantityPrice = try values.decodeIfPresent(Int.self, forKey: .sumLandingQuantityPrice)
		toPassStatus = try values.decodeIfPresent(Int.self, forKey: .toPassStatus)
		totalRows = try values.decodeIfPresent(Int.self, forKey: .totalRows)
		totalTransaction = try values.decodeIfPresent(Int.self, forKey: .totalTransaction)
		uOM = try values.decodeIfPresent(String.self, forKey: .uOM)
		userID = try values.decodeIfPresent(Int.self, forKey: .userID)
		zip = try values.decodeIfPresent(String.self, forKey: .zip)
		jEnrolledDate = try values.decodeIfPresent(String.self, forKey: .jEnrolledDate)
		lsrCartProductDetails = try values.decodeIfPresent(String.self, forKey: .lsrCartProductDetails)
	}

}
