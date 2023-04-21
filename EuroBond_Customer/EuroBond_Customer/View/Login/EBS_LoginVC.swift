//
//  EBS_LoginVC.swift
//  EuroBond_Customer
//
//  Created by syed on 17/03/23.
//

import UIKit
import DPOTPView
import Toast_Swift

class EBS_LoginVC: BaseViewController, CheckBoxSelectDelegate  {

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fabricatorAssistanceview2.isHidden = false
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
            self.view.makeToast("Enter membership Id", duration: 2.0, position: .center)
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
            self.view.makeToast("Enter user name",duration: 2.0,position: .center)
        }else if passwordTF.text?.count == 0{
            self.view.makeToast("Enter Password",duration: 2.0,position: .center)
        } else if tc2Status == 0{
            self.view.makeToast("Select terms and conditions",duration: 2.0,position: .center)
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
}

