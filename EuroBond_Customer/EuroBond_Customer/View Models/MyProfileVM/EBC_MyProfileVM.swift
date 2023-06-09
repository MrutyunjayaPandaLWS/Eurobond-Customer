//
//  EBC_MyProfileVM.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 17/04/2023.
//

import Foundation
import Kingfisher
import UIKit
import LanguageManager_iOS
class EBC_MyProfileVM{
    
    weak var VC: MyProfileVC?
    weak var VC2: BankDetailsVC?
    var flags: String = ""
    var requestAPIs = RestAPI_Requests()
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    
    func myProfileListApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.myProfileListApi(parameters: parameter) { (result, error) in
            
            if error == nil{
                if result != nil{
                    
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        if result?.lstCustomerJson?.count != 0 {
                            self.VC?.beneficiaryTypeTF.text = result?.lstCustomerJson?[0].customerType ?? ""
                            self.VC?.firstNameTF.text = result?.lstCustomerJson?[0].firstName ?? ""
                            self.VC?.lastNameTF.text = result?.lstCustomerJson?[0].lastName ?? ""
                            self.VC?.mobileNumberTF.text = result?.lstCustomerJson?[0].mobile ?? ""
                            self.VC?.emailTF.text = result?.lstCustomerJson?[0].email ?? ""
                            self.VC?.addressTF.text = result?.lstCustomerJson?[0].address1 ?? ""
                            self.VC?.stateTF.text = result?.lstCustomerJson?[0].stateName ?? ""
                            self.VC?.cityTF.text = result?.lstCustomerJson?[0].cityName ?? ""
                            self.VC?.pinCodeTF.text = result?.lstCustomerJson?[0].zip ?? ""
                            let doB = String(result?.lstCustomerJson?[0].jdob ?? "")
                            let index = doB.firstIndex(of: " ") ?? doB.endIndex
                            let beginning = doB[..<index]
                            print(beginning)
                            self.VC?.dobTF.text = "\(beginning)"
                            self.VC?.stateId = "\(result?.lstCustomerJson?[0].stateId ?? 0)"
                            self.VC?.cityId = "\(result?.lstCustomerJson?[0].cityId ?? 0)"
                            self.VC?.customerId = "\(result?.lstCustomerJson?[0].customerId ?? 0)"
                            self.VC?.acountHolderNameTxt = "\(result?.lstCustomerJson?[0].acountHolderName ?? "")"
                            self.VC?.accountNumberTxt = result?.lstCustomerJson?[0].accountNumber ?? ""
                            self.VC?.bankNameTxt = result?.lstCustomerJson?[0].bankName ?? ""
                            self.VC?.ifscCodetxt = result?.lstCustomerJson?[0].ifscCode ?? ""
                            self.VC?.bankPassbookImagetxt = result?.lstCustomerJson?[0].bankPassbookImage ?? ""
                        
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
    func myProfileListApi2(parameter: JSON){
        DispatchQueue.main.async {
            self.VC2?.startLoading()
        }
        self.requestAPIs.myProfileListApi(parameters: parameter) { (result, error) in
            
            if error == nil{
                if result != nil{
                    
                    DispatchQueue.main.async {
                        self.VC2?.stopLoading()
                        if result?.lstCustomerJson?.count != 0 {

                            self.VC2?.firstNameTF = result?.lstCustomerJson?[0].firstName ?? ""
                            self.VC2?.lastNameTF = result?.lstCustomerJson?[0].lastName ?? ""
                            self.VC2?.customerMobileNumber = result?.lstCustomerJson?[0].mobile ?? ""
                            self.VC2?.addressTF = result?.lstCustomerJson?[0].address1 ?? ""
                            self.VC2?.stateId = "\(result?.lstCustomerJson?[0].stateId ?? 0)"
                            self.VC2?.cityId = "\(result?.lstCustomerJson?[0].cityId ?? 0)"
                            self.VC2?.pinCodeTF = result?.lstCustomerJson?[0].zip ?? ""
                            let splitDOB = (result?.lstCustomerJson?[0].jdob ?? "").split(separator: " ")
                            self.VC2?.doB = "\(splitDOB[0])"
                            self.VC2?.addressId = "\(result?.lstCustomerJson?[0].addressId ?? 0)"
                            
                            self.VC2?.emailTF = "\(result?.lstCustomerJson?[0].email ?? "")"
                            self.VC2?.isActiveCheck = result?.lstCustomerJson?[0].isActive ?? 0
                            self.VC2?.locationData = result?.lstCustomerJson?[0].locationId ?? 0
                            self.VC2?.accountHolderTF.text = result?.lstCustomerJson?[0].acountHolderName ?? ""
                            self.VC2?.accountNumberTF.text = result?.lstCustomerJson?[0].accountNumber ?? ""
                            self.VC2?.confirmAccountNumberTF.text = result?.lstCustomerJson?[0].accountNumber ?? ""
                            self.VC2?.bankNameTF.text = result?.lstCustomerJson?[0].bankName ?? ""
                            self.VC2?.ifscCodeTF.text = result?.lstCustomerJson?[0].ifscCode ?? ""
                            self.VC2?.apiImageData = result?.lstCustomerJson?[0].bankPassbookImage ?? ""
                            
                            
                            self.VC2?.verificationStatusLbl.isHidden = false
                            self.VC2?.verificationStatusTitle.isHidden = false
                            print(result?.lstCustomerJson?[0].verifiedStatus,"dksjnkdjs")
                            if result?.lstCustomerJson?[0].verifiedStatus != nil{
                                if result?.lstCustomerJson?[0].bankAccountVerifiedStatus == 1{
                                    self.VC2?.verificationStatusLbl.text = "Approved"
                                    self.VC2?.verificationStatusLbl.textColor = .green
                                    self.VC2?.submitBtn.isHidden = true
                                    self.VC2?.uploadOutButton.isEnabled = false
                                    
                                }else if result?.lstCustomerJson?[0].bankAccountVerifiedStatus == 2 {
                                    self.VC2?.verificationStatusLbl.text = "Rejected"
                                    self.VC2?.verificationStatusLbl.textColor = .red
                                    self.VC2?.submitBtn.isHidden = false
                                    self.VC2?.uploadDoccumentBtn.isHidden = false
                                    
                                    self.VC2?.accountHolderTF.isEnabled = true
                                    self.VC2?.accountNumberTF.isEnabled = true
                                    self.VC2?.ifscCodeTF.isEnabled = true
                                    self.VC2?.bankNameTF.isEnabled = true
                                    self.VC2?.bankNameTF.isEnabled = true
                                    self.VC2?.submitBtn.isEnabled = true
                                    self.VC2?.uploadDoccumentBtn.isEnabled = true
                                    self.VC2?.confirmAccountNumberTF.isEnabled = true
                                    self.VC2?.uploadOutButton.isEnabled = true
                                    
                                }else if result?.lstCustomerJson?[0].bankAccountVerifiedStatus == 0{
                                    
                                    self.VC2?.verificationStatusLbl.text = "Pending"
                                    self.VC2?.verificationStatusLbl.textColor = .orange
                                    self.VC2?.submitBtn.isHidden = true
                                    self.VC2?.uploadDoccumentBtn.isEnabled = false
                                    self.VC2?.uploadOutButton.isEnabled = false
                                }
                                
                                
                                
                                if self.VC2?.accountHolderTF.text == "" && self.VC2?.accountNumberTF.text == "" && self.VC2?.ifscCodeTF.text == "" && self.VC2?.bankNameTF.text == "" && self.VC2?.confirmAccountNumberTF.text == "" {
                                    self.VC2?.accountHolderTF.isEnabled = true
                                    self.VC2?.accountNumberTF.isEnabled = true
                                    self.VC2?.ifscCodeTF.isEnabled = true
                                    self.VC2?.bankNameTF.isEnabled = true
                                    self.VC2?.bankNameTF.isEnabled = true
                                    self.VC2?.confirmAccountNumberTF.isEnabled = true
                                    self.VC2?.uploadDoccumentBtn.isEnabled = true
                                    self.VC2?.submitBtn.isEnabled = true
                                    self.VC2?.verificationStatusLbl.isHidden = true
                                    self.VC2?.verificationStatusTitle.isHidden = true
                                }

                            }else{
                                if self.VC2?.accountHolderTF.text == "" && self.VC2?.accountNumberTF.text == "" && self.VC2?.ifscCodeTF.text == "" && self.VC2?.bankNameTF.text == "" && self.VC2?.confirmAccountNumberTF.text == "" {
                                    self.VC2?.verificationStatusLbl.isHidden = false
                                    self.VC2?.verificationStatusTitle.isHidden = false
                                    self.VC2?.verificationStatusLbl.text = "Bank Details Not Subnitted"
                                    self.VC2?.verificationStatusLbl.textColor = .orange
                                    self.VC2?.submitBtn.isHidden = false
                                    
                                    self.VC2?.accountHolderTF.isEnabled = true
                                    self.VC2?.accountNumberTF.isEnabled = true
                                    self.VC2?.ifscCodeTF.isEnabled = true
                                    self.VC2?.bankNameTF.isEnabled = true
                                    self.VC2?.bankNameTF.isEnabled = true
                                    self.VC2?.uploadDoccumentBtn.isEnabled = true
                                    self.VC2?.uploadDoccumentBtn.isHidden = false
                                    self.VC2?.uploadDoccumentInfoLbl.isHidden = false
                                    if self.VC2?.strdata1 == "" {
                                        self.VC2?.uploadImageHeight.constant = 0
                                    }
                                    self.VC2?.confirmAccountNumberTF.isEnabled = true
                                }else{
                                    let bankStatus = result?.lstCustomerJson?[0].accountStatus
                                    
                                    self.VC2?.verificationStatusLbl.isHidden = false
                                    self.VC2?.verificationStatusTitle.isHidden = false
                                    if result?.lstCustomerJson?[0].bankAccountVerifiedStatus == 1{
                                        self.VC2?.verificationStatusLbl.text = "Approved"
                                        self.VC2?.verificationStatusLbl.textColor = .systemGreen
                                        self.VC2?.submitBtn.isHidden = true
                                        self.VC2?.uploadOutButton.isEnabled = false
                                        
                                    }else if result?.lstCustomerJson?[0].bankAccountVerifiedStatus == 2 {
                                        self.VC2?.verificationStatusLbl.text = "Rejected"
                                        self.VC2?.verificationStatusLbl.textColor = .red
                                        self.VC2?.submitBtn.isHidden = false
                                        self.VC2?.uploadDoccumentBtn.isHidden = false
                                        
                                        self.VC2?.accountHolderTF.isEnabled = true
                                        self.VC2?.accountNumberTF.isEnabled = true
                                        self.VC2?.ifscCodeTF.isEnabled = true
                                        self.VC2?.bankNameTF.isEnabled = true
                                        self.VC2?.bankNameTF.isEnabled = true
                                        self.VC2?.submitBtn.isEnabled = true
                                        self.VC2?.uploadDoccumentBtn.isEnabled = true
                                        self.VC2?.confirmAccountNumberTF.isEnabled = true
                                        self.VC2?.uploadOutButton.isEnabled = true
                                        
                                        self.VC2?.accountHolderTF.text = ""
                                        self.VC2?.accountNumberTF.text = ""
                                        self.VC2?.ifscCodeTF.text = ""
                                        self.VC2?.bankNameTF.text = ""
                                        self.VC2?.bankNameTF.text = ""
                                        self.VC2?.confirmAccountNumberTF.text = ""
                                        self.VC2?.strdata1 = ""
                                        
                                        
                                        
                                        
                                    }else if result?.lstCustomerJson?[0].bankAccountVerifiedStatus == 0{
                                        
                                        self.VC2?.verificationStatusLbl.text = "Pending"
                                        self.VC2?.verificationStatusLbl.textColor = .orange
                                        self.VC2?.submitBtn.isHidden = true
                                        self.VC2?.uploadDoccumentBtn.isEnabled = false
                                        self.VC2?.uploadOutButton.isEnabled = false
                                    }
                                    let imageurl = "\(result?.lstCustomerJson?[0].bankPassbookImage ?? "")".dropFirst(1)
                                    let imageData = imageurl.split(separator: "~")
                                    if self.VC2?.verificationStatusLbl.text == "Rejected"{
                                        self.VC2?.uploadImageHeight.constant = 0
                                        self.VC2?.uploadDoccumentBtn.isHidden = false
                                        self.VC2?.uploadDoccumentInfoLbl.isHidden = false
                                    }else{
                                        if imageData.count >= 2 {
                                            print(imageData[1],"jdsnjkdn")
                                            let totalImgURL = PROMO_IMG1 + (imageData[1])
                                            print(totalImgURL, "Total Image URL")
                                            self.VC2?.uploadImage.kf.setImage(with: URL(string: totalImgURL),placeholder: UIImage(named: "ic_default_img"))
                                            self.VC2?.uploadImageHeight.constant = 150
                                            self.VC2?.uploadDoccumentBtn.isHidden = true
                                            self.VC2?.uploadDoccumentInfoLbl.isHidden = true
                                        }else{
                                            let totalImgURL = PROMO_IMG1 + imageurl
                                            print(totalImgURL, "Total Image URL")
                                            self.VC2?.apiImageData = totalImgURL
                                            self.VC2?.uploadImage.kf.setImage(with: URL(string: totalImgURL),placeholder: UIImage(named: "ic_default_img"))
                                            self.VC2?.uploadImageHeight.constant = 150
                                            //self.VC2?.uploadDoccumentBtn.isHidden = true
                                            self.VC2?.uploadDoccumentBtn.isHidden = true
                                            self.VC2?.uploadDoccumentInfoLbl.isHidden = true
                                        }
                                    }
                                }
                                
                            }
                            
                        }else{
                            self.VC2?.submitBtn.isHidden = false
                            self.VC2?.uploadDoccumentBtn.isHidden = false
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC2?.stopLoading()
                        print(result, "Result")
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC2?.stopLoading()
                    print(error, "Error")
                }
            }
        }
    }
    
    func updateProfileDetailsApi(parameter: JSON){
        DispatchQueue.main.async {
            if self.flags == "MyProfile"{
                self.VC?.startLoading()
            }else{
                self.VC2?.startLoading()
            }
        }
        self.requestAPIs.updateProfileApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    
                    DispatchQueue.main.async {
                        if self.flags == "MyProfile"{
                            self.VC?.stopLoading()
                        }else{
                            self.VC2?.stopLoading()
                        }
                        
                        if result?.returnMessage ?? "" == "1"{
                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as! PopupAlertOne_VC
                            if self.flags == "MyProfile"{
                                vc.descriptionInfo = "Profile Updated Successfully".localiz()
                            }else{
                                vc.descriptionInfo = "Bank transfer request has been submitted successfully".localiz()
                            }
                            vc.itsComeFrom = "ProfileUpdate"
                            vc.modalPresentationStyle = .overFullScreen
                            vc.modalTransitionStyle = .coverVertical
                            if self.flags == "MyProfile"{
                                self.VC?.submitBtn.isHidden = true
                                self.VC?.emailTF.isEnabled = false
                                self.VC?.present(vc, animated: true)
                            }else{
                                self.VC2?.submitBtn.isHidden = true
                                self.VC2?.present(vc, animated: true)
                            }
                            self.VC2?.verificationStatusTitle.isHidden = false
                            self.VC2?.verificationStatusLbl.isHidden = false
                        }else{
                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as! PopupAlertOne_VC
                            vc.itsComeFrom = "ProfileUpdate"
                            if self.flags == "MyProfile"{
                                vc.descriptionInfo = "Profile Update is failed".localiz()
                            }else{
                                vc.descriptionInfo = "Bank transfer is failed".localiz()
                            }
                            vc.modalPresentationStyle = .overFullScreen
                            vc.modalTransitionStyle = .coverVertical
                            if self.flags == "MyProfile"{
                                self.VC?.present(vc, animated: true)
                            }else{
                                self.VC2?.present(vc, animated: true)
                            }
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        if self.flags == "MyProfile"{
                            self.VC?.stopLoading()
                        }else{
                            self.VC2?.stopLoading()
                        }
                        
                        print(result, "Result")
                    }
                }
            }else{
                DispatchQueue.main.async {
                    if self.flags == "MyProfile"{
                        self.VC?.stopLoading()
                    }else{
                        self.VC2?.stopLoading()
                    }
                    print(error, "Error")
                }
            }
        }
        }
    
    
    
    
    
    
    
    
    
}
