//
//  HR_RedemptionDetailsVM.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/21/22.
//

import UIKit
//import LanguageManager_iOS

class HR_RedemptionDetailsVM:  popUpAlertDelegate {
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    weak var VC: HR_RedemptionCatalogueDetailsVC?
    var requestAPIs = RestAPI_Requests()
    var redeemablePointsBalance = UserDefaults.standard.string(forKey: "OverAllPointBalance") ?? ""
    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var myCartListArray = [CatalogueSaveCartDetailListResponse]()
    var sumOfProductsCount = 0
    var totalCartValue = 0
    var plannerListArray = [ObjCatalogueList2]()
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
                        self.VC?.cartCount.text = "\(result?.totalCartCatalogue ?? 0)"
//                        self.redemptionPlannerList()
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
    func addToCartApi(){
        self.VC?.startLoading()
        let parameters = [
                "ActionType": "1",
                "ActorId": "\(userID)",
                "CatalogueSaveCartDetailListRequest": [
                    [
                        "CatalogueId": "\(self.VC?.selectedCatalogueIds ?? 0)",
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
                            NotificationCenter.default.post(name: .cartCount, object: nil)
                            let alert = UIAlertController(title: "", message: "Added To Cart", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.VC?.present(alert, animated: true, completion: nil)
                            self.cartCountApi()
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
    func addedToPlanner(){
        self.VC?.startLoading()
        let parameters = [
            "ActionType": 0,
              "ActorId": "\(userID)",
              "ObjCatalogueDetails": [
                  "CatalogueId": self.VC?.selectedCatalogueIds ?? 0
              ]
        ] as [String :Any]
        print(parameters)
        self.requestAPIs.addToPlannerApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        if result?.returnValue ?? 0 >= 1{
                            self.redemptionPlannerList()
                            DispatchQueue.main.async{

                               let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                               vc!.delegate = self
                               vc!.titleInfo = ""
                                vc!.descriptionInfo = "Your Products added into Planner List"
                               vc!.modalPresentationStyle = .overCurrentContext
                               vc!.modalTransitionStyle = .crossDissolve
                               self.VC?.present(vc!, animated: true, completion: nil)
                            }
                            
//                            let filterCategory = self.plannerListArray.filter{$0.catalogueId == self.VC?.selectedCatalogueIds}
//
//                                if filterCategory.count > 0{
//                                    self.VC?.addToPlanner.isHidden = true
//                                    self.VC?.addToCart.isHidden = true
//                                    self.VC?.addedToCart.isHidden = true
//                                    self.VC?.addedToPlanner.isHidden = false
//                                   }else{
//                                       self.VC?.addToPlanner.isHidden = false
//                                       self.VC?.addToCart.isHidden = true
//                                       self.VC?.addedToCart.isHidden = true
//                                       self.VC?.addedToPlanner.isHidden = true
//                                   }
                            
                            
                        }else{
                            DispatchQueue.main.async{

                               let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                               vc!.delegate = self
                               vc!.titleInfo = ""
                                vc!.descriptionInfo = "You can't add this products into your Planner list"
                               vc!.modalPresentationStyle = .overCurrentContext
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
                        self.sumOfProductsCount = Int(result?.catalogueSaveCartDetailListResponse?[0].sumOfTotalPointsRequired ?? 0)
                        print(self.myCartListArray.count, "RedemptionDetailsCartCount")
                        if self.myCartListArray.count == 0{
                            
                            
                            if self.VC?.productPointss ?? 0 < Int(self.VC?.redeemablePointsBalance ?? "") ?? 0 {

                                self.VC?.addToPlanner.isHidden = true
                                self.VC?.addedToPlanner.isHidden = true
                                self.VC?.addToCart.isHidden = false
                                self.VC?.addedToCart.isHidden = true
                            }else{
                                self.VC?.addToPlanner.isHidden = false
                                self.VC?.addedToPlanner.isHidden = true
                                self.VC?.addToCart.isHidden = true
                                self.VC?.addedToCart.isHidden = true
                            }
                        }else{
                            
//                            for data in self.myCartListArray{
//                                self.totalCartValue = data.sumOfTotalPointsRequired ?? 0
//                                print(self.totalCartValue, "TotalValue")
                                let filterCategory = self.myCartListArray.filter { $0.catalogueId == self.VC?.selectedCatalogueIds}
                                print(filterCategory.count)
                                if filterCategory.count > 0 {
                                    
                                    self.VC?.addedPopUpView.isHidden = true
                                    self.VC?.addToCart.isHidden = true
                                    self.VC?.addedToCart.isHidden = false
                                    self.VC?.addedToPlanner.isHidden = true
                                    self.VC?.addToPlanner.isHidden = true
                                    
                                    
                                }else{
                                    if Int(self.VC!.productPointss) <= Int(self.VC!.redeemablePointsBalance) ?? 0 {
                                        self.VC?.addedPopUpView.isHidden = true
                                        self.VC?.addToCart.isHidden = false
                                        self.VC?.addedToCart.isHidden = true
                                        self.VC?.addedToPlanner.isHidden = true
                                        self.VC?.addToPlanner.isHidden = true
                                    }else{
                                        self.VC?.addedPopUpView.isHidden = true
                                        self.VC?.addToCart.isHidden = true
                                        self.VC?.addedToCart.isHidden = true
                                        self.VC?.addedToPlanner.isHidden = true
                                        self.VC?.addToPlanner.isHidden = false
                                        
//                                        self.redemptionPlannerList()
                                    }
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
                        if self.plannerListArray.count == 0{
                            if self.VC?.productPointss ?? 0 < Int(self.VC?.redeemablePointsBalance ?? "") ?? 0 {

                                self.VC?.addToPlanner.isHidden = true
                                self.VC?.addedToPlanner.isHidden = true
                                self.VC?.addToCart.isHidden = false
                                self.VC?.addedToCart.isHidden = true
                            }else{
                                self.VC?.addToPlanner.isHidden = false
                                self.VC?.addedToPlanner.isHidden = true
                                self.VC?.addToCart.isHidden = true
                                self.VC?.addedToCart.isHidden = true
                            }

                        }else{
                            
                            let filterCategory = self.plannerListArray.filter{$0.catalogueId == self.VC?.selectedCatalogueIds}
                            print(self.VC?.selectedCatalogueIds)
                            print(filterCategory.count)
                            if filterCategory.count > 0 {
                                self.VC?.addToPlanner.isHidden = true
                                self.VC?.addToCart.isHidden = true
                                self.VC?.addedToCart.isHidden = true
                                self.VC?.addedToPlanner.isHidden = false
                            }else{
                                
                            if Int(self.VC!.productPointss) <= Int(self.VC!.redeemablePointsBalance) ?? 0 {
                                    
                                    let filterCategory = self.myCartListArray.filter { $0.catalogueId == self.VC?.selectedCatalogueIds}
                                    print(filterCategory.count)
                                    if filterCategory.count > 0 {
                                        
                                        self.VC?.addedPopUpView.isHidden = true
                                        self.VC?.addToCart.isHidden = true
                                        self.VC?.addedToCart.isHidden = false
                                        self.VC?.addedToPlanner.isHidden = true
                                        self.VC?.addToPlanner.isHidden = true
                                        
                                        
                                    }else{
                                        self.VC?.addedPopUpView.isHidden = true
                                        self.VC?.addToCart.isHidden = false
                                        self.VC?.addedToCart.isHidden = true
                                        self.VC?.addedToPlanner.isHidden = true
                                        self.VC?.addToPlanner.isHidden = true
                                    }
                                }else{
                                    self.VC?.addedPopUpView.isHidden = true
                                    self.VC?.addToCart.isHidden = true
                                    self.VC?.addedToCart.isHidden = true
                                    self.VC?.addedToPlanner.isHidden = true
                                    self.VC?.addToPlanner.isHidden = false
                                }
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
   }
