//
//  HR_RedemptionOTP_VM.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/25/22.
//

import UIKit
import LanguageManager_iOS
class HR_RedemptionOTP_VM: popUpAlertDelegate {
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    weak var VC: HR_RedemptionOTP_VC?
 
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
    var count = 60
    var timer = Timer()
    var otpData = ""
    var parameters = [String: Any]()
    var userId = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var mobilenumber = UserDefaults.standard.string(forKey: "Mobile") ?? ""
    let emailID = UserDefaults.standard.string(forKey: "CustomerEmail") ?? ""
    let firstname = UserDefaults.standard.string(forKey: "FirstName") ?? ""
    let merchantUserName = UserDefaults.standard.string(forKey: "MerchantEmail") ?? ""
    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var myCartListArray = [CatalogueSaveCartDetailListResponse]()
    var redemptionDate = Date().string(format: "yyyy-MM-dd")
    var redemablePointBalance = UserDefaults.standard.integer(forKey: "PointsBalance")
    var newproductArray: [[String:Any]] = []
    var RRNumber = ""
    var productnames = ""
    
    func OTPAPI(paramters: JSON){
        print(parameters)
        self.VC?.startLoading()
        self.requestAPIs.getRedemptionOTP(parameters: paramters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        print(result?.returnMessage ?? "", "OTP")
                        self.VC?.OTPforVerification = result?.returnMessage ?? ""
                        self.VC?.enterOTPTopspaceConstraint.constant = 10
                        self.VC?.resendOTP.isHidden = true
                        self.VC!.count = 60
                        self.VC!.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
                    }
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                    }
                    
                }else{
                    print("NO RESPONSE")
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_GOODPACK \(error)")
                DispatchQueue.main.async{
                    self.VC?.stopLoading()
                }
            }
            
        }
    }
    @objc func update() {
           if(self.VC!.count > 1){
               self.VC!.count = self.VC!.count - 1
               self.VC!.secondsRemaining.text = "\("Seconds Remaining".localiz()): \(self.VC!.count - 1)"
            
               self.VC!.enterOTPTopspaceConstraint.constant = 10
              // self.VC!.secondsRemaining.isHidden = false
               self.VC!.resendOTP.isHidden = true
           }else{
            self.VC!.secondsRemaining.text = ""
               self.VC!.enterOTPTopspaceConstraint.constant = 30
              // self.VC!.secondsRemaining.isHidden = true
               self.VC!.resendOTP.isHidden = false
               self.VC!.timer.invalidate()
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
                        let yesterday = "\(Calendar.current.date(byAdding: .day, value: 0, to: Date())!)"
                        let today = yesterday.split(separator: " ")
                        let desiredDateFormat = self.VC!.convertDateFormater1("\(today[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
                       print("\(desiredDateFormat)")
                        if self.myCartListArray.count != 0{
                            self.productnames = ""
                            self.newproductArray.removeAll()
                            for item in self.myCartListArray {
                                let singleImageDict:[String:Any] = [
                                    "CatalogueId": item.catalogueId ?? 0,
                                    "DeliveryType": "\(item.deliveryType ?? "")",
                                    "HasPartialPayment": false,
                                    "NoOfPointsDebit": "\(Int(item.pointsRequired!))",
                                    "NoOfQuantity": item.noOfQuantity ?? 0,
                                    "PointsRequired": "\(item.pointsRequired ?? 0)",
                                    "ProductCode": "\(item.productCode ?? "")",
                                    "ProductImage": "\(item.productImage ?? "")",
                                    "ProductName": "\(item.productName ?? "")",
                                    "redemptiondate": "\(desiredDateFormat)",
                                    "redemptionid": item.redemptionId ?? 0,
                                    "redemptiontypeid": 1,
                                    "status": 13,
                                    "catogoryid": item.catogoryId ?? 0,
                                    "customercartid": item.customerCartId ?? 0,
                                    "termscondition": "\(item.termsCondition ?? "")",
                                    "totalcash": item.totalCash ?? 0,
                                    "vendorid": item.vendorId ?? 0
                                ]
                                self.productnames = self.productnames + "," + "\(item.productName ?? "")"
                                self.newproductArray.append(singleImageDict)
                                let smsArray:[String:Any] = [
                                    "CatalogueId": item.catalogueId ?? 0,
                                    "DeliveryType": "In Store",
                                    "HasPartialPayment": false,
                                    "NoOfPointsDebit": "\(item.pointsRequired ?? 0)",
                                    "NoOfQuantity": item.noOfQuantity ?? 0,
                                    "PointsRequired": "\(item.pointsRequired ?? 0)",
                                    "ProductCode": "\(item.productCode ?? "")",
                                    "ProductImage": "\(item.productImage ?? "")",
                                    "ProductName": "\(item.productName ?? "")",
                                    "redemptiondate": "\(desiredDateFormat)",
                                    "redemptionid": item.redemptionId ?? 0,
                                    "RedemptionRefno": "\(self.VC?.redemptionRefId)",
                                    "redemptiontypeid": self.VC?.redemptionTypeId,
                                    "status": 13,
                                    "termscondition": "\(item.termsCondition ?? "")",
                                    "totalcash": item.totalCash ?? 0,
                                    "vendorid": item.vendorId ?? 0
                                    ]
                                print(smsArray, "SMS Array")
                                print(self.VC?.redemptionRefId, "Refer ID")
                               // self.sendSMArray.append(smsArray) item.status ?? 
                                    }
                    }
                        
                        }
                    DispatchQueue.main.async {
                            self.VC?.stopLoading()
                        }
                } else{
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
  
    func submitProductApi(parameters: JSON){
        self.VC?.startLoading()
        print(parameters, "Product Submission")
        self.requestAPIs.productSubmission_Post_API(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        print(result?.returnMessage ?? "", "Redemption Submission")
                        self.RRNumber = result?.returnMessage ?? ""
                        print(result?.returnValue ?? "", "ReturnValue")
                        let message = result?.returnMessage ?? ""
                        print(message)
                        if message.count != 0{
                            let seperateMessage = message.split(separator: "-")
                            print(seperateMessage[1], "Filtered Value")
                            print(seperateMessage[2], "Filtered Value")
                            let x = Int(seperateMessage[1]) ?? 0
                            if x > Int("0")! {
                                print("Success")
                                NotificationCenter.default.post(name: .redemptionSuccess, object: nil)
//                                self.sendSMSToCustomerApi()
                            }else{
                                DispatchQueue.main.async{
                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                                    vc!.delegate = self
                                    vc!.titleInfo = ""
                                    vc!.isComeFrom = "Failed"
                                    vc!.descriptionInfo = "Redemption Failed".localiz()
                                    vc!.modalPresentationStyle = .overFullScreen
                                    vc!.modalTransitionStyle = .crossDissolve
                                    self.VC?.present(vc!, animated: true, completion: nil)
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
    
//    func sendSMSToCustomerApi(){
//        self.VC?.startLoading()
//        let parameters = [
//            "CustomerName": "\(self.VC?.customerName ?? "")",
//            "EmailID": "\(self.VC?.emailID ?? "")",
//            "LoyaltyID": "\(loyaltyId)",
//            "Mobile": "\(self.VC?.mobile ?? "")",
//            "PointBalance": redemablePointBalance,
//            "RedeemedPoint": "\(VC?.redeemedPoints ?? 0)",
//            "ProductName":"\(self.productnames)",
//            "RedemptionRefno":"\(self.RRNumber)"
//        ] as [String: Any]
//        print(parameters)
//        self.requestAPIs.redemptionSMSApi(parameters: parameters) { (result, error) in
//            
//            if error == nil{
//                if result != nil{
//                    DispatchQueue.main.async {
//                        if result?.sendSMSForSuccessfulRedemptionMobileAppResult == true{
//                            print("SMS Sent To Client")
//                        }else{
//                            DispatchQueue.main.async{
//                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
//                                vc!.delegate = self
//                                vc!.titleInfo = ""
//                                vc!.descriptionInfo = "Failed To Sent Message"
//                                vc!.modalPresentationStyle = .overFullScreen
//                                vc!.modalTransitionStyle = .crossDissolve
//                                self.VC?.present(vc!, animated: true, completion: nil)
//                            }
//                        }
//                    }
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                    }
//                }else{
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                    }
//                }
//            }else{
//                DispatchQueue.main.async {
//                    self.VC?.stopLoading()
//                }
//            }
//        }
//    }
 
    
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
