/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct SyncStatusModel : Codable {
	let scratchCodesList : String?
	let qrUsegereport : [QrUsegereport]?
	let usedScratchCodesList : String?
	let plantName : String?
	let plantCode : String?
	let month : Int?
	let year : Int?
	let segment : String?
	let subSegment : String?
	let sku : String?
	let totalRows : Int?
	let createdDate : String?
	let generatedCodesCount : Double?
	let invoiceNo : String?
	let generatedFor : String?
	let customerTypeCode : String?
	let scQueueID : Int?
	let returnValue : Int?
	let returnMessage : String?
	let totalRecords : Int?

	enum CodingKeys: String, CodingKey {

		case scratchCodesList = "scratchCodesList"
		case qrUsegereport = "qrUsegereport"
		case usedScratchCodesList = "usedScratchCodesList"
		case plantName = "plantName"
		case plantCode = "plantCode"
		case month = "month"
		case year = "year"
		case segment = "segment"
		case subSegment = "subSegment"
		case sku = "sku"
		case totalRows = "totalRows"
		case createdDate = "createdDate"
		case generatedCodesCount = "generatedCodesCount"
		case invoiceNo = "invoiceNo"
		case generatedFor = "generatedFor"
		case customerTypeCode = "customerTypeCode"
		case scQueueID = "scQueueID"
		case returnValue = "returnValue"
		case returnMessage = "returnMessage"
		case totalRecords = "totalRecords"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		scratchCodesList = try values.decodeIfPresent(String.self, forKey: .scratchCodesList)
		qrUsegereport = try values.decodeIfPresent([QrUsegereport].self, forKey: .qrUsegereport)
		usedScratchCodesList = try values.decodeIfPresent(String.self, forKey: .usedScratchCodesList)
		plantName = try values.decodeIfPresent(String.self, forKey: .plantName)
		plantCode = try values.decodeIfPresent(String.self, forKey: .plantCode)
		month = try values.decodeIfPresent(Int.self, forKey: .month)
		year = try values.decodeIfPresent(Int.self, forKey: .year)
		segment = try values.decodeIfPresent(String.self, forKey: .segment)
		subSegment = try values.decodeIfPresent(String.self, forKey: .subSegment)
		sku = try values.decodeIfPresent(String.self, forKey: .sku)
		totalRows = try values.decodeIfPresent(Int.self, forKey: .totalRows)
		createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
		generatedCodesCount = try values.decodeIfPresent(Double.self, forKey: .generatedCodesCount)
		invoiceNo = try values.decodeIfPresent(String.self, forKey: .invoiceNo)
		generatedFor = try values.decodeIfPresent(String.self, forKey: .generatedFor)
		customerTypeCode = try values.decodeIfPresent(String.self, forKey: .customerTypeCode)
		scQueueID = try values.decodeIfPresent(Int.self, forKey: .scQueueID)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
	}

}
