//
//  MyProfileVC.swift
//  GogrejLocksMobileApplication
//
//  Created by Arokia IT on 2/14/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit
import SDWebImage
import LanguageManager_iOS
class MyProfileVC: BaseViewController, popUpAlertDelegate {
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var DOBLbl: UILabel!
    @IBOutlet weak var pinCodeTF: UITextField!
    @IBOutlet weak var pinCodeLbl: UILabel!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var beneficiaryTypeTF: UITextField!
    @IBOutlet weak var beneficiaryTypeLbl: UILabel!
    
   var VM = EBC_MyProfileVM()
    
    var stateId: String = "0", cityId: String = "0", customerId: String = "0", addressId: String = "0"
    
    var acountHolderNameTxt = ""
    var accountNumberTxt = ""
    var bankNameTxt = ""
    var ifscCodetxt = ""
    var bankPassbookImagetxt = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
            }
        }else{
            self.VM.VC = self
            self.myProfileApi(UserID: self.userId)
            NotificationCenter.default.addObserver(self, selector: #selector(handlepopupStateclose), name: Notification.Name.getProfileDetails, object: nil)
            localizSetup()
        }
    }
    
    @objc func handlepopupStateclose(notification: Notification){
        let profileDetails = notification.object as! BankDetailsVC
        profileDetails.beneficiaryTypeTF = self.beneficiaryTypeTF.text ?? ""
        profileDetails.firstNameTF = self.firstNameTF.text ?? ""
        profileDetails.lastNameTF = self.lastNameTF.text ?? ""
        profileDetails.mobileNumberTF = self.mobileNumberTF.text ?? ""
        profileDetails.emailTF = self.emailTF.text ?? ""
        profileDetails.addressTF = self.addressTF.text ?? ""
        profileDetails.stateTF = self.stateTF.text ?? ""
        profileDetails.cityTF = self.cityTF.text ?? ""
        profileDetails.pinCodeTF = self.pinCodeTF.text ?? ""
        profileDetails.doB = self.dobTF.text ?? ""
        profileDetails.stateId = self.stateId
        profileDetails.cityId = self.cityId
        profileDetails.customerId = self.customerId
        profileDetails.addressId = self.addressId
    }
    
    
    func localizSetup(){
        
        
        self.beneficiaryTypeLbl.text = "Beneficiary Type".localiz()
        self.beneficiaryTypeTF.placeholder = "Beneficiary Type".localiz()
        self.firstNameLbl.text = "First Name".localiz()
        self.firstNameTF.placeholder = "Enter first name".localiz()
        self.lastNameLbl.text = "Last Name".localiz()
        self.lastNameTF.placeholder = "Enter last name".localiz()
        self.mobileNumberLbl.text = "Mobile Number".localiz()
        self.mobileNumberTF.placeholder = "Mobile Number".localiz()
        self.emailLbl.text = "Email".localiz()
        self.emailTF.placeholder = "Enter Email".localiz()
        self.DOBLbl.text = "DOB1".localiz()
        self.pinCodeLbl.text = "Pincode".localiz()
        self.cityLbl.text = "City".localiz()
        self.stateLbl.text = "State".localiz()
        self.addressLbl.text = "Address".localiz()
        self.submitBtn.setTitle("Submit".localiz(), for: .normal)
        
    }
    
    @IBAction func selectEditEmailBtn(_ sender: Any) {
        self.emailTF.isEnabled = true
        
    }
    
    @IBAction func selectEmailTF(_ sender: UITextField) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
            }
        }else{
            
            if self.emailTF.text!.count > 1 {
                if !isValidEmail(self.emailTF.text ?? "") {
                    self.emailTF.text = ""
                    self.view.makeToast("Enter valid email".localiz(), duration: 2.0, position: .bottom)
                    submitBtn.isHidden = true
                }else{
                    submitBtn.isHidden = false
                }
            }else{
                self.view.makeToast("Enter email".localiz(), duration: 2.0, position: .bottom)
                submitBtn.isHidden = true
            }
        }
    }
    @IBAction func selectDOBBtn(_ sender: Any) {
    }
    
    @IBAction func selectSubmitBtn(_ sender: UIButton) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "No Internet Connection".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            if emailTF.text?.count == 0{
                self.view.makeToast("Enter email".localiz(),duration: 2.0,position: .center)
            }else{
                profileUpdate()
            }
        }
    }
    
    func myProfileApi(UserID: String){
        let parameter = [
            "CustomerId": UserID,
            "ActionType": "6"
        ] as [String: Any]
        print(parameter)
        self.VM.myProfileListApi(parameter: parameter)
        
    }

    
    func profileUpdate(){
        let parameter : [String : Any]  = [
            "ActionType": "4",
            "ActorId": self.userId,
            "ObjCustomerJson": [
                "CustomerId": self.customerId,
                "MerchantId": "1",
                "CountryId": "15",
                "FirstName": firstNameTF.text ?? "",
                "LastName": lastNameTF.text ?? "",
                "Mobile": self.mobileNumberTF.text ?? "",
                "Address1": self.addressTF.text ?? "",
                "StateId": self.stateId,
                "CityId": self.cityId,
                "Zip": self.pinCodeTF.text ?? "",
                "JDOB": self.dobTF.text ?? "",
                "AddressId": self.addressId,
                "AcountHolderName": "\(self.acountHolderNameTxt)",
                "AccountNumber": "\(self.accountNumberTxt)",
                "BankName": "\(self.bankNameTxt)",
                "IFSCCode": "\(self.ifscCodetxt)",
                "BankPassbookImage": "\(self.bankPassbookImagetxt)",
                "IsMobileRequest": 1,
                "Email": emailTF.text ?? ""
            ]
        ]
            print(parameter)
        self.VM.flags = "MyProfile"
            self.VM.updateProfileDetailsApi(parameter: parameter)
    }
    
    
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
////      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
////      let compSepByCharInSet = string.components(separatedBy: aSet)
////      let numberFiltered = compSepByCharInSet.joined(separator: "")
//
////      if string == numberFiltered {
//        let currentText = codeTF.text ?? ""
//        guard let stringRange = Range(range, in: currentText) else { return false }
//        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
//        return updatedText.count <= 12
//
//    }
    
    
    
}
