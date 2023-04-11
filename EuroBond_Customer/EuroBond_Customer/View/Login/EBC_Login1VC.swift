//
//  EBC_Login1VC.swift
//  EuroBond_Customer
//
//  Created by admin on 10/04/23.
//

import UIKit
import Toast_Swift
import DPOTPView

class EBC_Login1VC: UIViewController, TermsAndConditionDelegate {
    func didTappedTermsAndConditionBtn(item: EBC_TermsAndCondition1VC) {
        if item.termsAndCondStatus == 1 {
            termCondBtn.setImage(UIImage(named: "fillcheckbox"), for: .normal)
            tcStatus = 1
        }else if item.termsAndCondStatus == 0{
            termCondBtn.setImage(UIImage(named: "blankcheckbox"), for: .normal)
            tcStatus = 0
        }
    }
    

    
    
    @IBOutlet weak var otpSubmitView: DPOTPView!
    @IBOutlet weak var cliockHereBtn: UIButton!
    @IBOutlet weak var fabricatorMessagelbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var resendOtpBtn: UIButton!
    @IBOutlet weak var resendView: UIView!
    @IBOutlet weak var termCondView: UIView!
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var timmerLbl: UILabel!
    @IBOutlet weak var enterOtpLbl: UILabel!
    @IBOutlet weak var termCondBtn: UIButton!
    @IBOutlet weak var termCondLbl: UILabel!
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
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        otpView.isHidden = true
        resendView.isHidden = true
        otpSubmitView.text = ""
    }

    @IBAction func selectloginBtn(_ sender: Any) {
        if loginBtnStatus != 0 {
            membershipIdTF.text = ""
            otpView.isHidden = true
            resendView.isHidden = true
            termCondView.isHidden = false
            loginBtnStatus = 0
            loginLineLbl.backgroundColor = selectedColor1
            registerLineLbl.backgroundColor = .lightGray
            submitBtnStatus = 0
            submitBtn.setTitle("Generate OTP", for: .normal)
            otpSubmitView.text = ""
        }
        
    }
    
    @IBAction func selectRegisterBtn(_ sender: UIButton) {
        if loginBtnStatus != 1 {
            membershipIdTF.text = ""
            otpView.isHidden = true
            resendView.isHidden = true
            termCondView.isHidden = false
            loginBtnStatus = 1
            loginLineLbl.backgroundColor = .lightGray
            registerLineLbl.backgroundColor = selectedColor1
            submitBtnStatus = 0
            submitBtn.setTitle("Generate OTP", for: .normal)
            otpSubmitView.text = ""
        }
    }
    
    @IBAction func selectTermCondBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_TermsAndCondition1VC") as? EBC_TermsAndCondition1VC
        vc?.delegate = self
        vc?.modalTransitionStyle = .coverVertical
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!, animated: true)
    }
    
    @IBAction func selectResendOtpBtn(_ sender: UIButton) {
        resendView.isHidden = true
    }
    
    @IBAction func selectClickHereBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBS_LoginVC") as? EBS_LoginVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle  = .overFullScreen
        present(vc!, animated: true)    }
    
    @IBAction func selectSubmitBtn(_ sender: Any) {
        if membershipIdTF.text?.count == 0{
            self.view.makeToast("Enter membershipID",duration: 2.0,position: .center)
        }else if tcStatus != 1{
            self.view.makeToast("Select terms ad condition",duration: 2.0,position: .center)
        }else{
            if loginBtnStatus == 0 {
                if submitBtnStatus == 0{
                    submitBtn.setTitle("Submit", for: .normal)
                    otpView.isHidden = false
                    termCondView.isHidden = true
                    submitBtnStatus = 1
                }else if otpSubmitView.text?.count == 0{
                    self.view.makeToast("Enter OTP",duration: 2.0,position: .center)
                }else if otpSubmitView.text != "123456"{
                    self.view.makeToast("Wrong OTP, Try again",duration: 2.0,position: .center)
                    otpSubmitView.text = ""
                }else{
                    UserDefaults.standard.setValue(1, forKey: "IsloggedIn?")
                    if #available(iOS 13.0, *) {
                        let sceneDelegate = self.view.window!.windowScene!.delegate as! SceneDelegate
                        sceneDelegate.setHomeAsRootViewController()
                    } else {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.setHomeAsRootViewController()
                    }
                }
            }else{
                if submitBtnStatus == 0{
                    submitBtn.setTitle("Submit", for: .normal)
                    otpView.isHidden = false
                    termCondView.isHidden = true
                    submitBtnStatus = 1
                }else if otpSubmitView.text?.count == 0{
                    self.view.makeToast("Enter OTP",duration: 2.0,position: .center)
                }else if otpSubmitView.text != "123456"{
                    self.view.makeToast("Wrong OTP, Try again",duration: 2.0,position: .center)
                    otpSubmitView.text = ""
                } else{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RefferalVC") as? EBC_RefferalVC
                    navigationController?.pushViewController(vc!, animated: true)
                }
                
            }
            
        }
    }
    
    
    @IBAction func selectMembershipIDTF(_ sender: Any) {
        
        if self.membershipIdTF.text?.count ?? 0 == 0{
            DispatchQueue.main.async{
                
            }
        }else{
            let parameterJSON = [
                    "ActionType": "11",
                    "Location":[
                        "UserName":"\(self.membershipIdTF.text ?? "")"
                    ]
            ] as [String:Any]
            print(parameterJSON)
//            self.VM.verifyMobileNumberAPI(paramters: parameterJSON)
        }
    }
    
    
}
