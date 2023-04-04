//
//  EBC_RegisterAssistantVC.swift
//  EuroBond_Customer
//
//  Created by admin on 31/03/23.
//

import UIKit
import DPOTPView
//import Toast_Swift

protocol RegisterAssistantDelegate{
    func successMessage(itme: EBC_RegisterAssistantVC)
}

class EBC_RegisterAssistantVC: UIViewController {

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
    override func viewDidLoad() {
        super.viewDidLoad()
        timmerView.isHidden = true
        otpView.isHidden = true
        otpTimmerLbl.isHidden = true
        resendBtnView.isHidden = true
        editBtn.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view{
            dismiss(animated: true)
        }
    }
    
    @IBAction func selectResendBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectOtpBtn(_ sender: UIButton) {
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
//                self.view.makeToast("Enter OTP",duration: 2.0,position: .center)
            }else if otpView.text?.count != 6{
//                self.view.makeToast("Enter valid OTP",duration: 2.0,position: .center)
            }else if otpView.text != "123456"{
//                self.view.makeToast("Enter wrong OTP",duration: 2.0,position: .center)
            }else{
                dismiss(animated: true)
                delegate?.successMessage(itme: self)
            }
            
        }
        
    }
    
    @IBAction func selectMobileNumberEditBtn(_ sender: Any) {
        otpBtn.setTitle("Generate OTP", for: .normal)
        timmerView.isHidden = true
        otpView.isHidden = true
        nameView.isHidden = false
        editBtn.isHidden = true
        mobileNumberTF.isUserInteractionEnabled = true
        otpTimmerLbl.isHidden = true
        resendBtnView.isHidden = true
        otpBtnStatus = 0
        
    }
    
    

}
