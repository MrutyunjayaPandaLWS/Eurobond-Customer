//
//  EBC_UpdatePasswordVC.swift
//  EuroBond_Customer
//
//  Created by admin on 31/03/23.
//

import UIKit
import Toast_Swift

protocol UpdatePasswordVCDelegate{
    func showSusccesMessage(item: EBC_UpdatePasswordVC)
}

class EBC_UpdatePasswordVC: UIViewController {

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
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTF.text = "max"
        nameTF.isUserInteractionEnabled = false
        mobileNumberTF.isUserInteractionEnabled = false
        mobileNumberTF.text = "7205638899"
    }
    
    override func touchesBegan(_ touchscreen: Set<UITouch>, with event: UIEvent?)
      {
          let touch = touchscreen.first
          if touch?.view == self.view{
                  self.dismiss(animated: true, completion: nil)
              }
      }
    

    
    @IBAction func selectUpdatePasswordBtn(_ sender: UIButton) {
        if resestPasswordTF.text?.count == 0{
            self.view.makeToast("Enter password",duration: 2.0,position: .center)
        }else{
            dismiss(animated: true)
            delegate?.showSusccesMessage(item: self)
        }
    }
    
    
    
    
    

}
