//
//  HR_MyCartVM.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/22/22.
//

import UIKit

class HR_MyCartVM:  popUpAlertDelegate {
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    weak var VC: HR_MyCartVC?
    var requestAPIs = RestAPI_Requests()
    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var myCartListArray = [CatalogueSaveCartDetailListResponse]()
   var value = 0
    var sumOfProductsCount = 0
    func getMycartList(){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.myCartListArray.removeAll()
        let parameters = [
            "ActionType":"2",
            "LoyaltyID":"\(loyaltyId)"
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.myCartListApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                      self.VC?.stopLoading()
                        self.myCartListArray = result?.catalogueSaveCartDetailListResponse ?? []
                        print(self.myCartListArray.count, "My Cart Count")
                        self.sumOfProductsCount = Int(result?.catalogueSaveCartDetailListResponse?[0].sumOfTotalPointsRequired ?? 0)
                        if self.myCartListArray.count != 0 {
                            self.dashBoardListAPI(userid: Int(self.userID)!)
                            self.VC?.totalPoints.text = "\(self.sumOfProductsCount)"
                            self.VC?.finalPoints = self.sumOfProductsCount
                            self.VC?.checkoutView.isHidden = false
                            self.VC?.noDataFound.isHidden = true
                            self.VC?.myCartTableView.reloadData()
                        }else{
                            self.VC?.myCartTableView.isHidden = true
                            self.VC?.checkoutView.isHidden = true
                            self.VC?.noDataFound.isHidden = false
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
    
    
    
    
    //Increase Product Api
    
    func increaseProductApi(){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        let parameters = [
            
                "ActionType": "3",
                "ActorId": "\(userID)",
                "CustomerCartId": "\(self.VC?.customerCartId ?? 0)",
                "CustomerCartList": [
                    [
                        "CustomerCartId": "\(self.VC?.customerCartId ?? 0)",
                        "Quantity": "\(self.VC?.self.quantity ?? 0)"
                    ]
                ]
                
                
                
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.increaseCartCount(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        if result?.returnMessage == "1"{
                            self.VC?.status = 1
                            self.getMycartList()
                        }else{
                            print("Value Not Added")
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
    
    // Decrease Product Api
    
    
    func removeProduct(){
        let parameters = [
            "ActionType":"4",
            "ActorId":"\(userID)",
            "CustomerCartId":"\(self.VC?.customerCartId ?? 0)"
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.removeProduct(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        if result?.returnMessage == "1"{
                            self.getMycartList()
                            //self.VC?.myCartTableView.reloadData()
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
    
    
    
    func dashBoardListAPI(userid:Int){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
     let parameters = [
        "ActorId": userid
     ] as [String : Any]
      print(parameters)
        self.requestAPIs.dashboard_API(parameters: parameters) { (result, error) in
            if error == nil{
                
                if result != nil{
                DispatchQueue.main.async {
                   
                   let dashboardDetails = result?.objCustomerDashboardList ?? []
                    if dashboardDetails.count != 0 {

//                        UserDefaults.standard.setValue(result?.objCustomerDashboardList?[0].redeemPoints ?? "", forKey: "RedeemablePointBalance")
//                        UserDefaults.standard.synchronize()
                    
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
}
