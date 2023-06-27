//
//  HR_EditAddressVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/10/22.
//

import UIKit
import LanguageManager_iOS
protocol SendUpdatedAddressDelegate {
    func updatedAddressDetails(_ vc: HR_EditAddressVC)
}
class HR_EditAddressVC: BaseViewController, popUpAlertDelegate, SelectedItemDelegate, UITextFieldDelegate{
    func didSelectedItem(_ vc: HR_SelectionVC) {
        print(vc.selectedTitle)
        print(vc.selectedId)
        if vc.isComeFrom == 1{
            self.selectCountry.text = vc.selectedTitle
            self.selectedCountryId = Int(vc.selectedId) ?? 0
        }else if vc.isComeFrom == 2{
            self.selectStateLbl.text = vc.selectedTitle
            self.selectedStateID = Int(vc.selectedId) ?? 0
            self.selectCityLbl.text! = "Select City".localiz()
        }else if vc.isComeFrom == 3{
            self.selectCityLbl.text = vc.selectedTitle
            self.selectedCityID = Int(vc.selectedId) ?? 0
        }
    }
    
    func popupAlertDidTap(_ vc: HR_PopUpVC) {
    }
    
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var headerView: UIView!

    @IBOutlet weak var saveChangeLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var selectCountry: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var enterNameTF: UITextField!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var selectStateLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var selectCityLbl: UILabel!
    @IBOutlet weak var ziplbl: UILabel!
    @IBOutlet weak var zipTF: UITextField!
    @IBOutlet weak var savedBTN: UIButton!
    @IBOutlet weak var subView: UIView!
    var delegate: SendUpdatedAddressDelegate!
    
    @IBOutlet weak var saveChangesView: UIView!
    @IBOutlet weak var cityDropDownImage: UIImageView!
    @IBOutlet weak var stateDropDownImage: UIImageView!
    @IBOutlet weak var dropDownRedImage: UIImageView!
    
    @IBOutlet weak var newAddressLbl: UILabel!
    
    @IBOutlet weak var mobileLbl: UILabel!
    
    
    
    var selectedname = ""
    var selectedemail = ""
    var selectedmobile = ""
    var selectedState = ""
    var selectedStateID = 0
    var selectedCity = ""
    var selectedCityID = 0
    var selectedaddress = ""
    var selectedpincode = ""
    var selectedCountryId = 0
    var selectedCountry = ""
 
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        if UserDefaults.standard.string(forKey: "CustomerType") ?? "" == "1"{
            self.headerView.backgroundColor = #colorLiteral(red: 0.7437494397, green: 0.08922102302, blue: 0.1178346947, alpha: 1)
            self.subView.backgroundColor = #colorLiteral(red: 1, green: 0.8901960784, blue: 0.8941176471, alpha: 1)
            self.cityDropDownImage.image = UIImage(named: "dropdwn")
            self.stateDropDownImage.image = UIImage(named: "dropdwn")
            self.dropDownRedImage.image = UIImage(named: "dropdwn")
            self.saveChangesView.backgroundColor = #colorLiteral(red: 0.7437494397, green: 0.08922102302, blue: 0.1178346947, alpha: 1)
            self.homeImage.image = UIImage(named: "home")
            
            self.newAddressLbl.textColor = .black
            self.nameLbl.textColor = .black
            self.mobileLbl.textColor = .black
            self.email.textColor = .black
            self.address.textColor = .black
            self.countryLbl.textColor = .black
            self.stateLbl.textColor = .black
            self.cityLbl.textColor = .black
            self.ziplbl.textColor = .black
            
            
        }else{
            self.headerView.backgroundColor  = #colorLiteral(red: 0.1674154699, green: 0.3054217696, blue: 0.7360057235, alpha: 1)
            self.subView.backgroundColor = #colorLiteral(red: 0.168627451, green: 0.3058823529, blue: 0.737254902, alpha: 1)
            self.cityDropDownImage.image = UIImage(named: "dropDownBlue")
            self.stateDropDownImage.image = UIImage(named: "dropDownBlue")
            self.dropDownRedImage.image = UIImage(named: "dropDownBlue")
            self.saveChangesView.backgroundColor = #colorLiteral(red: 0.168627451, green: 0.3058823529, blue: 0.737254902, alpha: 1)
            self.homeImage.image = UIImage(named: "local-shipping_Blue")
            
            self.newAddressLbl.textColor = .white
            self.nameLbl.textColor = .white
            self.mobileLbl.textColor = .white
            self.email.textColor = .white
            self.address.textColor = .white
            self.countryLbl.textColor = .white
            self.stateLbl.textColor = .white
            self.cityLbl.textColor = .white
            self.ziplbl.textColor = .white
            
        }
        self.zipTF.delegate = self
        self.mobileTF.delegate = self
        self.enterNameTF.text = selectedname
        self.enterNameTF.isEnabled = true
        self.mobileTF.isEnabled = true
        self.mobileTF.text = selectedmobile
        self.emailTF.text = selectedemail
        print(selectedaddress, "sdkalfaskfsad")
        self.addressTF.text = selectedaddress
        self.selectCountry.isEnabled = false
        print(self.selectedStateID, "selectedState ID")
        if selectedState != "" {
            self.selectStateLbl.text = selectedState
        }else{
            self.selectStateLbl.text = "Select State".localiz()
        }
        if selectedCity != "" {
            self.selectCityLbl.text = selectedCity
        }else{
            self.selectCityLbl.text = "Select City".localiz()
        }
        if selectedCountry != ""{
            self.selectCountry.text = self.selectedCountry
        }else{
            self.selectCountry.text = "Select Country".localiz()
        }
        self.zipTF.text = selectedpincode
        
    }
    
    func localization(){
        self.newAddressLbl.text = "New Address".localiz()
        self.saveChangeLbl.text = "Save Changes".localiz()
        self.nameLbl.text = "Name".localiz()
        self.mobile.text = "Mobile".localiz()
        self.email.text = "Email".localiz()
        self.address.text = "Address".localiz()
        self.countryLbl.text = "Country".localiz()
        self.selectCountry.text = "Select Country".localiz()
        self.cityLbl.text = "City".localiz()
        self.stateLbl.text = "State".localiz()
        self.selectStateLbl.text = "Select State".localiz()
        self.selectCityLbl.text = "Select City".localiz()
        self.ziplbl.text = "Zip".localiz()
        self.enterNameTF.placeholder = "Enter Name".localiz()
        self.mobileTF.placeholder = "Enter Mobile Number".localiz()
        self.emailTF.placeholder = "Enter Email".localiz()
        self.addressTF.placeholder = "Enter Address".localiz()
        self.zipTF.placeholder = "Enter Zip".localiz()
        
    }

    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func selectCountryBTN(_ sender: Any) {
//        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "No Internet Connection"
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }
//        }else{
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_SelectionVC") as! HR_SelectionVC
//            vc.delegate = self
//            vc.isComeFrom = 1
//            vc.modalPresentationStyle = .overCurrentContext
//            vc.modalTransitionStyle = .crossDissolve
//            self.present(vc, animated: true, completion: nil)
//        }
    }
    
    @IBAction func selectStateBTN(_ sender: Any) {
        if self.selectedCountryId == 0{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Select Country".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
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
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_SelectionVC") as! HR_SelectionVC
                vc.delegate = self
                vc.isComeFrom = 2
                vc.selectedCountryId = self.selectedCountryId
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true, completion: nil)
            }
        }
        
    }
    @IBAction func selectCityBTN(_ sender: Any) {
        if self.selectedStateID == 0 || self.selectedCountryId == 0{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Select State".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
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
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_SelectionVC") as! HR_SelectionVC
                vc.delegate = self
                vc.isComeFrom = 3
                vc.selectedStateId = selectedStateID
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true, completion: nil)
            }
        }
        
       
    }
    @IBAction func saveChangesBTN(_ sender: Any) {
       //Api Call
        if enterNameTF.text?.count == 0{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter Name".localiz()
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
        }else if mobileTF.text?.count == 0 {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter Mobile Number".localiz()
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
        }else if mobileTF.text?.count != 10 {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Entervalidmobilernumber".localiz()
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
        }
//        else if emailTF.text?.count == 0{
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "EnterEmailID"
//                vc!.modalPresentationStyle = .overFullScreen
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }
//            
//        }else  if !isValidEmail(emailTF.text ?? "") {
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "EnterValidEmailID"
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//                }
//            }
        else if addressTF.text?.count == 0 || addressTF.text!.count < 3{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter Address".localiz()
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
        }else if selectCountry.text == "Select Country".localiz(){
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Select Country".localiz()
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
        }else if selectStateLbl.text == "Select State".localiz() || self.selectStateLbl.text == "-" || self.selectStateLbl.text!.count < 3{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Select State".localiz()
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
        }else if selectCityLbl.text == "Select City".localiz() || self.selectCityLbl.text == "-" || self.selectCityLbl.text!.count < 3{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Select City".localiz()
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
            }else if zipTF.text?.count == 0 {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter Zip".localiz()
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
        }else if zipTF.text?.count != 6{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter Valid Zip".localiz()
                vc!.modalPresentationStyle = .overFullScreen
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            
        }else{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Shipping Address Updated".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            self.selectedname = self.enterNameTF.text!
            print(self.enterNameTF.text ?? "")
            self.selectedmobile = self.mobileTF.text!
            print(self.mobileTF.text ?? "")
            self.selectedemail = self.emailTF.text!
            print(self.emailTF.text ?? "")
            self.selectedaddress = self.addressTF.text!
            print(self.addressTF.text ?? "")
            self.selectedCountry = self.selectCountry.text!
            print(self.selectCountry.text ?? "")
            self.selectedState = self.selectStateLbl.text!
            print(self.selectStateLbl.text ?? "")
            self.selectedCity = self.selectCityLbl.text!
            print(self.selectCityLbl.text ?? "")
            self.selectedpincode = self.zipTF.text!
            print(self.zipTF.text ?? "")
            self.delegate.updatedAddressDetails(self)
            self.navigationController?.popViewController(animated: true)
        }
    
       
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let otpLength = 6
        if textField == mobileTF{
            let currentString: NSString = (mobileTF.text ?? "") as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else if textField == zipTF{
            let currentString: NSString = (zipTF.text ?? "") as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= otpLength
        }
        return true
    }
    func isValidPhone(testStr:String) -> Bool {
        let phoneRegEx = "^[6-9]\\d{9}$"
        let phoneNumber = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneNumber.evaluate(with: testStr)
    }
//    func isValidEmail(_ email: String) -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//
//        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailPred.evaluate(with: email)
//    }

}
