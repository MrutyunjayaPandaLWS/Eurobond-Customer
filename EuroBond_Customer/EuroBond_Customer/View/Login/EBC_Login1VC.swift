//
//  EBC_Login1VC.swift
//  EuroBond_Customer
//
//  Created by admin on 10/04/23.
//

import UIKit
import Toast_Swift
import DPOTPView

class EBC_Login1VC: BaseViewController, CheckBoxSelectDelegate, DPOTPViewDelegate {
    
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
    var tcStatus = 0
    var loginBtnStatus = 0
    var submitBtnStatus = 0
    let isUserLoggedIn: Int = UserDefaults.standard.integer(forKey: "IsloggedIn?")
    
    var enteredValue = ""
    var receivedOTP = ""
    var categoryId = -1
    var enteredMobileNumber = ""

    var VM = EBC_LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        otpSubmitView.dpOTPViewDelegate = self
        otpSubmitView.fontTextField = UIFont.systemFont(ofSize: 25)
        otpSubmitView.textEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        otpSubmitView.editingTextEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        submitBtn.setTitle("Generate OTP", for: .normal)
        self.submitButtonTopSpace.constant = 100
        self.loginSubViewHeight.constant = 300
        otpSubmitView.text = ""
        self.termCondBtn.setImage(UIImage(named: "blankcheckbox"), for: .normal)
        self.tcStatus = 0
        logintitleLbl.text = "Login"
        loginInfoLbl.text = "Please enter the details to login"
    }

    @IBAction func selectloginBtn(_ sender: Any) {
        if loginBtnStatus != 0 {
            membershipIdTF.text = ""
            otpView.isHidden = true
            resendOtpBtn.isHidden = true
            termCondView.isHidden = false
            loginBtnStatus = 0
            loginLineLbl.backgroundColor = selectedColor1
            registerLineLbl.backgroundColor = .lightGray
            submitBtnStatus = 0
            submitBtn.setTitle("Generate OTP", for: .normal)
            self.submitButtonTopSpace.constant = 100
            self.loginSubViewHeight.constant = 300
            otpSubmitView.text = ""
            self.termCondBtn.setImage(UIImage(named: "blankcheckbox"), for: .normal)
            self.tcStatus = 0
            logintitleLbl.text = "Login"
            loginInfoLbl.text = "Please enter the details to login"
        }
        
    }
    
    @IBAction func selectRegisterBtn(_ sender: UIButton) {
        if loginBtnStatus != 1 {
            membershipIdTF.text = ""
            otpView.isHidden = true
            resendOtpBtn.isHidden = true
            termCondView.isHidden = true
            loginBtnStatus = 1
            loginLineLbl.backgroundColor = .lightGray
            logintitleLbl.text = "SignUp"
            loginInfoLbl.text = "Please enter the details to register"
            registerLineLbl.backgroundColor = selectedColor1
            submitBtnStatus = 0
            submitBtn.setTitle("Generate OTP", for: .normal)
            otpSubmitView.text = ""
            self.submitButtonTopSpace.constant = 70
            self.loginSubViewHeight.constant = 300
        }
    }
    
    @IBAction func selectTermCondBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_TermsandCondtionVC") as? HR_TermsandCondtionVC
        vc?.delegate = self
        vc?.modalTransitionStyle = .coverVertical
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!, animated: true)
    }
    
    @IBAction func selectResendOtpBtn(_ sender: UIButton) {

        if self.membershipIdTF.text?.count == 0 {
            self.view.makeToast("Enter mobile number", duration: 2.0, position: .bottom)
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
    
    @IBAction func selectClickHereBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBS_LoginVC") as? EBS_LoginVC
        vc?.itsFrom = 1
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle  = .overFullScreen
        present(vc!, animated: true)    }
    
    @IBAction func selectSubmitBtn(_ sender: Any) {
        if membershipIdTF.text?.count == 0{
            self.view.makeToast("Enter membershipID",duration: 2.0,position: .center)
        }else{
            if loginBtnStatus == 0 {
                if tcStatus != 1{
                    self.view.makeToast("Select terms ad condition",duration: 2.0,position: .center)
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
                    self.view.makeToast("Select terms ad condition",duration: 2.0,position: .center)
                }else if submitBtnStatus == 0{
                    submitBtn.setTitle("Submit", for: .normal)
                    otpView.isHidden = false
                    termCondView.isHidden = true
                    submitBtnStatus = 1
                    self.submitButtonTopSpace.constant = 190
                    self.loginSubViewHeight.constant = 429
                    
                }else if otpSubmitView.text?.count == 0{
                    self.view.makeToast("Enter OTP",duration: 2.0,position: .center)
                }else if enteredValue != self.receivedOTP{
                    print(enteredValue)
                    print(receivedOTP)
                    self.view.makeToast("Enter correct OTP",duration: 2.0,position: .center)
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
                        self.view.makeToast("Enter valid mobiler number",duration: 2.0,position: .center)
                    }
                }else if otpSubmitView.text?.count == 0{
                    self.view.makeToast("Enter OTP",duration: 2.0,position: .center)
                }else if enteredValue != self.receivedOTP{
                    self.view.makeToast("Enter correct OTP",duration: 2.0,position: .center)
                    otpSubmitView.text = ""
                } else{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RefferalVC") as? EBC_RefferalVC
                    vc?.enteredMobile = self.membershipIdTF.text ?? ""
                    navigationController?.pushViewController(vc!, animated: true)
                }
                
            }
            
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
