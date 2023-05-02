//
//  EBC_RegisterAssistantVC.swift
//  EuroBond_Customer
//
//  Created by admin on 31/03/23.
//

import UIKit
import DPOTPView
import Toast_Swift
import LanguageManager_iOS

protocol RegisterAssistantDelegate{
    func successMessage(itme: EBC_RegisterAssistantVC)
}

class EBC_RegisterAssistantVC: BaseViewController, UITextFieldDelegate, DPOTPViewDelegate{
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
    
    @IBOutlet weak var successView: UIView!
    
    @IBOutlet weak var registrationView: UIView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var otpBtn: UIButton!
    @IBOutlet weak var resendBtnView: UIView!
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var otpView: DPOTPView!
    @IBOutlet weak var timmerView: UIView!
    @IBOutlet weak var otpTimmerLbl: UILabel!
    @IBOutlet weak var enterOtpTitleLbl: UILabel!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var registerTitle: UILabel!
    var timmer = Timer()
    var otpBtnStatus = 0
    var delegate: RegisterAssistantDelegate?
    var VM = EBC_MyAssistantRegisterVM()
    var requestAPIs = RestAPI_Requests()
    var enteredValue = ""
    var receivedOTP = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        otpView.text = ""
        self.successView.isHidden = true
        self.VM.VC = self
        timmerView.isHidden = true
        otpView.isHidden = true
        otpTimmerLbl.isHidden = false
        resendBtnView.isHidden = true
        editBtn.isHidden = true
        mobileNumberTF.keyboardType = .asciiCapableNumberPad
        mobileNumberTF.delegate = self
        self.otpBtn.setTitle("GenerateOTP".localiz(), for: .normal)
        otpView.dpOTPViewDelegate = self
        otpView.fontTextField = UIFont.systemFont(ofSize: 25)
        otpView.textEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        otpView.editingTextEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.otpTimmerLbl.text = "00:60"
        localizSetup()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view{
            dismiss(animated: true)
        }
    }
    
    
    func localizSetup(){
        self.nameLbl.text = "Name".localiz()
        self.nameTF.placeholder = "Enter Name".localiz()
        self.mobileNumberLbl.text = "Mobile Number".localiz()
        self.mobileNumberTF.placeholder = "EnterMobileNumber".localiz()
        self.registerTitle.text = "Register".localiz()
        self.otpBtn.setTitle("GenerateOTP".localiz(), for: .normal)
    }
    
    
    @IBAction func selectResendBtn(_ sender: UIButton) {
        if self.nameTF.text?.count == 0 {
            self.view.makeToast("Enter Name".localiz(), duration: 2.0, position: .center)
        }else{
            if self.mobileNumberTF.text!.count == 0{
                self.view.makeToast("EnterMobileNumber".localiz(), duration: 2.0, position: .center)
            }else if self.mobileNumberTF.text!.count != 10{
                self.view.makeToast("Entervalidmobilernumber".localiz(), duration: 2.0, position: .center)
            }else{
                let parameter = [
                    "Location": [
                        "UserName": self.mobileNumberTF.text ?? ""
                    ],
                    "ActionType": "69"
                ] as [String: Any]
                self.VM.verifyMobileNumberAPI(paramters: parameter)
            }
            
        }
    }
    
    @IBAction func selectOtpBtn(_ sender: UIButton) {
        
        if self.otpBtn.currentTitle == "GenerateOTP".localiz(){
            if self.nameTF.text?.count == 0 {
                self.view.makeToast("Enter Name".localiz(), duration: 2.0, position: .center)
            }else{
                if self.mobileNumberTF.text!.count == 0{
                    self.view.makeToast("EnterMobileNumber".localiz(), duration: 2.0, position: .center)
                }else if self.mobileNumberTF.text!.count != 10{
                    self.view.makeToast("Entervalidmobilernumber".localiz(), duration: 2.0, position: .center)
                }else{
                    let parameter = [
                        "Location": [
                            "UserName": self.mobileNumberTF.text ?? ""
                        ],
                        "ActionType": "69"
                    ] as [String: Any]
                    self.VM.verifyMobileNumberAPI(paramters: parameter)
                }
                
            }
        }else{
            if otpBtnStatus == 0{
                otpBtn.setTitle("Submit", for: .normal)
                timmerView.isHidden = false
                otpView.isHidden = false
                nameView.isHidden = true
                editBtn.isHidden = false
                mobileNumberTF.isUserInteractionEnabled = false
                otpBtnStatus = 1
            }else
            {
                if otpView.text?.count == 0{
                    self.view.makeToast("EnterOTP".localiz(),duration: 2.0,position: .center)
                }else if otpView.text?.count != 6{
                    self.view.makeToast("Enter valid OTP".localiz(),duration: 2.0,position: .center)
                }else if enteredValue != self.receivedOTP {
                    self.view.makeToast("EnterCorrectOTP".localiz(),duration: 2.0,position: .center)
                }else{
                    self.VM.timer.invalidate()
                    let parameter = [
                        "ActionType": "0",
                        "ObjCustomer": [
                            "FirstName": self.nameTF.text ?? "",
                            "CustomerMobile": self.mobileNumberTF.text ?? "",
                            "RegistrationSource": "2",// for IOS=>2, Android=3
                            "MerchantId": "1",//hardcoded
                            "IsActive": "1",//hardcoded
                            "CustomerTypeID": "70"//hardcoded
                        ],
                        "HierarchyMapDetails": [
                            "CustomerUserID": self.userId, //Curretly Logged in user id
                            "UserUserID": ""
                        ]
                    ] as [String : Any]
                    print(parameter)
                    self.VM.registerSubmission(parameter: parameter)
                    
                }
                
            }
            
        }
    }
        

    
    @IBAction func selectMobileNumberEditBtn(_ sender: Any) {
        otpBtn.setTitle("GenerateOTP".localiz(), for: .normal)
        timmerView.isHidden = true
        otpView.isHidden = true
        nameView.isHidden = false
        editBtn.isHidden = true
        mobileNumberTF.isUserInteractionEnabled = true
        otpTimmerLbl.isHidden = true
        resendBtnView.isHidden = true
        otpBtnStatus = 0
        
    }
   
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
      let compSepByCharInSet = string.components(separatedBy: aSet)
      let numberFiltered = compSepByCharInSet.joined(separator: "")

      if string == numberFiltered {
        let currentText = mobileNumberTF.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 10
      } else {
        return false
      }
    }

}
