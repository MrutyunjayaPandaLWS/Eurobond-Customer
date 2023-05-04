//
//  EBS_LoginVC.swift
//  EuroBond_Customer
//
//  Created by syed on 17/03/23.
//

import UIKit
import DPOTPView
import Toast_Swift
import LanguageManager_iOS

class EBS_LoginVC: BaseViewController, CheckBoxSelectDelegate, popUpAlertDelegate  {
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    

       func accept(_ vc: HR_TermsandCondtionVC) {
            self.chechBox2Btn.setImage(UIImage(named: "fillcheckbox"), for: .normal)
            self.tc2Status = 1
        }
        
        func decline(_ vc: HR_TermsandCondtionVC) {
            self.chechBox2Btn.setImage(UIImage(named: "blankcheckbox"), for: .normal)
            self.tc2Status = 0
        }
        


    @IBOutlet weak var passwordSecureBtn: UIButton!
    @IBOutlet weak var fabricatorAssistanceview2: UIView!
    @IBOutlet weak var accountAssistance2Lbl: UILabel!
    @IBOutlet weak var clickhere2Btn: UIButton!
    @IBOutlet weak var loginBtn2: UIButton!
    @IBOutlet weak var chechBox2Btn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var login2InfoLbl: UILabel!
    @IBOutlet weak var login2TitleLbl: UILabel!

    @IBOutlet weak var termsAndConditionBtn: UIButton!
    
    
    var passwordSecurestatus = 0
    var viewStatus = 0
    var tc1Status = 0
    var tc2Status = 0
    var otpGenerateBtnStatus = 0
    var itsFrom = 0
    
    var VM = EBC_FabricatedLoginVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        passwordTF.isSecureTextEntry = true
        localizsetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fabricatorAssistanceview2.isHidden = false
    }
    
    
    func localizsetup(){
        login2TitleLbl.text = "login".localiz()
        login2InfoLbl.text = "Please enter the Username and Password shared by Fabricator".localiz()
        userNameLbl.text = "Username / Mobile number".localiz()
        userNameTF.placeholder = "Username / Mobile number".localiz()
        passwordLbl.text = "Password".localiz()
        passwordTF.placeholder = "Enter Password".localiz()
        termsAndConditionBtn.setTitle("IaccepttheTermsandConditions".localiz(), for: .normal)
        loginBtn2.setTitle("login".localiz(), for: .normal)
        accountAssistance2Lbl.text = "Are you a Fabricator ?".localiz()
        clickhere2Btn.setTitle("cliockHereBtn".localiz(), for: .normal)
        
    }


    @IBAction func selectClickhereBtn(_ sender: UIButton) {
        fabricatorAssistanceview2.isHidden = false
//        viewStatus = 1
    }
    
    @IBAction func selectTermCond2Btn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_TermsandCondtionVC") as? HR_TermsandCondtionVC
        vc?.delegate = self
        vc?.modalTransitionStyle = .coverVertical
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!, animated: true)
    }
    
    @IBAction func userNameTFEditingDidEnd(_ sender: Any) {
        if self.userNameTF.text?.count == 0 {
            self.view.makeToast("EntermembershipId".localiz(), duration: 2.0, position: .center)
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
                let parameter = [
                    "Location": [
                        "UserName": self.userNameTF.text ?? ""
                    ],
                    "ActionType": "69"
                ] as [String: Any]
                self.VM.verifyMobileNumberAPI(paramters: parameter)
            }
        }
    }
    
    @IBAction func selectClikHere2Btn(_ sender: UIButton) {
//        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_Login1VC") as? EBC_Login1VC
//        vc?.modalTransitionStyle = .crossDissolve
//        vc?.modalPresentationStyle  = .overFullScreen
//        present(vc!, animated: true)
        dismiss(animated: true)
//        viewStatus = 0
    }
    
    @IBAction func selectPasswordSecureBtn(_ sender: UIButton) {
        if passwordSecurestatus == 0{
            passwordSecureBtn.setImage(UIImage(named: "view"), for: .normal)
            passwordSecurestatus = 1
            passwordTF.isSecureTextEntry = false
        }else{
            passwordSecureBtn.setImage(UIImage(named: "hide-2"), for: .normal)
            passwordSecurestatus = 0
            passwordTF.isSecureTextEntry = true
        }
    }
    
    @IBAction func selectLogin2Btn(_ sender: UIButton) {
        
        if userNameTF.text?.count == 0{
            self.view.makeToast("Enter user name Mobile Number".localiz(),duration: 2.0,position: .center)
        }else if passwordTF.text?.count == 0{
            self.view.makeToast("Enter Password".localiz(),duration: 2.0,position: .center)
        } else if tc2Status == 0{
            self.view.makeToast("SelectTermsCondition".localiz(),duration: 2.0,position: .center)
        }else{
            
            let parameter = [
                "PushID": "sdfds",
                "Password": self.passwordTF.text ?? "",
                "UserName": self.userNameTF.text ?? "",
                 "UserActionType": "GetPasswordDetails",
                 "Browser": "IOS",
                 "LoggedDeviceName": "IOS",
                 "UserType": "Customer"
            ] as [String: Any]
            print(parameter)
            self.VM.loginSubmissionApi(parameter: parameter)

        }
        
    }
    
    @IBAction func backBtnt(_ sender: Any) {
        if self.itsFrom == 1{
            self.dismiss(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 20
        
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        
            if textField == userNameTF{
                let currentString: NSString = (userNameTF.text ?? "") as NSString
                let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
                return newString.length <= maxLength
            }
        return true
    }
}

