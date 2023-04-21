//
//  CodeSummaryViewModel.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 18/04/22.
//

import Foundation
class CodeSummaryViewModel {
    weak var VC:CodeSummary_VC?
    var requestAPIs = RestAPI_Requests()
    var codeSummaryListingArray = [QrUsegereport]()

    func codeSummaryListingAPI(parameters: JSON){
        self.VC?.startLoading()
        self.requestAPIs.syncCodeListApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        self.codeSummaryListingArray = result?.qrUsegereport ?? []
                        DispatchQueue.main.async {
                            self.VC?.codeSummaryTableView.reloadData()
                            self.VC?.stopLoading()
                        }
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
                
            }
        }
    }
}

