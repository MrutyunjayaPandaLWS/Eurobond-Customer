//
//  EBC_MyEarningsVM.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 14/04/2023.
//

import Foundation
import UIKit
import LanguageManager_iOS
class EBC_MyEarningsVM{
    
    weak var VC:EBC_MyEarningsVC?
    var requestAPIs = RestAPI_Requests()
    var myEarningListArray = [LstRewardTransJsonDetails]()
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var parameters:JSON?
    
    func myEarningListApi(startIndex: Int, fromDate: String, toDate: String){
        DispatchQueue.main.async {
            self.myEarningListArray.removeAll()
            self.VC?.startLoading()
        }        
            let parameters = [
                "ActorId": self.userID,
                "IsActive": "true",
                "MerchantId":"1",
                "StartIndex": startIndex,
                "PageSize": 10,
                "JFromDate":fromDate,
                "JToDate":toDate
            ] as [String: Any]
            print(parameters)
        self.requestAPIs.myEarningListApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        let myEarningListsArray = result?.lstRewardTransJsonDetails ?? []
                        if myEarningListsArray.isEmpty == false || myEarningListsArray.count != 0{
                            self.myEarningListArray += myEarningListsArray
                            self.VC?.noofelements = self.myEarningListArray.count
                            print(self.myEarningListArray.count, "My Earning Count")
                            if self.myEarningListArray.count != 0{
                                self.VC?.myEarningTV.isHidden = false
                                self.VC?.noDataFound.isHidden = true
                                self.VC?.myEarningTV.reloadData()
                            }else{
                                self.VC?.noDataFound.isHidden = false
                                self.VC?.noDataFound.text = "No Data Found".localiz()
                                self.VC?.myEarningTV.isHidden = true
                            }
                        }else{
                            if self.VC!.startIndex > 1{
                                self.VC?.startIndex = 1
                                self.VC?.noofelements = 9
                            }else{
                                self.VC?.myEarningTV.isHidden = true
                                self.VC?.noDataFound.isHidden = false
                                self.VC?.noDataFound.text = "No Data Found".localiz()
                            }

                        }
                        
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }
        }
    }
  
}
