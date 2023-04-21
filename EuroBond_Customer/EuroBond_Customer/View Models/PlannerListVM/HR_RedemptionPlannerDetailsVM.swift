//
//  HR_RedemptionPlannerDetailsVM.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 3/1/22.
//

import UIKit

class HR_RedemptionPlannerDetailsVM: popUpAlertDelegate {
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    weak var VC: HR_RedemptionPlannerDetailsVC?
    var requestAPIs = RestAPI_Requests()
    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var plannerListArray = [ObjCatalogueList2]()
    var myCartListArray = [CatalogueSaveCartDetailListResponse]()
    func productDetailsApi(){
        self.VC?.startLoading()
        let parameters = [
            "ActionType":"6",
            "ActorId":"\(userID)"
        ] as [String : Any]
        print(parameters)
    }
    func getMycartList(){
        self.VC?.startLoading()
        let parameters = [
            "ActionType":"2",
            "LoyaltyID":"\(loyaltyId)"
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.myCartListApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.myCartListArray = result?.catalogueSaveCartDetailListResponse ?? []
                        if self.myCartListArray.count != 0 {
                            self.VC?.cartCount.text = "\(self.myCartListArray.count)"
                            let myCartValues:Int = Int(self.myCartListArray[0].sumOfTotalPointsRequired ?? 0)
                            print(myCartValues, "Totatadgsafasdfs")
                            self.VC?.totalCartValue = myCartValues
                            print(self.VC?.totalCartValue, "MY Cart Values")
                        }else{
                            self.VC?.cartCount.text = "0"
                        }
                    }
                    DispatchQueue.main.async {
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
    func removeRedemptionPlanner1(redemptionPlannerId:Int){
        self.VC?.startLoading()
        let parameters = [
            "ActionType":"17",
            "ActorId":"\(userID)",
            "RedemptionPlannerId": "\(redemptionPlannerId)"
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.removeRedemptionPlannerList(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        let response = result?.returnValue ?? 0
                        print(response, "RemoveProduct")
                        
                    }
                    DispatchQueue.main.async {
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
    
    func removeRedemptionPlanner(){
        self.VC?.startLoading()
        let parameters = [
            "ActionType":"17",
            "ActorId":"\(userID)",
            "RedemptionPlannerId": "\(self.VC?.redemptionPlannerId ?? 0)"
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.removeRedemptionPlannerList(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        let response = result?.returnValue ?? 0
                        print(response, "RemoveProduct")
                        if response == 1{
                            self.redemptionPlannerList()
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.isComeFrom = "Planner"
                                vc!.descriptionInfo = "Product is removed from the List"
                                vc!.modalPresentationStyle = .overFullScreen
                                vc!.modalTransitionStyle = .crossDissolve
                                self.VC?.present(vc!, animated: true, completion: nil)
                            }
                        }else{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.isComeFrom = "Failed"
                                vc!.descriptionInfo = "Redemption Failed"
                                vc!.modalPresentationStyle = .overFullScreen
                                vc!.modalTransitionStyle = .crossDissolve
                                self.VC?.present(vc!, animated: true, completion: nil)
                            }
                        }
                        
                    }
                    DispatchQueue.main.async {
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
    
    func redemptionPlannerList(){
        self.VC?.startLoading()
        let parameters = [
            "ActionType":"6",
            "ActorId":"\(userID)"
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.redemptionPlannerList(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.plannerListArray = result?.objCatalogueList ?? []
                        print(self.plannerListArray.count, "Planner List Count")
                        
                    }
                    DispatchQueue.main.async {
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
    
    func addToCartApi(redemptionPlannerId:Int){
        self.VC?.startLoading()
        let parameters = [
                "ActionType": "1",
                "ActorId": "\(userID)",
                "CatalogueSaveCartDetailListRequest": [
                    [
                        "CatalogueId": "\(self.VC?.selectedCatalogueID ?? 0)",
                        "DeliveryType": "1",
                        "NoOfQuantity": "1"
                    ]
                ],
                "LoyaltyID": "\(loyaltyId)",
                "MerchantId": "1"
        ] as [String :Any]
        print(parameters)
        self.requestAPIs.addToCartApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        print(result?.returnValue ?? "", "ReturnValue")
                        if result?.returnValue == 1{
                            self.cartCountApi()
                            self.getMycartList()
                            self.removeRedemptionPlanner1(redemptionPlannerId: redemptionPlannerId)
                            self.redemptionPlannerList()
                            NotificationCenter.default.post(name: .cartCount, object: nil)
                            let alert = UIAlertController(title: "", message: "Added To Cart", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ (UIAlertAction) in
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_MyCartVC") as! HR_MyCartVC
                                self.VC?.navigationController?.pushViewController(vc, animated: true)
                                
                            }))
                            self.VC?.present(alert, animated: true, completion: nil)
                            return
                        }else{
                            //PopUp Message
                            DispatchQueue.main.async{

                               let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                               vc!.delegate = self
                               vc!.titleInfo = ""
                                vc!.descriptionInfo = "Insufficient Point Balance"
                               vc!.modalPresentationStyle = .overCurrentContext
                               vc!.modalTransitionStyle = .crossDissolve
                               self.VC?.present(vc!, animated: true, completion: nil)
                            }
                        }
                        DispatchQueue.main.async {
                            self.VC?.stopLoading()
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
    func cartCountApi(){
        self.VC?.startLoading()
        let parameters = [
            "ActionType":"1",
            "LoyaltyID":"\(loyaltyId)"
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.cartCountApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async{
//                        self.VC?.cartCount.text = "\(result?.totalCartCatalogue ?? 0)"
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
        }
    }
    
}
