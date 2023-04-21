//
//  HR_MyRedemptionListVM.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/24/22.
//

import UIKit
class HR_MyRedemptionListVM:  popUpAlertDelegate {
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    weak var VC: EBC_MyRedemptionVC?
    var requestAPIs = RestAPI_Requests()
    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var myredemptionArray = [ObjCatalogueRedemReqList]()
    var parameters: JSON?
    
    func cartCountApi(){
        self.VC?.startLoading()
        let parameters = [
            "ActionType":"1",
            "LoyaltyID":"\(loyaltyId)"
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.cartCountApi(parameters: parameters) { (result, error) in
            if error == nil{
                self.VC?.stopLoading()
                if result != nil{
                    DispatchQueue.main.async{
                      //  self.VC?.cartCount.text = "\(result?.totalCartCatalogue ?? 0)"
                        
                        }
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                    }
                }else{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async{
                    self.VC?.stopLoading()
                }
            }
            //self.VC?.stopLoading()
        }
    }

    func getRedemptionListApi(customerId: String){
        self.VC?.startLoading()
        print(self.VC?.behaviourId ?? 0, "Behaviour")
        
        print(self.VC?.fromDate.currentTitle ?? "")
        if self.VC?.behaviourId == 0 && self.VC?.fromDate.currentTitle == "From Date" && self.VC?.toDate.currentTitle == "To Date"{
            self.parameters = [
                "ActionType": "52",
                "ActorId": customerId,
                "ObjCatalogueDetails": [
                    "SelectedStatus": "-1"
                ]
            ] as [String : Any]
            print(self.parameters!)
        }else if self.VC?.behaviourId != 0 && self.VC?.fromDate.currentTitle == "From Date" && self.VC?.toDate.currentTitle == "To Date"{
            self.parameters = [
                "ActionType": "52",
                "ActorId": customerId,
                "ObjCatalogueDetails": [
                    "SelectedStatus": -1,
                    "RedemptionTypeId": self.VC?.behaviourId ?? 0
                ]
            ] as [String : Any]
            print(self.parameters!)

        }else{
            print(self.VC?.behaviourId, "Behaviour ID")
            print(self.VC?.selectedFromDate ?? "")
            print(self.VC?.selectedToDate ?? "")
            self.parameters = [
                "ActionType": "52",
                "ActorId": customerId,
                "ObjCatalogueDetails": [
                    "JFromDate":"\(self.VC?.selectedFromDate ?? "")",
                    "JToDate":"\(self.VC?.selectedToDate ?? "")",
                    "SelectedStatus": -1,
                    "RedemptionTypeId": self.VC?.behaviourId ?? 0
                ]

            ] as [String: Any]
            print(self.parameters!)
        }
        print(self.parameters!)
        self.requestAPIs.myRedemptionListApi(parameters: self.parameters!) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.myredemptionArray = result?.objCatalogueRedemReqList ?? []
                        print(self.myredemptionArray.count, "My Redemption Count")
                        if self.myredemptionArray.count != 0 {
                            self.VC?.noDataFoundLbl.isHidden = true
                            self.VC?.myRedemptionTV.isHidden = false
                            self.VC?.myRedemptionTV.reloadData()
                        }else{
                            self.VC?.noDataFoundLbl.isHidden = false
                            self.VC?.myRedemptionTV.isHidden = true
                        }
                        self.VC?.stopLoading()
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
