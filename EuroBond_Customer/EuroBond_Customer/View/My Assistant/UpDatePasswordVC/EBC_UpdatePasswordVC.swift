//
//  EBC_UpdatePasswordVC.swift
//  EuroBond_Customer
//
//  Created by admin on 31/03/23.
//

import UIKit
import LanguageManager_iOS

protocol UpdatePasswordVCDelegate{
    func showSusccesMessage(item: EBC_UpdatePasswordVC)
}

class EBC_UpdatePasswordVC: BaseViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var updatePassword: UIButton!
    @IBOutlet weak var resestPasswordTF: UITextField!
    @IBOutlet weak var resetPasswordLbl: UILabel!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var updatePasswordTitle: UILabel!
    var delegate: UpdatePasswordVCDelegate?
    var mobile = ""
    var userLoyaltyId = ""
    var name = ""
    var VM = UpdateFabricatedPasswordVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.nameTF.text = self.name
        self.mobileNumberTF.text = self.mobile
        nameTF.isUserInteractionEnabled = false
        mobileNumberTF.isUserInteractionEnabled = false
        
    }
    
    override func touchesBegan(_ touchscreen: Set<UITouch>, with event: UIEvent?)
      {
          let touch = touchscreen.first
          if touch?.view == self.view{
                  self.dismiss(animated: true, completion: nil)
              }
      }
    
    func localizSetup(){
        self.updatePassword.setTitle("Update Password".localiz(), for: .normal)
        self.resestPasswordTF.placeholder = "EnterMobileNumber".localiz()
        self.resetPasswordLbl.text = "Rest Password".localiz()
        self.mobileNumberTF.placeholder = "EnterMobileNumber".localiz()
        self.mobileNumberLbl.text = "Mobile Number".localiz()
        self.nameTF.placeholder = "Enter Name".localiz()
        self.nameLbl.text = "Name".localiz()
        self.updatePasswordTitle.text = "Update Password".localiz()
    }
    
    @IBAction func selectUpdatePasswordBtn(_ sender: UIButton) {
        if resestPasswordTF.text?.count == 0{
            self.view.makeToast("Enter new password".localiz(),duration: 2.0,position: .center)
        }else{
//            dismiss(animated: true)
//            delegate?.showSusccesMessage(item: self)
            let parameter = [
                "Password": self.resestPasswordTF.text ?? "",
                 "UserActionType": "UpdateChangedPassword",
                "UserName": self.userLoyaltyId
            ] as [String: Any]
            self.VM.updatePasswordApi(parameter: parameter)
            
        }
    }
    
    
    
    
    

}
