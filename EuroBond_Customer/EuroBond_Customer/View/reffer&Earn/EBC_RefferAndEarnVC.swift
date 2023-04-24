//
//  EBC_RefferAndEarnVC.swift
//  EuroBond_Customer
//
//  Created by syed on 21/03/23.
//

import UIKit
import Toast_Swift
class EBC_RefferAndEarnVC: BaseViewController {

    @IBOutlet weak var otherOptionBtn: UIButton!
    @IBOutlet weak var referalCodeLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var referInfo: UILabel!
    @IBOutlet weak var referMoneyLbl: UILabel!
    @IBOutlet weak var titleVC: UILabel!
    var flags: String = "SideMenu"
    var referralCode = UserDefaults.standard.string(forKey: "ReferralCode") ?? ""
    var VM = EBC_ReferandEarnVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        NotificationCenter.default.addObserver(self, selector: #selector(fromSubmission), name: Notification.Name.navigateToDashboard, object: nil)
        referalCodeLbl.text = referralCode
    }
    @objc func fromSubmission(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func selectSubmitBtn(_ sender: UIButton) {
        
        if self.nameTF.text!.count == 0 {
            self.view.makeToast("Enter name", duration: 2.0,position: .bottom)
        }else if self.mobileNumberTF.text!.count == 0 {
            self.view.makeToast("Enter mobile number", duration: 2.0,position: .bottom)
        }else if self.mobileNumberTF.text!.count != 10 {
            self.view.makeToast("Enter valid mobile number", duration: 2.0,position: .bottom)
        }else if self.mobileNumberTF.text ?? "" == self.customerMobileNumber {
                self.view.makeToast("Self-referral is not allowed", duration: 2.0, position: .bottom)
        }else{
            let parameter = [
                    "ActionType": "2",
                    "ActorId": self.userId,
                    "ObjContactCenterDetails": [
                        "RefereeMobileNo": self.mobileNumberTF.text ?? "",
                        "RefereeName": self.nameTF.text ?? ""
                    ]
            ] as [String: Any]
            print(parameter)
            self.VM.referandEarnSubmissionApi(parameter: parameter)
        }
    }
    
    @IBAction func selectCopyBtn(_ sender: UIButton) {
        self.view.makeToast("Text Copied", duration: 2.0,position: .bottom)
        UIPasteboard.general.string = "\(referralCode)"
    }
    
    @IBAction func selectShareBtn(_ sender: UIButton) {
        let text = "\(referralCode)"
            let textShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
    }
    
    
}
