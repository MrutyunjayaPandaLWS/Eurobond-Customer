//
//  QS_BankTransfer_VM.swift
//  Quba Safalta
//
//  Created by Arokia-M3 on 11/03/21.
//

import UIKit
import LanguageManager_iOS


class QS_BankTransfer_VM{
    
    weak var VC:QS_BankTransfer_VC?
    var requestAPIs = RestAPI_Requests()
    
    func bankDetailsAPI(actorID:String){
        self.VC?.startLoading()
        print(Int(self.VC!.redbal)!)
        let parametersJSON = [
            "ActionType":251,
            "ActorId":"\(actorID)"
        ] as [String : Any]
        print(parametersJSON)
        self.requestAPIs.bankDetails_Post_API(parameters: parametersJSON) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result?.lstCustBankDetailsApproval?.count ?? -1)
                        if result?.lstCustBankDetailsApproval?.count != 0{
                            if Int(self.VC!.redbal)! < 100{
//                                DispatchQueue.main.async {
//                                    let alertController = UIAlertController(title: "", message: "\("Point_balance_&_current_point_balance_is".localiz()) \(self.VC?.redbal ?? "0")", preferredStyle: .alert)
//                                    let okAction = UIAlertAction(title: "OK".localiz(), style: UIAlertAction.Style.default) {
//                                        UIAlertAction in
//                                        self.VC!.navigationController?.popViewController(animated: true)
//                                    }
//                                    alertController.addAction(okAction)
//                                    self.VC!.present(alertController, animated: true, completion: nil)
//                                }
                                
                                self.VC!.accountHoldername.text = result?.lstCustBankDetailsApproval?[0].acountHolderName ?? ""
                                self.VC!.accountNumber.text = result?.lstCustBankDetailsApproval?[0].accountNumber ?? ""
                                self.VC!.bankname.text = result?.lstCustBankDetailsApproval?[0].bankName ?? ""
                                self.VC!.ifscCode.text = result?.lstCustBankDetailsApproval?[0].ifscCode ?? ""
                                
                            }else if result?.lstCustBankDetailsApproval?[0].accountStatusID ?? 0 == 1{
                                self.VC!.accountHoldername.text = result?.lstCustBankDetailsApproval?[0].acountHolderName ?? ""
                                self.VC!.accountNumber.text = result?.lstCustBankDetailsApproval?[0].accountNumber ?? ""
                                self.VC!.bankname.text = result?.lstCustBankDetailsApproval?[0].bankName ?? ""
                                self.VC!.ifscCode.text = result?.lstCustBankDetailsApproval?[0].ifscCode ?? ""
                            }else{
                                DispatchQueue.main.async {
//                                    self.VC?.rejectedLbl.textColor = .black
//                                    self.VC?.rejectedLbl.textAlignment = .center
//                                    self.VC?.rejectedLbl.text = "Your_Bank_Account_is_not_verified".localiz()
//                                    self.VC?.rejectedView.isHidden = false
                                    
                                    self.VC?.myProfileApi(UserID: self.VC?.userID ?? "")
                                }
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.VC?.rejectedLbl.textColor = .black
                                self.VC?.rejectedLbl.textAlignment = .center
                                self.VC?.rejectedLbl.text = "Bank details not submitted. Please submit bank details".localiz()
                                self.VC?.rejectedView.isHidden = false
                            }
                        }
                    }
                }else{
                    print("NO RESPONSE")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_GOODPACK \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
                
            }
        }
    }
    
    func bankSubmitAPI(actorID:String,NoOfPointsDebit:String){
        self.VC?.startLoading()
        let parametersJSON = [
            "ActionType":"4",
            "ActorId":"\(actorID)",
            "CustomerUserID" : "\(actorID)",
            "ObjCatalogueDetails": [
                "RedemptionTypeId":"5",
                "CatalogueId": 58,
                "NoOfPointsDebit":"\(NoOfPointsDebit)",
            "DomainName": "EuroBond"
            ],
            "SourceMode":"5",
            "TransferMode":"2"
        ] as [String : Any]
        print(parametersJSON)
        self.requestAPIs.banksubmit_Post_API(parameters: parametersJSON) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        if result?.returnMessage ?? "RR-0-0" != nil && result?.returnMessage ?? "RR-0-0" != ""{
                            let splittedArray = result?.returnMessage?.split(separator: "-")
                            print(splittedArray,"skjsndd")
                            print(result?.returnMessage,"djhbdfkd")
                            if splittedArray!.count > 1{
                                if Int((splittedArray?[1])!)! > 0{
                                    DispatchQueue.main.async {
                                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_IOS_SuccessPoP_VC") as? EBC_IOS_SuccessPoP_VC
                                        vc?.isComeFrom = "BankSuccess"
                                        vc!.modalPresentationStyle = .overCurrentContext
                                        vc!.modalTransitionStyle = .crossDissolve
                                        self.VC?.present(vc!, animated: true, completion: nil)
                                    }
                                }else if Int((splittedArray?[1])!)! == 0000{
//                                    DispatchQueue.main.async {
//                                        let alertController = UIAlertController(title: "Oops".localiz(), message: "Bank Transfer limit Exceeded".localiz(), preferredStyle: .alert)
//                                        let okAction = UIAlertAction(title: "OK".localiz(), style: UIAlertAction.Style.default) {
//                                            UIAlertAction in
//                                            self.VC!.navigationController?.popViewController(animated: true)
//                                        }
//                                        alertController.addAction(okAction)
//                                        // Present the controller
//                                        self.VC!.present(alertController, animated: true, completion: nil)
//                                    }
                                    
                                    self.VC?.rejectedLbl.textColor = .black
                                    self.VC?.rejectedLbl.textAlignment = .center
                                    self.VC?.rejectedLbl.text = "Bank Transfer limit Exceeded".localiz()
                                    self.VC?.popUpImage.image = UIImage(named: "Icons")
                                    self.VC?.heightOfImage.constant = 100
                                    self.VC?.widthOfImage.constant = 100
                                    self.VC?.rejectedView.isHidden = false
                                    self.VC?.bankDetialsOUTBtn.isHidden = true
                                    self.VC?.popUpOkBtn.isHidden = false
                                    self.VC?.rejectedView.backgroundColor = UIColor(white: 0, alpha: 0.30)
                                    self.VC?.rejectedLbl.font = UIFont.systemFont(ofSize: 20.0)
                                   
                                }
                            }else if Int((splittedArray?[1])!)! == 0{
                                DispatchQueue.main.async {
                                    let alertController = UIAlertController(title: "Oops".localiz(), message: "Insufficient points balance".localiz(), preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "OK".localiz(), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        self.VC!.navigationController?.popViewController(animated: true)
                                    }
                                    alertController.addAction(okAction)
                                    // Present the controller
                                    self.VC!.present(alertController, animated: true, completion: nil)
                                }
                            }else if Int((splittedArray?[1])!)! == 00{
                                DispatchQueue.main.async {
                                    let alertController = UIAlertController(title: "Oops".localiz(), message: "member is deActivated".localiz(), preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "OK".localiz(), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        self.VC!.navigationController?.popViewController(animated: true)
                                    }
                                    alertController.addAction(okAction)
                                    // Present the controller
                                    self.VC!.present(alertController, animated: true, completion: nil)
                                }
                            }else if Int((splittedArray?[1])!)! == 000{
                                DispatchQueue.main.async {
                                    let alertController = UIAlertController(title: "Oops".localiz(), message: "Unfortunately your redemption is failed.Points reducted will be reassigned to you in few working days".localiz(), preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "OK".localiz(), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        self.VC!.navigationController?.popViewController(animated: true)
                                    }
                                    alertController.addAction(okAction)
                                    // Present the controller
                                    self.VC!.present(alertController, animated: true, completion: nil)
                                }
                            }else if Int((splittedArray?[1])!)! == 0000{
                                DispatchQueue.main.async {
                                    let alertController = UIAlertController(title: "Oops".localiz(), message: "Bank Transfer limit Exceeded".localiz(), preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "OK".localiz(), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        self.VC!.navigationController?.popViewController(animated: true)
                                    }
                                    alertController.addAction(okAction)
                                    // Present the controller
                                    self.VC!.present(alertController, animated: true, completion: nil)
                                }
                            }else{
                                DispatchQueue.main.async {
                                    let alertController = UIAlertController(title: "Oops".localiz(), message: "Points transfer failed. Please try after sometime".localiz(), preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "OK".localiz(), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        self.VC!.navigationController?.popViewController(animated: true)
                                        
                                    }
                                    alertController.addAction(okAction)
                                    // Present the controller
                                    self.VC!.present(alertController, animated: true, completion: nil)
                                }}
                        }else{
                            DispatchQueue.main.async {
                                let alertController = UIAlertController(title: "Oops".localiz(), message: "Points transfer failed. Please try after sometime".localiz(), preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "OK".localiz(), style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    self.VC!.navigationController?.popViewController(animated: true)
                                }
                                alertController.addAction(okAction)
                                // Present the controller
                                self.VC!.present(alertController, animated: true, completion: nil)
                            }}
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_GOODPACK \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
                
            }
        }
    }
    
    
    
    
    
    
    func myProfileListApi2(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.myProfileListApi(parameters: parameter) { (result, error) in
            
            if error == nil{
                if result != nil{
                    
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        if result?.lstCustomerJson?.count != 0 {
                            
                            if result?.lstCustomerJson?[0].verifiedStatus == nil{
                                if self.VC!.accountHoldername.text == "" && self.VC!.accountNumber.text == "" && self.VC!.ifscCode.text == "" {
                                    self.VC?.rejectedLbl.textColor = .black
                                    self.VC?.rejectedLbl.textAlignment = .center
                                    self.VC?.rejectedLbl.text = "Bank details not submitted. Please submit bank details".localiz()
                                    self.VC?.rejectedView.isHidden = false
                                }else{
                                    if result?.lstCustomerJson?[0].bankAccountVerifiedStatus == 2 {
                                        self.VC?.rejectedLbl.textColor = .black
                                        self.VC?.rejectedLbl.textAlignment = .center
                                        self.VC?.rejectedLbl.text = "Your verification of your bank account is pending_Please contact your administator".localiz()
                                        self.VC?.rejectedView.isHidden = false
                                        
                                    }else if result?.lstCustomerJson?[0].bankAccountVerifiedStatus == 0{
                                        self.VC?.rejectedLbl.textColor = .black
                                        self.VC?.rejectedLbl.textAlignment = .center
                                        self.VC?.rejectedLbl.text = "Your_Bank_Account_is_not_verified".localiz()
                                        self.VC?.rejectedView.isHidden = false
                                        
                                    }
                                }
                            }
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result, "Result")
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    print(error, "Error")
                }
            }
        }
    }
}
