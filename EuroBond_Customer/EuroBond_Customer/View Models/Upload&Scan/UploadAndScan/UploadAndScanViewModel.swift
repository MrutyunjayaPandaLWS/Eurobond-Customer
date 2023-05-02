//
//  UploadAndScanViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class UploadAndScanViewModel{
    
    weak var VC: ScanOrUpload_VC?
    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var requestAPIs = RestAPI_Requests()
    var savedCodeListArray = [QrCodeSaveResponseList]()
    func submitCodesApi(parameters: JSON){
        self.VC?.startLoading()
        self.VC?.sendScannedCodes.removeAll()
        self.savedCodeListArray.removeAll()
        self.requestAPIs.submitCodesApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        
                        self.VC?.isScanned = false
                        self.VC?.session.stopRunning()
                        self.VC?.stopLoading()
                        self.savedCodeListArray = result?.qrCodeSaveResponseList ?? []
                        print(self.savedCodeListArray.count, "Saved Codes Count")
                        print(self.VC?.uploadedCodes.count)
                        
                        for codes in self.savedCodeListArray {
                            print("Codes Status", codes.codeStatus ?? 0)
                            print(codes.qrCode ?? "","dhgfiu")
                            if codes.qrCode != ""{
                                let type2Array = self.VC?.uploadedCodes.filter { $0.code == codes.qrCode}
                                print(type2Array!.count)
                                if type2Array!.count == 0{
                                    let qRCodeDBTable = UploadedCodes(context: persistanceservice.context)
                                    qRCodeDBTable.code = codes.qrCode
                                    qRCodeDBTable.latitude = codes.latitude
                                    qRCodeDBTable.langitude = codes.longitude
                                    qRCodeDBTable.codeStatus = String(codes.codeStatus ?? 0)
                                    let date = Date()
                                    let formatter = DateFormatter()
                                    formatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
                                    let resultdate = formatter.string(from: date)
                                    qRCodeDBTable.date = resultdate
                                    persistanceservice.saveContext()
                                    let qRCodeDBTable1 = SendUploadedCodes(context: persistanceservice.context)
                                    qRCodeDBTable1.code = codes.qrCode
                                    persistanceservice.saveContext()
                                    
                                }else{
                                    let index =  self.VC?.uploadedCodes.firstIndex(of: type2Array![0])
                                    let productObj = self.VC?.uploadedCodes[index!]
                                    persistanceservice.context.delete(productObj!)
                                    
                                    persistanceservice.saveContext()
                                    
                                    let qRCodeDBTable = UploadedCodes(context: persistanceservice.context)
                                    qRCodeDBTable.code = codes.qrCode
                                    qRCodeDBTable.latitude = codes.latitude
                                    qRCodeDBTable.langitude = codes.longitude
                                    qRCodeDBTable.codeStatus = String(codes.codeStatus ?? 0)
                                    let date = Date()
                                    let formatter = DateFormatter()
                                    formatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
                                    let resultdate = formatter.string(from: date)
                                    qRCodeDBTable.date = resultdate
                                    persistanceservice.saveContext()
                                    let qRCodeDBTable1 = SendUploadedCodes(context: persistanceservice.context)
                                    qRCodeDBTable1.code = codes.qrCode
                                    persistanceservice.saveContext()
                                }
                                
                            }
                        }
                       
                       
                        
                        if self.savedCodeListArray.count != 0{
                            self.VC?.dismiss(animated: true){
                                self.VC?.clearTable()
                                self.VC?.fetchDetails()
                                self.VC?.dismiss(animated: true){
                                    
                                    NotificationCenter.default.post(name: .optionView, object: nil)
                                
                                }
                               
                            }
                           
                            
                        }else {
                            self.VC?.dismiss(animated: true){
                                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                    let alertController = UIAlertController(title: "", message: "QR Code Submission Failed", preferredStyle: .alert)
                                    
                                    // Create the actions
                                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        self.VC?.clearTable()
                                        self.VC?.codeLIST.removeAll()
                            
                                    }
                                    
                                    // Add the actions
                                    alertController.addAction(okAction)
                                    
                                    // Present the controller
                                    self.VC?.present(alertController, animated: true, completion: nil)
                                    
                                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                    let alertController = UIAlertController(title: "", message: "क्यूआर कोड सबमिशन विफल", preferredStyle: .alert)
                                    
                                    // Create the actions
                                    let okAction = UIAlertAction(title: "ठीक है", style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        self.VC?.clearTable()
                                        self.VC?.codeLIST.removeAll()
                            
                                    }
                                    
                                    // Add the actions
                                    alertController.addAction(okAction)
                                    
                                    // Present the controller
                                    self.VC?.present(alertController, animated: true, completion: nil)
                                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                    let alertController = UIAlertController(title: "", message: "QR কোড জমা দেওয়া ব্যর্থ হয়েছে৷", preferredStyle: .alert)
                                    
                                    // Create the actions
                                    let okAction = UIAlertAction(title: "ওকে", style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        self.VC?.clearTable()
                                        self.VC?.codeLIST.removeAll()
                            
                                    }
                                    
                                    // Add the actions
                                    alertController.addAction(okAction)
                                    
                                    // Present the controller
                                    self.VC?.present(alertController, animated: true, completion: nil)
                                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                                    let alertController = UIAlertController(title: "", message: "QR కోడ్ సమర్పణ విఫలమైంది", preferredStyle: .alert)
                                    
                                    // Create the actions
                                    let okAction = UIAlertAction(title: "అలాగే", style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        self.VC?.clearTable()
                                        self.VC?.codeLIST.removeAll()
                            
                                    }
                                    
                                    // Add the actions
                                    alertController.addAction(okAction)
                                    
                                    // Present the controller
                                    self.VC?.present(alertController, animated: true, completion: nil)
                                }else{
                                    let alertController = UIAlertController(title: "", message: "QR Code Submission Failed", preferredStyle: .alert)
                                    
                                    // Create the actions
                                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        self.VC?.clearTable()
                                        self.VC?.codeLIST.removeAll()
                                        self.VC?.navigationController?.popToRootViewController(animated: true)
                            
                                    }
                                    
                                    // Add the actions
                                    alertController.addAction(okAction)
                                    
                                    // Present the controller
                                    self.VC?.present(alertController, animated: true, completion: nil)
                                    
                                }
                               
                            }
                           
                        }
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
