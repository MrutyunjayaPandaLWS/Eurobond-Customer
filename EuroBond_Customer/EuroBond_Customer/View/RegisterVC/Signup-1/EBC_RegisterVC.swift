//
//  EBC_RegisterVC.swift
//  EuroBond_Customer
//
//  Created by syed on 18/03/23.
//

import UIKit
import Toast_Swift

class EBC_RegisterVC: BaseViewController, DropdownDelegate, DateSelectedDelegate, UITextFieldDelegate{
    
    func didTappedQueryListBtn(_ vc: EBC_DropDownVC) {}
    
    func acceptDate(_ vc: EBC_DateFilterVC) {
        print(vc.selectedDate)
        self.dobTF.text = vc.selectedDate
        self.selectedDOB = vc.selectedDate
        self.dobTF.textColor = .darkGray
    }
    
    func declineDate(_ vc: EBC_DateFilterVC) {}
    
    func didtappedLanguageListBtn(_ vc: EBC_DropDownVC) {
        self.languageName = vc.languageName
        self.languageId = vc.languageId
        self.prefferedLanguageTF.textColor = .darkGray
        self.prefferedLanguageTF.text = vc.languageName
    }
    
    func didtappedCityListBtn(_ vc: EBC_DropDownVC) {
        self.cityTF.text = vc.cityName
        self.selectedCityId = vc.cityId
        self.cityTF.textColor = .darkGray
    }
    
    func didTappedGenderBtn(_ vc: EBC_DropDownVC) {
        self.genderTF.text = vc.statusName
        self.selectedGender = vc.statusName
        self.genderTF.textColor = .darkGray
    }
    
    func didtappedStateListBtn(_ vc: EBC_DropDownVC) {
        self.stateTF.text = vc.stateName
        self.stateTF.textColor = .darkGray
        self.selectedStateID = vc.stateId
        self.selectedCityId = -1
        self.cityTF.placeholder = "Select City"
        print(vc.stateName)
    }
    

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var alreadyHaveAccountLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var prefferedLanguageTF: UITextField!
    @IBOutlet weak var preferredLanguageLbl: UILabel!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var pincodeTF: UITextField!
    @IBOutlet weak var pincodeLbl: UILabel!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var lastNameTF: UITextField!
    
    var referralCode = ""
    
    var selectedStateID = -1
    var selectedStateName = ""
    
    var selectedCityName = ""
    var selectedCityId = -1
    
    var selectedGender = ""
    var selectedGenderId = -1
    
    var languageName = ""
    var languageId = -1
    var selectedDOB = ""
    
    var enteredMobile = ""
    var customerTypeName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileTF.delegate = self
        pincodeTF.delegate = self
        self.mobileTF.keyboardType = .asciiCapableNumberPad
        self.pincodeTF.keyboardType = .asciiCapableNumberPad
        self.mobileTF.text = self.enteredMobile
        self.nameTF.text = self.customerTypeName
    }
    @IBAction func selectStateBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DropDownVC") as! EBC_DropDownVC
        vc.flags = "state"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    @IBAction func selectCityBtn(_ sender: UIButton) {
        if self.selectedStateID == -1{
            self.cityTF.placeholder = "Select City"
            self.view.makeToast("Select State", duration: 2.0, position: .center)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DropDownVC") as! EBC_DropDownVC
            vc.flags = "city"
            vc.delegate = self
            vc.stateId = self.selectedStateID
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    @IBAction func selectDOBBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DateFilterVC") as! EBC_DateFilterVC
        vc.isComeFrom = "DOB"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func selectGenderBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DropDownVC") as! EBC_DropDownVC
        vc.flags = "gender"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    @IBAction func selectPrefferedLanguageBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DropDownVC") as! EBC_DropDownVC
        vc.flags = "language"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func emailValidationDidEnd(_ sender: Any) {
        if self.emailTF.text!.count > 1 {
            if !isValidEmail(self.emailTF.text ?? "") {
                self.emailTF.text = ""
                self.view.makeToast("Enter valid email", duration: 2.0, position: .bottom)
            }
        }
    }
    @IBAction func selectNextbtn(_ sender: UIButton) {
        
        if self.nameTF.text!.count == 0 || self.nameTF.text == "  "{
            self.view.makeToast("Enter first name", duration: 2.0, position: .bottom)
        }else if self.mobileTF.text?.count == 0{
            self.view.makeToast("Enter mobile number", duration: 2.0, position: .bottom)
        }else if self.addressTF.text?.count == 0{
            self.view.makeToast("Enter address", duration: 2.0, position: .bottom)
        }else if self.selectedStateID == -1{
            self.view.makeToast("Select State", duration: 2.0, position: .bottom)
        }else if self.selectedCityId == -1{
            self.view.makeToast("Select City", duration: 2.0, position: .bottom)
        }else if self.pincodeTF.text?.count == 0{
            self.view.makeToast("Enter pincode", duration: 2.0, position: .bottom)
        }else if self.pincodeTF.text?.count != 6{
            self.view.makeToast("Enter valid pincode", duration: 2.0, position: .bottom)
        }else if self.selectedDOB == ""{
            self.view.makeToast("Select Date of birth", duration: 2.0, position: .bottom)
        }else if self.selectedGender == ""{
            self.view.makeToast("Select Gender", duration: 2.0, position: .bottom)
        }else if self.languageName == ""{
            self.view.makeToast("Select language", duration: 2.0, position: .bottom)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_Signup2VC") as! EBC_Signup2VC
            vc.selectedStateID = self.selectedStateID
            vc.selectedStateName = self.selectedStateName
            vc.selectedCityName = self.selectedCityName
            vc.selectedCityId = self.selectedCityId
            vc.languageId = self.languageId
            vc.selectedGender = self.selectedGender
            vc.languageName = self.languageName
            vc.selectedDOB = self.selectedDOB
            vc.pincode = self.pincodeTF.text ?? ""
            vc.firstNames = self.nameTF.text ?? ""
            vc.lastName = self.lastNameTF.text ?? ""
            vc.mobile = self.mobileTF.text ?? ""
            vc.address = self.addressTF.text ?? ""
            vc.email = self.emailTF.text ?? ""
            vc.selectedDOB = self.selectedDOB
            vc.referralCode = self.referralCode
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
     
    }
    
    @IBAction func selectLoginBtn(_ sender: UIButton) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: EBC_Login1VC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
      let compSepByCharInSet = string.components(separatedBy: aSet)
      let numberFiltered = compSepByCharInSet.joined(separator: "")
      if string == numberFiltered {
          if textField == mobileTF{
              let currentText = mobileTF.text ?? ""
              guard let stringRange = Range(range, in: currentText) else { return false }
              let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
              return updatedText.count <= 10
          }else if textField == pincodeTF {
              let currentText = pincodeTF.text ?? ""
              guard let stringRange = Range(range, in: currentText) else { return false }
              let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
              return updatedText.count <= 6
          }
      
      } else {
        return false
      }
        return false
    }
        

    
    
    
}
