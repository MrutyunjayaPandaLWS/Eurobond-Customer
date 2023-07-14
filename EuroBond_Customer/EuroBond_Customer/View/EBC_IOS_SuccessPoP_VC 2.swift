//
//  HR_SuccessPoP_VC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/10/22.
//

import UIKit
import LanguageManager_iOS

class EBC_IOS_SuccessPoP_VC: BaseViewController {

    @IBOutlet var messageLbl: UILabel!
   // @IBOutlet var dashboardOutBtn: UIButton!
    var productName = ""
    var totalAmount = ""
    var isComeFrom = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLbl.text = ""
        
        if isComeFrom == "BankSuccess" {
            self.messageLbl.text = "\("Congratulations".localiz()) \n \("Entered amount has been transferred to your bank account".localiz())"
        } else if isComeFrom == "PaytmSuccess" {
            self.messageLbl.text = "\("Congratulations".localiz()) \n \("Entered amount has been transferred to your paytm number".localiz())"
        } else if isComeFrom == "VoucherSuccess" {
            self.messageLbl.text = "\("Thank_you_for_redeeming".localiz()) \n \("The_E-voucher_will_sent_email_id_shortly".localiz())"
        }
       // self.okButton.setTitle("OK".localiz(), for: .normal)

    }
    

    @IBAction func backBTN(_ sender: Any) {
//        NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
        self.dismiss(animated: true){
//            self.navigationController?.popToRootViewController(animated: true)
            //static let navigateToDashBoard = Notification.Name(rawValue: "navigateToDashBoard")
            NotificationCenter.default.post(name: .showPopUp, object: nil)
        }
    }
    
}
