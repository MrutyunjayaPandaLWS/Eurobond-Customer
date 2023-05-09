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
    let firstname = UserDefaults.standard.string(forKey: "FirstName") ?? ""
    var VM = EBC_ReferandEarnVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.mobileNumberTF.delegate = self
        self.nameTF.delegate = self
        self.mobileNumberTF.keyboardType = .numberPad
        self.nameTF.keyboardType = .asciiCapable
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
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
            }
        }else{
            
            if self.nameTF.text!.count == 0 {
                self.view.makeToast("Enter Name".localiz(), duration: 2.0,position: .bottom)
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
    }
    

    
    
    
    @IBAction func mobileNumberDidEndAct(_ sender: Any) {
        
        if self.mobileNumberTF.text?.count == 10{
                let parameterJSON = [
                    "Location": [
                        "UserName": self.mobileNumberTF.text ?? ""
                    ],
                    "ActionType": "68"
                ] as [String:Any]
                print(parameterJSON)
                self.VM.verifyMobileNumberAPI(paramters: parameterJSON)
            
        }else{
            self.view.makeToast("Entervalidmobilernumber".localiz(), duration: 2.0, position: .bottom)
            self.mobileNumberTF.text = ""
        }
    }
    
    
    
    
    
    
    
    
    @IBAction func selectCopyBtn(_ sender: UIButton) {
        self.view.makeToast("Text Copied".localiz(), duration: 2.0,position: .bottom)
        UIPasteboard.general.string = "\(referralCode)"
    }
    
    @IBAction func selectShareBtn(_ sender: UIButton) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
            }
        }else{
            let text = "Dear Member, You have been referred by " + "\(firstname)" + " to Eurobond Rewards Program. Please register to the program by downloading the Eurobond Rewards app and use the referral code " + "\(referralCode)" + " to avail the benefits. TnC apply, Team  Eurobond"
            let textShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == mobileNumberTF {
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            
            if string == numberFiltered {
                let currentText = mobileNumberTF.text ?? ""
                guard let stringRange = Range(range, in: currentText) else { return false }
                let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
                return updatedText.count <= 10
            } else {
                return false
            }
        }else if textField == nameTF{
            let currentText = nameTF.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 30
        }else{
            return false
        }
    }
}
