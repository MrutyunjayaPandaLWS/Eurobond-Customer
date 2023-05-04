//
//  EBC_Login1VC.swift
//  EuroBond_Customer
//
//  Created by admin on 10/04/23.
//

import UIKit
import Toast_Swift
import DPOTPView
import LanguageManager_iOS

class EBC_Login1VC: BaseViewController, CheckBoxSelectDelegate, DPOTPViewDelegate, UITextFieldDelegate, popUpAlertDelegate {
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    
    func accept(_ vc: HR_TermsandCondtionVC) {
        self.termCondBtn.setImage(UIImage(named: "fillcheckbox"), for: .normal)
        self.tcStatus = 1
    }
    
    func decline(_ vc: HR_TermsandCondtionVC) {
        self.termCondBtn.setImage(UIImage(named: "blankcheckbox"), for: .normal)
        self.tcStatus = 0
    }
    

    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var loginSubViewHeight: NSLayoutConstraint!
    @IBOutlet weak var submitButtonTopSpace: NSLayoutConstraint!
    @IBOutlet weak var otpSubmitView: DPOTPView!
    @IBOutlet weak var cliockHereBtn: UIButton!
    @IBOutlet weak var fabricatorMessagelbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var resendOtpBtn: UIButton!
    @IBOutlet weak var termCondView: UIView!
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var timmerLbl: UILabel!
    @IBOutlet weak var enterOtpLbl: UILabel!
    @IBOutlet weak var termCondBtn: UIButton!
    @IBOutlet weak var membershipIdTF: UITextField!
    @IBOutlet weak var membershipIdLbl: UILabel!
    @IBOutlet weak var registerLineLbl: UILabel!
    @IBOutlet weak var loginLineLbl: UILabel!
    @IBOutlet weak var registerLbl: UILabel!
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var loginInfoLbl: UILabel!
    @IBOutlet weak var logintitleLbl: UILabel!
    
    
    @IBOutlet var termsAndConditionsText: UIButton!
    
    var tcStatus = 0
    var loginBtnStatus = 0
    var submitBtnStatus = 0
    let isUserLoggedIn: Int = UserDefaults.standard.integer(forKey: "IsloggedIn?")
    
    var enteredValue = ""
    var receivedOTP = ""
    var categoryId = -1
    var enteredMobileNumber = ""

    var VM = EBC_LoginVM()
    
    
    var existance = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        otpSubmitView.dpOTPViewDelegate = self
        otpSubmitView.fontTextField = UIFont.systemFont(ofSize: 25)
        otpSubmitView.textEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        otpSubmitView.editingTextEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        localization()
        tokendata()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        otpView.isHidden = true
        resendOtpBtn.isHidden = true
        otpSubmitView.text = ""
        if self.isUserLoggedIn == -1{
            self.backButton.isHidden = true
        }else{
            self.backButton.isHidden = false
        }
        
        membershipIdTF.text = ""
        otpView.isHidden = true
        resendOtpBtn.isHidden = true
        termCondView.isHidden = false
        loginBtnStatus = 0
        loginLineLbl.backgroundColor = selectedColor1
        registerLineLbl.backgroundColor = .lightGray
        submitBtnStatus = 0
        
        membershipIdTF.placeholder = "EnterMembershipID/Moblienumber".localiz()
        membershipIdLbl.text = "EnterMembershipID/Moblienumber".localiz()
        
        submitBtn.setTitle("GenerateOTP".localiz(), for: .normal)
        self.submitButtonTopSpace.constant = 100
        self.loginSubViewHeight.constant = 300
        otpSubmitView.text = ""
        self.termCondBtn.setImage(UIImage(named: "blankcheckbox"), for: .normal)
        self.tcStatus = 0
        logintitleLbl.text = "login".localiz()
        loginInfoLbl.text = "PleaseEnterDetailsLogin".localiz()
    }

    
    func localization(){
        loginLbl.text = "login".localiz()
        registerLbl.text = "Register".localiz()
        fabricatorMessagelbl.text = "AreyouFabricatorAssistant".localiz()
        termsAndConditionsText.setTitle("IaccepttheTermsandConditions".localiz(), for: .normal)
        cliockHereBtn.setTitle("cliockHereBtn".localiz(), for: .normal)
    }
    
    
    
    @IBAction func selectloginBtn(_ sender: Any) {
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
            print(loginBtnStatus)
            if loginBtnStatus != 0 {
                membershipIdTF.text = ""
                membershipIdTF.placeholder = "EnterMembershipID/Moblienumber".localiz()
                membershipIdLbl.text = "EnterMembershipID/Moblienumber".localiz()
                membershipIdTF.keyboardType = .asciiCapable
                otpView.isHidden = true
                membershipIdTF.delegate = self
                resendOtpBtn.isHidden = true
                termCondView.isHidden = false
                loginBtnStatus = 0
                loginLineLbl.backgroundColor = selectedColor1
                registerLineLbl.backgroundColor = .lightGray
                submitBtnStatus = 0
                submitBtn.setTitle("GenerateOTP".localiz(), for: .normal)
                self.submitButtonTopSpace.constant = 100
                self.loginSubViewHeight.constant = 300
                otpSubmitView.text = ""
                self.termCondBtn.setImage(UIImage(named: "blankcheckbox"), for: .normal)
                self.tcStatus = 0
                logintitleLbl.text = "login".localiz()
                loginInfoLbl.text = "PleaseEnterDetailsLogin".localiz()
            }
        }
        
    }
    
    @IBAction func selectRegisterBtn(_ sender: UIButton) {
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
            print(loginBtnStatus)
            if loginBtnStatus != 1 {
                membershipIdTF.text = ""
                membershipIdTF.placeholder = "MobileNumber".localiz()
                membershipIdLbl.text = "MobileNumber".localiz()
                membershipIdTF.keyboardType = .numberPad
                membershipIdTF.delegate = self
                otpView.isHidden = true
                resendOtpBtn.isHidden = true
                termCondView.isHidden = true
                loginBtnStatus = 1
                loginLineLbl.backgroundColor = .lightGray
                logintitleLbl.text = "SignUp".localiz()
                loginInfoLbl.text = "PleaseEnterDetailsRegister".localiz()
                registerLineLbl.backgroundColor = selectedColor1
                submitBtnStatus = 0
                submitBtn.setTitle("GenerateOTP".localiz(), for: .normal)
                otpSubmitView.text = ""
                self.submitButtonTopSpace.constant = 70
                self.loginSubViewHeight.constant = 300
            }
        }
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let secondLength = 10
//        if loginBtnStatus == 1 {
            if textField == membershipIdTF{
                let currentString: NSString = (membershipIdTF.text ?? "") as NSString
                let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
                return newString.length <= maxLength
            }
        return true
    }
    
    @IBAction func selectTermCondBtn(_ sender: Any) {
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
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_TermsandCondtionVC") as? HR_TermsandCondtionVC
            vc?.delegate = self
            vc?.modalTransitionStyle = .coverVertical
            vc?.modalPresentationStyle = .overFullScreen
            present(vc!, animated: true)
        }
    }
    
    @IBAction func selectResendOtpBtn(_ sender: UIButton) {
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
            
            if self.membershipIdTF.text?.count == 0 {
                if loginBtnStatus != 1 {
                    self.view.makeToast("EnterMobileNumber".localiz(), duration: 2.0, position: .bottom)
                }else{
                    self.view.makeToast("EnterMembershipID/Moblienumber".localiz(), duration: 2.0, position: .bottom)
                }
            }else{
                let parameter = [
                    "OTPType": "Enrollment",
                    "UserId": -1,
                    "MobileNo": self.membershipIdTF.text ?? "",
                    "UserName": "",
                    "MerchantUserName": "EuroBondMerchantDemo"
                ] as [String: Any]
                self.VM.getOTPApi(parameter: parameter)
            }
        }
    }
    
    @IBAction func selectClickHereBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBS_LoginVC") as? EBS_LoginVC
        vc?.itsFrom = 1
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle  = .overFullScreen
        present(vc!, animated: true)
        
    }
    
    @IBAction func selectSubmitBtn(_ sender: Any) {
        
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
            
            if membershipIdTF.text?.count == 0{
                if loginBtnStatus != 1 {
                    self.view.makeToast("EnterMembershipID/Moblienumber".localiz(),duration: 2.0,position: .center)
                }else{
                    self.view.makeToast("EnterMobileNumber".localiz(),duration: 2.0,position: .center)
                }
                
            }else{
                if loginBtnStatus == 0 {
                    if tcStatus != 1{
                        self.view.makeToast("SelectTermsCondition".localiz(),duration: 2.0,position: .center)
                    }else{
                        let parameterJSON = [
                            "Location": [
                                "UserName": self.membershipIdTF.text ?? ""
                            ],
                            "ActionType": "68"
                        ] as [String:Any]
                        print(parameterJSON)
                        self.VM.verifyMobileNumberAPI(paramters: parameterJSON)
                    }
                }else if self.loginBtnStatus == 2{
                    if tcStatus != 1{
                        self.view.makeToast("SelectTermsCondition".localiz(),duration: 2.0,position: .center)
                    }else if submitBtnStatus == 0{
                        submitBtn.setTitle("Submit".localiz(), for: .normal)
                        otpView.isHidden = false
                        termCondView.isHidden = true
                        submitBtnStatus = 1
                        self.submitButtonTopSpace.constant = 190
                        self.loginSubViewHeight.constant = 429
                        
                    }else if otpSubmitView.text?.count == 0{
                        self.view.makeToast("EnterOTP".localiz(),duration: 2.0,position: .center)
                    }else if enteredValue != self.receivedOTP{
                        print(enteredValue)
                        print(receivedOTP)
                        self.view.makeToast("EnterCorrectOTP".localiz(),duration: 2.0,position: .center)
                        otpSubmitView.text = ""
                    }else{
                        
                        // Login Submission Api
                        let parameter = [
                            "LoggedDeviceName": "IOS",
                            "UserActionType": "GetPasswordDetails",
                            "Password": "123456",
                            "Browser": "IOS",
                            "PushID": "",
                            "UserType": "Customer",
                            "UserName": self.membershipIdTF.text ?? ""
                        ] as [String: Any]
                        print(parameter)
                        self.VM.loginSubmissionApi(parameter: parameter)
                        
                    }
                }else{
                    if submitBtnStatus == 0{
                        if self.membershipIdTF.text!.count == 10{
                            let parameterJSON = [
                                "Location": [
                                    "UserName": self.membershipIdTF.text ?? ""
                                ],
                                "ActionType": "68"
                            ] as [String:Any]
                            print(parameterJSON)
                            self.VM.verifyMobileNumberAPI1(paramters: parameterJSON)
                        }else{
                            self.view.makeToast("Entervalidmobilernumber".localiz(),duration: 2.0,position: .center)
                        }
                    }else if otpSubmitView.text?.count == 0{
                        self.view.makeToast("EnterOTP".localiz(),duration: 2.0,position: .center)
                    }else if enteredValue != self.receivedOTP{
                        self.view.makeToast("EnterCorrectOTP".localiz(),duration: 2.0,position: .center)
                        otpSubmitView.text = ""
                    } else{
                        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RefferalVC") as? EBC_RefferalVC
                        vc?.enteredMobile = self.membershipIdTF.text ?? ""
                        navigationController?.pushViewController(vc!, animated: true)
                    }
                    
                }
                
            }
        }
    }
    
    
    func tokendata(){
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            }else{
                let parameters : Data = "username=\(username)&password=\(password)&grant_type=password".data(using: .utf8)!

            let url = URL(string: tokenURL)!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            do {
                 request.httpBody = parameters
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
           
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do{
                    let parseddata = try JSONDecoder().decode(TokenModels.self, from: data)
                        print(parseddata.access_token ?? "")
                        UserDefaults.standard.setValue(parseddata.access_token ?? "", forKey: "TOKEN")
                     }catch let parsingError {
                    print("Error", parsingError)
                }
            })
            task.resume()
        }
        }
    
    
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func dpOTPViewAddText(_ text: String, at position: Int) {
        print("addText:- " + text + " at:- \(position)" )
        self.enteredValue = "\(text)"
    }
    
    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        print("removeText:- " + text + " at:- \(position)" )
        self.enteredValue = "\(text)"
    }
    
    func dpOTPViewChangePositionAt(_ position: Int) {
        print("at:-\(position)")
    }
    func dpOTPViewBecomeFirstResponder() {
        
    }
    func dpOTPViewResignFirstResponder() {
        
    }
}
