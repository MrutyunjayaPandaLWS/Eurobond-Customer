//
//  QS_BankTransfer_VC.swift
//  Quba Safalta
//
//  Created by Arokia-M3 on 10/03/21.
//

import UIKit
import LanguageManager_iOS
import Firebase

class QS_BankTransfer_VC: BaseViewController, UITextFieldDelegate, popUpAlertDelegate, popUpDelegate1 {
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    func popupAlertDidTap1(_ vc: PopupAlertOne_VC) {}
    
    @IBOutlet var moneyIcon: UILabel!
    @IBOutlet var accountNumberView: UIView!
    @IBOutlet var ifscCodeView: UIView!
    @IBOutlet var accountNumber: UILabel!
    @IBOutlet var accountHoldername: UILabel!
    @IBOutlet var bankname: UILabel!
    @IBOutlet var ifscCode: UILabel!
    @IBOutlet var amount: UITextField!
//    @IBOutlet var pointsLabel: UILabel!
//    @IBOutlet var redeemablebalance: UILabel!
//    @IBOutlet var bankTransferHeadingLabel: UILabel!
    @IBOutlet var transferPointsHeadingLabel: UILabel!
    //@IBOutlet var accountDetailsHeadingLabel: UILabel!
    @IBOutlet var accountNumberHeadingLabel: UILabel!
    @IBOutlet var accountNameHeadingLabel: UILabel!
    //@IBOutlet var bankNameHeadingLabel: UILabel!
    @IBOutlet var ifscCodeHeadingLabel: UILabel!
    @IBOutlet var noteLabel: UILabel!
    @IBOutlet var transferButton: UIButton!
    @IBOutlet var noteDetailsLabel: UILabel!
    @IBOutlet var enterAmountLbl: UILabel!
    
    
    @IBOutlet var rejectedLbl: UILabel!
    
    @IBOutlet var rejectedView: UIView!
    @IBOutlet var bankDetialsOUTBtn: UIButton!
    
    

    var vm = QS_BankTransfer_VM()
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var loyaltyID = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var redbal = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.VC = self
        self.amount.delegate = self
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "No Internet. Please check your internet connection".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            self.vm.bankDetailsAPI(actorID: self.userID)
            self.amount.keyboardType = .numberPad
        }
//        self.pointsLabel.text = "\("Points".localiz()) \(redbal)"
        NotificationCenter.default.addObserver(self, selector: #selector(handlepopupdateclose), name: Notification.Name.showPopUp, object: nil)
        localization()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func localization() {
//        self.bankTransferHeadingLabel.text = "Bank_Transfer".localiz()
        self.transferPointsHeadingLabel.text = "Transfer_points_to_Bank_Account".localiz()
        self.enterAmountLbl.text = "Enter_amount".localiz()
       // self.accountDetailsHeadingLabel.text = "Your_Account_Details".localiz()
        self.accountNumberHeadingLabel.text = "Account_Number".localiz()
        self.accountNameHeadingLabel.text = "Account_Holder_Name".localiz()
        //self.bankNameHeadingLabel.text = "Bank_Name".localiz()
        self.ifscCodeHeadingLabel.text = "IFSC_Code".localiz()
        self.amount.placeholder = "Enter_amount".localiz()
        self.transferButton.setTitle("Transfer".localiz(), for: .normal)
        self.noteLabel.text = "Note".localiz()
        self.noteDetailsLabel.text = "\("Minimum_value_can_be_entered".localiz())\n\("Denomination_value".localiz())"
//        self.redeemablebalance.text = "Redeemable_Balance".localiz()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        self.accountNumberView.roundCorners(corners: [.topLeft,.topRight], radius: 8)
//        self.ifscCodeView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8)
    }
    
    @objc func handlepopupdateclose() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 6
        let currentString: NSString = (amount.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
//    @IBAction func back(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
    @IBAction func transferButton(_ sender: Any) {
        
        if self.amount.text == ""{
            self.alertmsg(alertmsg:"Enter amount to Transfer".localiz(), buttonalert: "OK".localiz())
        }else if Int(self.amount.text ?? "0")! <= 99{
            self.alertmsg(alertmsg:"Minimum_value_can_be_entered".localiz(), buttonalert: "OK".localiz())
        }else{
            let amountEnteredInt = Int(self.amount.text ?? "0")!
            if amountEnteredInt % 100 != 0{
                self.alertmsg(alertmsg:"Entered amount should be in multiple of 100".localiz(), buttonalert: "OK".localiz())
            }else{
                if Int(redbal)! < Int(self.amount.text ?? "0")!{
                    self.alertmsg(alertmsg:"Insufficient points balance".localiz(), buttonalert: "OK".localiz())
                    
                }else{
                    if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.descriptionInfo = "No Internet. Please check your internet connection".localiz()
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                        }
                    }else{
                        self.vm.bankSubmitAPI(actorID: userID, NoOfPointsDebit: self.amount.text ?? "0")
                    }
                }
            }
        }
    }
    
    
    @IBAction func bankDetailsACTBtn(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyProfileandBankDetailsVC") as? MyProfileandBankDetailsVC
        vc?.isComeFrom = "BankTransferRC"
        self.navigationController?.pushViewController(vc!, animated: true)
//        vc!.delegate = self
//        vc!.titleInfo = ""
//        vc!.descriptionInfo = "No Internet. Please check your internet connection".localiz()
//        vc!.modalPresentationStyle = .overCurrentContext
//        vc!.modalTransitionStyle = .crossDissolve
//        self.present(vc!, animated: true, completion: nil)
        
        //MyProfileandBankDetailsVC
        
    }
    
    
}
