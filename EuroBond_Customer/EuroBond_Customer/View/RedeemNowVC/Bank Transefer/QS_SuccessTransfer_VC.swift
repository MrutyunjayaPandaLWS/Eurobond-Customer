//
//  QS_SuccessTransfer_VC.swift
//  Quba Safalta
//
//  Created by Arokia-M3 on 10/03/21.
//

import UIKit
import LanguageManager_iOS
import Firebase

class QS_SuccessTransfer_VC: BaseViewController {

    @IBOutlet var roundview: UIView!
    @IBOutlet var enteredAmountLabel: UILabel!
    @IBOutlet var okButton: UIButton!
    var isComeFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isComeFrom == "BankSuccess" {
            self.enteredAmountLabel.text = "\("Congratulations".localiz()) \n \("Entered amount has been transferred to your bank account".localiz())"
        } else if isComeFrom == "PaytmSuccess" {
            self.enteredAmountLabel.text = "\("Congratulations".localiz()) \n \("Entered amount has been transferred to your paytm number".localiz())"
        } else if isComeFrom == "VoucherSuccess" {
            self.enteredAmountLabel.text = "\("Thank_you_for_redeeming".localiz()) \n \("The_E-voucher_will_sent_email_id_shortly".localiz())"
        }
        self.okButton.setTitle("OK".localiz(), for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillLayoutSubviews() {
        roundview.roundCorners(corners: [.topLeft,.topRight], radius: 20.0)
    }
    @IBAction func okButton(_ sender: Any) {
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: .showPopUp , object: self)
        }
    }
    

}
