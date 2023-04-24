//
//  MyProfileVC.swift
//  GogrejLocksMobileApplication
//
//  Created by Arokia IT on 2/14/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit
import SDWebImage

class MyProfileVC: BaseViewController {
    
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.myProfileApi(UserID: self.userId)
        NotificationCenter.default.addObserver(self, selector: #selector(handlepopupStateclose), name: Notification.Name.getProfileDetails, object: nil)
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
    
    
    @IBAction func selectEditEmailBtn(_ sender: Any) {
        emailTF.isEnabled = true
        
    }
    
    @IBAction func selectEmailTF(_ sender: UITextField) {
        
        if self.emailTF.text!.count > 1 {
            if !isValidEmail(self.emailTF.text ?? "") {
                self.emailTF.text = ""
                self.view.makeToast("Enter valid email", duration: 2.0, position: .bottom)
                submitBtn.isHidden = true
            }else{
                submitBtn.isHidden = false
            }
        }else{
            self.view.makeToast("Enter email", duration: 2.0, position: .bottom)
            submitBtn.isHidden = true
        }
    }
    @IBAction func selectDOBBtn(_ sender: Any) {
    }
    
    @IBAction func selectSubmitBtn(_ sender: UIButton) {
        if emailTF.text?.count == 0{
            self.view.makeToast("Enter email",duration: 2.0,position: .center)
        }else{
            profileUpdate()
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
                "FirstName": firstNameTF.text ?? "",
                "LastName": lastNameTF.text ?? "",
                "Mobile": self.mobileNumberTF.text ?? "",
                "Address1": self.addressTF.text ?? "",
                "StateId": self.stateId,
                "CityId": self.cityId,
                "Zip": self.pinCodeTF.text ?? "",
                "JDOB": self.dobTF.text ?? "",
                "AddressId": self.addressId,
                "AcountHolderName": "",
                "AccountNumber": "",
                "BankName": "",
                "IFSCCode": "",
                "BankPassbookImage": "",
                "IsMobileRequest":1,
                "Email": emailTF.text ?? ""
            ]
        ]
            print(parameter)
        self.VM.flags = "MyProfile"
            self.VM.updateProfileDetailsApi(parameter: parameter)
    }
    
}
