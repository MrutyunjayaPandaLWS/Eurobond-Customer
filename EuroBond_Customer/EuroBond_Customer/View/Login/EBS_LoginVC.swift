//
//  EBS_LoginVC.swift
//  EuroBond_Customer
//
//  Created by syed on 17/03/23.
//

import UIKit

class EBS_LoginVC: UIViewController {

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
    @IBOutlet weak var termCondViewHeight: NSLayoutConstraint!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func selectLoginBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func selectRegisterBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectTermCondBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectGererateOtpBtn(_ sender: UIButton) {
        UserDefaults.standard.setValue(true, forKey: "IsloggedIn?")
        if #available(iOS 13.0, *) {
            let sceneDelegate = self.view.window!.windowScene!.delegate as! SceneDelegate
            sceneDelegate.setHomeAsRootViewController()
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.setHomeAsRootViewController()
        }
    }
    
    @IBAction func selectClickhereBtn(_ sender: UIButton) {
        fabricatorView.isHidden = true
        fabricatorAssistanceview2.isHidden = false
    }
    
    @IBAction func selectTermCond2Btn(_ sender: UIButton) {
    }
    
    
    @IBAction func selectClikHere2Btn(_ sender: UIButton) {
        fabricatorView.isHidden = false
        fabricatorAssistanceview2.isHidden = true
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
    }
}

