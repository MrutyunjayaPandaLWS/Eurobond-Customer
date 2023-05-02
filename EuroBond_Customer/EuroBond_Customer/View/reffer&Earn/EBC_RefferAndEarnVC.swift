//
//  EBC_RefferAndEarnVC.swift
//  EuroBond_Customer
//
//  Created by syed on 21/03/23.
//

import UIKit
import Toast_Swift
import LanguageManager_iOS
class EBC_RefferAndEarnVC: BaseViewController, UITextFieldDelegate {

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
        self.mobileNumberTF.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(fromSubmission), name: Notification.Name.navigateToDashboard, object: nil)
        referalCodeLbl.text = referralCode
        localizSetup()
    }
    @objc func fromSubmission(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    func localizSetup(){
        self.referMoneyLbl.text = "Earn300Euros".localiz()
        self.referInfo.text = "Refer another Fabricator".localiz()
        self.nameLbl.text = "Name".localiz()
        self.mobileNumberLbl.text = "MobileNumber".localiz()
        self.nameTF.placeholder = "Enter Name".localiz()
        self.mobileNumberTF.placeholder = "EnterMobileNumber".localiz()
        self.submitBtn.setTitle("Submit".localiz(), for: .normal)
        self.otherOptionBtn.setTitle("Share via WhatsApp, SMS".localiz(), for: .normal)
        self.titleVC.text = "ReferFabricator".localiz()
    }
    
    
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func selectSubmitBtn(_ sender: UIButton) {
        
        if self.nameTF.text!.count == 0 {
            self.view.makeToast("Enter name".localiz(), duration: 2.0,position: .bottom)
        }else if self.mobileNumberTF.text!.count == 0 {
            self.view.makeToast("EnterMobileNumber".localiz(), duration: 2.0,position: .bottom)
        }else if self.mobileNumberTF.text!.count != 10 {
            self.view.makeToast("Entervalidmobilernumber".localiz(), duration: 2.0,position: .bottom)
        }else if self.mobileNumberTF.text ?? "" == self.customerMobileNumber {
                self.view.makeToast("SelfReferralNotAllowed".localiz(), duration: 2.0, position: .bottom)
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
        self.view.makeToast("Text Copied".localiz(), duration: 2.0,position: .bottom)
        UIPasteboard.general.string = "\(referralCode)"
    }
    
    @IBAction func selectShareBtn(_ sender: UIButton) {
        let text = "\(referralCode)"
            let textShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        if textField == mobileNumberTF{
            let currentString: NSString = (mobileNumberTF.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
    
    
}
