//
//  LINC_OrderCart_VM.swift
//  LINC
//
//  Created by Arokia-M3 on 14/07/21.
//

//import UIKit

//class LINC_OrderCart_VM{
////    weak var VC:LINC_OrderCart_VC?
//    weak var VCs:LINC_AlertPopUp_Raffles_VC?
//    weak var VC_Smart:LINC_SmartBasket_VC?
//    weak var VC_DashBoarRetailer: LINC_DashboardRetailer_VC?
//    var requestAPIs = RestAPI_Requests()
//    var orderCartArray = [LstCustomerCartORDER]()
//    let loyaltyID = UserDefaults.standard.string(forKey: "UD_LoyaltyId") ?? ""
//    var totalQunatity = 0
    
//    func orderCartlisting(parameters:JSON){
////        LoadingIndicator.sharedInstance.showIndicator()
//        self.requestAPIs.orderCart_Post_API(parameters: parameters) { (result, error) in
//            if error == nil {
//                if result != nil{
//                    DispatchQueue.main.async {
//                        let orderList = result
//                        self.orderCartArray = (orderList?.lstCustomerCart ?? [])
////                         self.orderCartArray = result?.lstCustomerCart ?? []
//                        for totalQty in self.orderCartArray{
//                            self.totalQunatity = self.totalQunatity + totalQty.quantity!
//                            print(self.totalQunatity, "totalValues is")
//                        }
//                        self.VC?.qtyLabel.text = "\(self.totalQunatity)"
//                        self.totalQunatity = 0
//                        self.VC?.cartTableView.reloadData()
//                        UserDefaults.standard.setValue("\(self.orderCartArray.count)", forKey: "CartCount")
//                        if self.orderCartArray.count != 0{
//
//                        self.VC?.totalOrdervalue.text = "\(self.orderCartArray[0].landingTotalPrice ?? 0)"
//                            self.VC?.totalValue = Int(self.orderCartArray[0].landingTotalPrice ?? 0.0)
//                            if self.VC!.totalValue >= 300{
//                                self.VC?.submitOrderButton.isEnabled = true
//                                self.VC?.submitOrderView.backgroundColor = UIColor.init(red: 0/255, green: 84/255, blue: 166/255, alpha: 1)
//                            }else{
//                                self.VC?.submitOrderButton.isEnabled = false
//                                self.VC?.submitOrderView.backgroundColor = .lightGray
//
//                            }
//                                self.VC?.submitOrderView.isHidden = false
//                                self.VC?.noteLabel.isHidden = false
//                                self.VC?.quantityValueView.isHidden = false
//                                self.VC?.cartTableView.isHidden = false
//                            self.VC?.noteInfo.isHidden = false
//                            self.VC?.emptyCartView.isHidden = true
//                            self.VC?.cartTableView.reloadData()
//                        }
//                        if self.orderCartArray.count == 0{
//                            print("Your cart is EMPTY")
//                            self.VC?.submitOrderView.isHidden = true
//                            self.VC?.noteLabel.isHidden = true
//                            self.VC?.quantityValueView.isHidden = true
//                            self.VC?.cartTableView.isHidden = true
//                            self.VC?.emptyCartView.isHidden = false
//                            self.VC?.noteInfo.isHidden = true
//
//                            }else{
//                            self.VC?.cartTableView.reloadData()
//                        }
////                        LoadingIndicator.sharedInstance.hideIndicator()
//                    }
//                }else{
//                    print("Response not binding")
////                    LoadingIndicator.sharedInstance.hideIndicator()
//                }
//            }else{
//                print("ERROR_ \(error)")
//                DispatchQueue.main.async {
////                    LoadingIndicator.sharedInstance.hideIndicator()
//                }
//
//            }
//
//        }
//    }
    
//    func orderupdate(parameters:JSON){
////        LoadingIndicator.sharedInstance.showIndicator()
//        self.requestAPIs.updatecartDetails_Post_API(parameters: parameters) { (result, error) in
//            if error == nil {
//                if result != nil{
//                    DispatchQueue.main.async {
////                        LoadingIndicator.sharedInstance.hideIndicator()
//                        print(result?.returnMessage ?? "-1")
//                        NotificationCenter.default.post(name: .removeProduct, object: nil)
//                        self.VC?.cartTableView.reloadData()
//                    }
//                }else{
//                    print("Response not binding")
////                    LoadingIndicator.sharedInstance.hideIndicator()
//                }
//            }else{
//                print("ERROR_ \(error)")
//                DispatchQueue.main.async {
////                    LoadingIndicator.sharedInstance.hideIndicator()
//                }
//
//            }
//
//        }
//    }
    
    
//    func orderupdate2(parameters:JSON){
////        LoadingIndicator.sharedInstance.showIndicator()
//        self.requestAPIs.updatecartDetails_Post_API(parameters: parameters) { (result, error) in
//            if error == nil {
//                if result != nil{
//                    DispatchQueue.main.async {
//                        print(result?.returnMessage ?? "-1")
//                        let parameterJSON = [
//                            "ActionType":"6",
//                            "LoyaltyId":"\(self.VC?.loyaltyID ?? "")"
//                        ] as? [String:Any]
//                        print(parameterJSON, "OrderCart Listing")
//                        self.orderCartlisting(parameters: parameterJSON!)
////                        LoadingIndicator.sharedInstance.hideIndicator()
//                    }
//                }else{
//                    print("Response not binding")
////                    LoadingIndicator.sharedInstance.hideIndicator()
//                }
//            }else{
//                print("ERROR_ \(error)")
//                DispatchQueue.main.async {
////                    LoadingIndicator.sharedInstance.hideIndicator()
//                }
//
//            }
//
//        }
//    }
    
//    func orderRemove(parameters:JSON){
////        LoadingIndicator.sharedInstance.showIndicator()
//        self.requestAPIs.removecartDetails_Post_API(parameters: parameters) { (result, error) in
//            if error == nil {
//                if result != nil{
//                    DispatchQueue.main.async {
//                        NotificationCenter.default.post(name: .removeProduct, object: nil)
//                        self.VC?.cartTableView.reloadData()
////                        LoadingIndicator.sharedInstance.hideIndicator()
//                    }
//                }else{
//                    print("Response not binding")
////                    LoadingIndicator.sharedInstance.hideIndicator()
//                }
//            }else{
//                print("ERROR_ \(error)")
//                DispatchQueue.main.async {
////                    LoadingIndicator.sharedInstance.hideIndicator()
//                }
//                
//            }
//            
//        }
//    }
    
//}
