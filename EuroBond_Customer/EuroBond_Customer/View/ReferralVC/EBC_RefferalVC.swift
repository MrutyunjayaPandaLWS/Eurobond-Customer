//
//  EBC_RefferalVC.swift
//  EuroBond_Customer
//
//  Created by syed on 18/03/23.
//

import UIKit
import Toast_Swift
import LanguageManager_iOS

class EBC_RefferalVC: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var SkipBtn: UIButton!
    @IBOutlet weak var enterCodeTF: UITextField!
    @IBOutlet weak var enterCodeLbl: UILabel!
    @IBOutlet weak var referralinfoLbl: UILabel!
    @IBOutlet weak var referralTitleLbl: UILabel!
    
    @IBOutlet var referalRegisterHeadingLbl: UILabel!
    
    
    
    
    
    let token = UserDefaults.standard.string(forKey: "TOKEN") ?? ""
    var enteredMobile = ""
    var customerTypeName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localizSetup()
        self.enterCodeTF.delegate = self
    }
    
    func localizSetup(){
        referalRegisterHeadingLbl.text = "RegisterbyReferral".localiz()
        referralinfoLbl.text = "Apply Referral Code to Reward your Friend".localiz()
        referralTitleLbl.text = "Enter Referral Code".localiz()
        enterCodeLbl.text = "Referral Code".localiz()
        enterCodeTF.placeholder = "Enter Referral Code".localiz()
        SkipBtn.setTitle("Skip".localiz(), for: .normal)
        verifyBtn.setTitle("Verify".localiz(), for: .normal)
    }
    
    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectSkipBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RegisterVC") as! EBC_RegisterVC
        vc.referralCode = self.enterCodeTF.text ?? ""
        vc.enteredMobile = self.enteredMobile
        vc.customerTypeName = self.customerTypeName
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func selectVerifyBtn(_ sender: UIButton) {
        if self.enterCodeTF.text!.count == 0 {
            self.view.makeToast("Enter Referral Code", duration: 2.0, position: .bottom)
        }else{
            let parameters = [
                "ActionType": 62,
                "Location": [
                    "UserName": "\(self.enterCodeTF.text ?? "")"
                ]
            ] as [String : Any]
            print(parameters)
            self.verifyReferralCode(parameters: parameters)
        }
        
    }
    func verifyReferralCode(parameters: JSON){
        self.startLoading()
        let referNumber = enterCodeTF.text ?? ""
        let url = URL(string: referralVerifyURL )!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do{
                let str = String(decoding: data, as: UTF8.self) as String?
                 print(str, "Response")
                if str ?? "" == "true"{
                    DispatchQueue.main.async {
                        self.stopLoading()
                        self.view.makeToast("Invalid referral code", duration: 2.0, position: .bottom)
                    }
                }else{
                    DispatchQueue.main.async {
                        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RegisterVC") as! EBC_RegisterVC
                        vc.referralCode = self.enterCodeTF.text ?? ""
                        vc.enteredMobile = self.enteredMobile
                        vc.customerTypeName = self.customerTypeName
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                 }catch{
                     print("parsing Error")
            }
        })
        task.resume()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let currentText = enterCodeTF.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 7

    }
    
    
    
}
