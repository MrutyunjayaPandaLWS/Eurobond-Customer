//
//  EBS_LoginVC.swift
//  EuroBond_Customer
//
//  Created by syed on 17/03/23.
//

import UIKit
import DPOTPView
import Toast_Swift

class EBS_LoginVC: UIViewController, TermsAndConditionDelegate {
    func didTappedTermsAndConditionBtn(item: EBC_TermsAndCondition1VC) {
//        if item.termsAndCondStatus == 1 && viewStatus == 0{
//            checkBoxBtn.setImage(UIImage(named: "fillcheckbox"), for: .normal)
//            tc1Status = 1
//        }else if item.termsAndCondStatus == 0 && viewStatus == 0{
//            checkBoxBtn.setImage(UIImage(named: "blankcheckbox"), for: .normal)
//            tc1Status = 0
//        }
//
        if item.termsAndCondStatus == 1 {
            chechBox2Btn.setImage(UIImage(named: "fillcheckbox"), for: .normal)
            tc2Status = 1
        }else if item.termsAndCondStatus == 0{
            chechBox2Btn.setImage(UIImage(named: "blankcheckbox"), for: .normal)
            tc2Status = 0
        }
    }
    

    @IBOutlet weak var resendOtpBtn: UIButton!
    @IBOutlet weak var otpSubmitView: DPOTPView!
    @IBOutlet weak var otpTimmerLbl: UILabel!
    @IBOutlet weak var enterOtpTitle: UILabel!
    @IBOutlet weak var resendOtpView: UIView!
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var termAndConditionview: UIView!
    @IBOutlet weak var passwordSecureBtn: UIButton!
    @IBOutlet weak var fabricatorView: UIView!
    @IBOutlet weak var fabricatorAssistanceview2: UIView!
    @IBOutlet weak var accountAssistance2Lbl: UILabel!
    @IBOutlet weak var clickhere2Btn: UIButton!
    @IBOutlet weak var loginBtn2: UIButton!
    @IBOutlet weak var termCond2Lbl: UILabel!
    @IBOutlet weak var chechBox2Btn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var login2InfoLbl: UILabel!
    @IBOutlet weak var login2TitleLbl: UILabel!
    @IBOutlet weak var accountAssistanceLbl: UILabel!
    @IBOutlet weak var generateOtpBtn: UIButton!
    @IBOutlet weak var termCondLbl: UILabel!
    @IBOutlet weak var checkBoxBtn: UIButton!
    @IBOutlet weak var membershipIDTF: UITextField!
    @IBOutlet weak var membershipId: UILabel!
    @IBOutlet weak var registerLineLbl: UILabel!
    @IBOutlet weak var registerBtn: UILabel!
    @IBOutlet weak var loginLineLbl: UILabel!
    @IBOutlet weak var loginBtn: UILabel!
    @IBOutlet weak var loginInfoLbl: UILabel!
    @IBOutlet weak var loginTitleLbl: UILabel!

    var passwordSecurestatus = 0
    var viewStatus = 0
    var tc1Status = 0
    var tc2Status = 0
    var otpGenerateBtnStatus = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTF.isSecureTextEntry = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fabricatorAssistanceview2.isHidden = false
        fabricatorView.isHidden = true
        resendOtpView.isHidden = true
        
    }
    
    @IBAction func selectLoginBtn(_ sender: UIButton) {
        
        
    }
    
    @IBAction func selectRegisterBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectTermCondBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_TermsAndCondition1VC") as? EBC_TermsAndCondition1VC
        vc?.delegate = self
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectGererateOtpBtn(_ sender: UIButton) {
        
      
        if tc1Status == 0{
            self.view.makeToast("Select terms and conditions",duration: 2.0,position: .center)
            }else{
            if otpGenerateBtnStatus == 0{
                termAndConditionview.isHidden = true
                otpView.isHidden = false
                generateOtpBtn.setTitle("Submit", for: .normal)
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
        }
        
        
    }
    
    @IBAction func mobileNumberTFAct(_ sender: Any) {
        if self.membershipIDTF.text?.count ?? 0 == 0{
            DispatchQueue.main.async{
                
            }
        }else{
            let parameterJSON = [
                    "ActionType": "11",
                    "Location":[
                        "UserName":"\(self.membershipIDTF.text ?? "")"
                    ]
            ] as [String:Any]
            print(parameterJSON)
//            self.VM.verifyMobileNumberAPI(paramters: parameterJSON)
        }
        
        
        
        
    }
    @IBAction func selectClickhereBtn(_ sender: UIButton) {
        fabricatorView.isHidden = true
        fabricatorAssistanceview2.isHidden = false
//        viewStatus = 1
    }
    
    @IBAction func selectResendBtn(_ sender: UIButton) {
    }
    @IBAction func selectTermCond2Btn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_TermsAndCondition1VC") as? EBC_TermsAndCondition1VC
        vc?.delegate = self
        vc?.modalTransitionStyle = .coverVertical
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!, animated: true)
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

                UserDefaults.standard.setValue(2, forKey: "IsloggedIn?")
                if #available(iOS 13.0, *) {
                    let sceneDelegate = self.view.window!.windowScene!.delegate as! SceneDelegate
                    sceneDelegate.setHomeAsRootViewController2()
                } else {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.setHomeAsRootViewController2()
                }
        }
        
    }
}

