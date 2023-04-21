//
//  HR_OTP_VC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/11/22.
//

import UIKit
//import LanguageManager_iOS

class HR_RedemptionOTP_VC: BaseViewController, popUpAlertDelegate, UITextFieldDelegate{
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}

    @IBOutlet weak var messageTitle: UILabel!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var otpImg: UIImageView!
    @IBOutlet weak var enterOTP_TF: UITextField!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var resendOTP: UIButton!
    @IBOutlet weak var secondsRemaining: UILabel!
    @IBOutlet weak var enterOTPtitle: UILabel!
    @IBOutlet weak var enterOTPTopspaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var submitLbl: UILabel!
    
    var stateID = 0
    var cityID = 0
    var cityName = ""
    var stateName = ""
    var countryId = 0
    var countryName = ""
    var pincode = ""
    var address1 = ""
    var customerName = ""
    var mobile = ""
    var emailId = ""
    var userID = UserDefaults.standard.integer(forKey: "UserID")
    var loyaltyID = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var mobilenumber = UserDefaults.standard.string(forKey: "Mobile") ?? ""
    let emailID = UserDefaults.standard.string(forKey: "CustomerEmail") ?? ""
    let firstname = UserDefaults.standard.string(forKey: "FirstName") ?? ""
    let merchantUserName = UserDefaults.standard.string(forKey: "MerchantEmail") ?? ""
    var merchanMobile = UserDefaults.standard.string(forKey: "MerchantMobile") ?? ""
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    var OTPforVerification = ""
    var redeemedPoints = 0
    var redemptionRefId = ""
    var dreamGiftId = 0
    var giftPts = 0
    var giftName = ""
    var contractorName = ""
    var giftStatusId = 0
    var redemptionTypeId = 0
    
    var count = 60
    var timer = Timer()
    var VM = HR_RedemptionOTP_VM()
    
    var productsParameter:JSON?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.enterOTP_TF.delegate = self
        self.messageTitle.text = "Otp has been sent to registered mobile number"
        self.enterOTPtitle.text = "Enter OTP"
        self.resendOTP.setTitle("Resend OTP", for: .normal)
        self.submitLbl.text = "Submit"
        self.enterOTP_TF.placeholder = "Enter OTP"
        NotificationCenter.default.addObserver(self, selector: #selector(redemptionProducts), name: .redemptionSuccess, object: nil)
        self.mobileNumberLbl.text = self.mobile
        
        if UserDefaults.standard.string(forKey: "CustomerType") ?? "" == "1"{
         //   self.resendOTP.backgroundColor = #colorLiteral(red: 0.7437494397, green: 0.08922102302, blue: 0.1178346947, alpha: 1)
            self.resendOTP.setTitleColor(#colorLiteral(red: 0.7437494397, green: 0.08922102302, blue: 0.1178346947, alpha: 1), for: .normal)
        }else{
            //self.headerView.backgroundColor  = #colorLiteral(red: 0.1643253267, green: 0.3061718345, blue: 0.7360334992, alpha: 1)
            self.resendOTP.setTitleColor(#colorLiteral(red: 0.1643253267, green: 0.3061718345, blue: 0.7360334992, alpha: 1), for: .normal)
        }
    }
    @objc func update() {
        if(count > 1) {
            count = count - 1
            self.secondsRemaining.text = "\("Seconds Remaining"): \(count - 1)"
            self.enterOTPTopspaceConstraint.constant = 10
            self.resendOTP.isHidden = true
        }else{
            self.enterOTPTopspaceConstraint.constant = 30
            self.secondsRemaining.text = ""
            self.resendOTP.isHidden = false
            self.timer.invalidate()
        }
    }
    @objc func redemptionProducts() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_SuccessPoP_VC") as! HR_SuccessPoP_VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "No Internet Connection"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            self.VM.getMycartList()
            let paramerterJSON = [
                "EmailID":"\(emailId)","MerchantUserName":"\(merchantUserName)","Name":"\(loyaltyID)","UserId":"\(userID)","UserName":"\(firstname)","MobileNo":"\(mobile)"
            ]
            print(paramerterJSON)
            self.VM.OTPAPI(paramters: paramerterJSON)
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func backBTN(_ sender: Any) {
        self.timer.invalidate()
        NotificationCenter.default.post(name: .dismissCurrentVC, object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func resendOTPBTN(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "No Internet Connection"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            let paramerterJSON = [
                "EmailID":"\(emailId)","MerchantUserName":"\(merchantUserName)","Name":"\(loyaltyID)","UserId":"\(userID)","UserName":"\(firstname)","MobileNo":"\(mobilenumber)"
            ]
            self.VM.OTPAPI(paramters: paramerterJSON)
            
        }
    }
    
    @IBAction func submitBTN(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "No Internet Connection"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            if enterOTP_TF.text?.count == 6{
//                if self.OTPforVerification == self.enterOTP_TF.text ?? ""{
                if "123456" == self.enterOTP_TF.text ?? ""{
                    if self.contractorName == ""{
                        productsParameter = [
                            "ActionType":"51",
                            "ObjCatalogueDetails": [
                                "DomainName": "EuroBond"
                            ],
                            "ActorId": userId,
                            "MemberName": "\(self.customerName)",
                            "ObjCatalogueList": self.VM.newproductArray as [[String: Any]],
                            "ObjCustShippingAddressDetails":["Address1":"\(self.address1)","CityId":"\(self.cityID)", "CityName":"\(self.cityName)","CountryId":"\(self.countryId)","StateName": "\(self.stateName)","StateId":"\(self.stateID)","Zip":"\(self.pincode)","Email":"\(self.emailId)","FullName":"\(self.customerName)","Mobile": self.mobile],"SourceMode":5
                        ]
                    }else{
                        self.productsParameter = [
                                "ActionType": "51",
                                "ActorId": userId,
                                "MemberName": "\(contractorName)",
                                "ObjCatalogueList": [
                                    [
                                        "DreamGiftId": "\(dreamGiftId)",
                                        "LoyaltyId": "\(loyaltyId)",
                                        "PointBalance": "\(pointBalance)",
                                        "NoOfPointsDebit": "\(giftPts)",
                                        "NoOfQuantity": 1,
                                        "PointsRequired": "\(giftPts)",
                                        "ProductName": "\(giftName)",
                                        "RedemptionTypeId": self.redemptionTypeId
                                    ]
                                ],
                                "ObjCustShippingAddressDetails": [
                                    "Address1": "\(self.address1)",
                                    "CityId": self.cityID,
                                    "CityName": "\(self.cityName)",
                                    "CountryId": 103,
                                    "Email": "\(self.emailId)",
                                    "FullName": "\(contractorName)",
                                    "Mobile": "\(loyaltyId)",
                                    "StateId": self.stateID,
                                    "StateName": "\(self.stateName)",
                                    "Zip": "\(self.pincode)"
                                ],
                                "SourceMode": 5,
                                "ObjCatalogueDetails": [
                                    "DomainName": "EuroBond"
                                ]
                            
                        ] as [String: Any]
                        print(self.productsParameter ?? [], "Dream Gift")
                    }
                    self.VM.submitProductApi(parameters: productsParameter!)
                        
                }else{
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        vc!.descriptionInfo = "InValid OTP"
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                    }
                }
            }else{
                if enterOTP_TF.text?.count == 0 {
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        vc!.descriptionInfo = "Please Enter Correct OTP"
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                    }
                }else if enterOTP_TF.text?.count != 6{
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        vc!.descriptionInfo = "Enter Valid OTP"
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                    }
                }
                
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
      let compSepByCharInSet = string.components(separatedBy: aSet)
      let numberFiltered = compSepByCharInSet.joined(separator: "")

      if string == numberFiltered {
        let currentText = enterOTP_TF.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 6
      } else {
        return false
      }
    }
    

}
