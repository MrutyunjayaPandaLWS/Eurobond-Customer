//
//  RedemptionOTPVM.swift
//  CenturyPly_JSON
//
//  Created by ADMIN on 19/04/2022.
//

import UIKit


class RedemptionOTPVM{

    weak var VC:EBC_RedemptionSubmissionVC?
    var requestAPIs = RestAPI_Requests()

    var myCartListArray = [CatalogueSaveCartDetailListResponse]()
    
    func myCartList(parameters: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
            
        }
        self.requestAPIs.myCartListApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        self.myCartListArray = result?.catalogueSaveCartDetailListResponse ?? []
                        print(self.myCartListArray.count)
                        if self.myCartListArray.count != 0 {
                            DispatchQueue.main.async {
                                if self.myCartListArray.count != 0{
                                    
                                    self.VC!.newproductArray.removeAll()
                                    self.VC!.sendSMArray.removeAll()
                                    for item in self.myCartListArray {
                                        let singleImageDict:[String:Any] = [
                                            "CatalogueId": item.catalogueId ?? 0,
                                            "DeliveryType": "In Store",
                                            "HasPartialPayment": false,
                                            "NoOfPointsDebit": "\(Double(item.sumOfTotalPointsRequired ?? 0.0))",
                                            "NoOfQuantity": item.noOfQuantity ?? 0,
                                            "PointsRequired": "\(Double(item.pointsRequired ?? 0))",
                                            "ProductCode": "\(item.productCode ?? "")",
                                            "ProductImage": "\(item.productImage ?? "")",
                                            "ProductName": "\(item.productName ?? "")",
                                            "RedemptionDate": "\(item.redemptionDate ?? "")",
                                            "RedemptionId": item.redemptionId ?? 0,
                                            "RedemptionTypeId": 1,
                                            "Status": item.status ?? 0,
                                            "CatogoryId": item.categoryID ?? 0,
                                            "CustomerCartId": item.customerCartId ?? 0,
                                            "TermsCondition": "\(item.termsCondition ?? "")",
                                            "TotalCash": item.totalCash ?? 0,
                                            "VendorId": item.vendorId ?? 0
                                        ]
                                        print(singleImageDict)
                                        self.VC!.newproductArray.append(singleImageDict)
                                        
                                        let smsArray:[String:Any] = [
                                            "CatalogueId": item.catalogueId ?? 0,
                                            "DeliveryType": "\(item.deliveryType ?? "")",
                                            "HasPartialPayment": false,
                                            "NoOfPointsDebit": "\(Double(item.sumOfTotalPointsRequired ?? 0))",
                                            "NoOfQuantity": item.noOfQuantity ?? 0,
                                            "PointsRequired": "\(Double(item.pointsRequired ?? 0))",
                                            "ProductCode": "\(item.productCode ?? "")",
                                            "ProductImage": "\(item.productImage ?? "")",
                                            "ProductName": "\(item.productName ?? "")",
                                            "RedemptionDate": "\(item.redemptionDate ?? "")",
                                            "RedemptionId": item.redemptionId ?? 0,
                                            "RedemptionRefno": "\(self.VC!.redemptionRefId)",
                                            "RedemptionTypeId": self.VC!.redemptionTypeId,
                                            "Status": item.status ?? 0,
                                            "TermsCondition": "\(item.termsCondition ?? "")",
                                            "TotalCash": item.totalCash ?? 0,
                                            "VendorId": item.vendorId ?? 0
                                            ]
                                        print(smsArray, "SMS Array")
                                        print(self.VC!.redemptionRefId, "Refer ID")
                                        self.VC!.sendSMArray.append(smsArray)
                                        
                                    }
                                    
                                    
                            }
                                
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.VC!.stopLoading()
                            }
                        }
                        
                    }
                     
                    }else {
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
    
    func redemptionOTPValue(parameters: JSON, completion: @escaping (RedemptionOTPModels?) -> ()){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.redemptionOTP(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                       
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
    func sendSMSApi(parameters: JSON, completion: @escaping (SendSMSModel?) -> ()){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.sendSMSApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                        
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
    func userStatus(parameters: JSON, completion: @escaping (UserStatusModels?) -> ()){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.userIsActive(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                        
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
    func redemptionSubmission(parameters: JSON, completion: @escaping (RedemptionSubmission?) -> ()){
        DispatchQueue.main.async {
            self.VC?.startLoading()
            self.requestAPIs.redemptionSubmission(parameters: parameters) { (result, error) in
                if error == nil{
                    if result != nil {
                        DispatchQueue.main.async {
                            completion(result)
                            
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
    
    func sendSUCESSApi(parameters: JSON, completion: @escaping (SendSuccessModels?) -> ()){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.sendSuccessMessage(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                        
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
    
    func removeDreamGift(parameters: JSON, completion: @escaping (RemoveGiftModels?) -> ()){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.removeDreamGifts(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)

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
