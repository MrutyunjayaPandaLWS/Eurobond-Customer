//
//  QS_VouchersDetails_VM.swift
//  HR_Johnson
//
//  Created by ADMIN on 10/05/2022.
//

import UIKit
//import LanguageManager_iOS

class QS_VouchersDetails_VM: popUpAlertDelegate{
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    weak var VC:HR_EvoucherProductDetailsVC?
    var requestAPIs = RestAPI_Requests()
    
    func voucherSubmission(ReceiverMobile:String,ActorId:String,CountryID:Int,MerchantId:Int,CatalogueId:Int,DeliveryType:String,pointsrequired:String,ProductCode:String,ProductImage:String,ProductName:String,NoOfQuantity:String,VendorId:Int,VendorName:String,ReceiverEmail:String,ReceiverName:String){
        self.VC?.startLoading()
        let parameterJSON = [
            
                "ActionType": "51",
                "ActorId": ActorId,
                "CountryID": CountryID,
                "MerchantId": MerchantId,
                "ObjCatalogueList": [
                    [
                        "CatalogueId": CatalogueId,
                        "CountryCurrencyCode": "",
                        "DeliveryType": DeliveryType,
                        "HasPartialPayment": false,
                        "NoOfPointsDebit": pointsrequired,
                        "PointsRequired": pointsrequired,
                        "ProductCode": ProductCode,
                        "ProductImage": ProductImage,
                        "ProductName": ProductName,
                        "redemptionid": 1,
                        "redemptiontypeid": 4,
                        "noofquantity": 1,
                        "status": 13,
                        "vendorid": VendorId,
                        "vendorname": VendorName
                    ]
                ],
                "receiveremail": ReceiverEmail,
                "ReceiverName": ReceiverName,
                "ReceiverMobile": ReceiverMobile,
                "SourceMode": "5"
        ] as [String:Any]
        print(parameterJSON)
        
        self.requestAPIs.redeemVoucher(parameters: parameterJSON) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        print(result?.returnMessage ?? "")
                        let message = result?.returnMessage ?? ""
                        
                        if message.count != 0 {
                            let separatedmessage = message.split(separator: "-")
                            if separatedmessage[2] == "0"{
                                let alertController = UIAlertController(title: "Oops", message: "You don’t have sufficient point balance to redeem the voucher", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                       UIAlertAction in
                                    self.VC!.navigationController?.popViewController(animated: true)
                                   }
                                   alertController.addAction(okAction)
                                self.VC!.present(alertController, animated: true, completion: nil)
                            }else if separatedmessage[2] == "00"{
                                let alertController = UIAlertController(title: "Oops", message: "member is deActivated", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                       UIAlertAction in
                                    self.VC!.navigationController?.popViewController(animated: true)
                                   }
                                   alertController.addAction(okAction)
                                self.VC!.present(alertController, animated: true, completion: nil)
                            }else if separatedmessage[2] == "000"{
                                let alertController = UIAlertController(title: "Oops", message: "Unfortunately_your_redemption_has_not_been_completed", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                       UIAlertAction in
                                    self.VC!.navigationController?.popViewController(animated: true)
                                   }
                                   alertController.addAction(okAction)
                                self.VC!.present(alertController, animated: true, completion: nil)
                            }else{
                                DispatchQueue.main.async{
                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                                    vc!.delegate = self
                                    vc!.titleInfo = ""
                                    vc!.isComeFrom = "VoucherSuccess"
                                    vc!.descriptionInfo = "Thank_you_for_redeeming. The_E-voucher_will_sent_email_id_shortly"
                                    vc!.modalPresentationStyle = .overFullScreen
                                    vc!.modalTransitionStyle = .crossDissolve
                                    self.VC?.present(vc!, animated: true, completion: nil)
                                }

                            }
                        }
                        


                        self.VC?.stopLoading()
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
    
}
