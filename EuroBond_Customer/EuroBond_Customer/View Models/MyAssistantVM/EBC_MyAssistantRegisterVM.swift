//
//  EBC_MyAssistantRegisterVM.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 20/04/2023.
//

import Foundation
import UIKit

class EBC_MyAssistantRegisterVM{
    
    weak var VC: EBC_RegisterAssistantVC?
    var requestAPIs = RestAPI_Requests()
    var count = 0
    var timer = Timer()
    
    func verifyMobileNumberAPI(paramters: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        let url = URL(string: checkUserExistencyURL)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: paramters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "TOKEN") ?? "")", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do{
                let str = String(decoding: data, as: UTF8.self) as String?
                print(str, "- Mobile Number Exists")
                if str ?? "" == "1"{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.view.makeToast("Already Mobile number doesn't exists", duration: 2.0, position: .bottom)
                        self.VC?.mobileNumberTF.text = ""
                        
                    }
                }else{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.mobileNumberTF.isEnabled = false
                        self.VC?.otpBtn.setTitle("Submit", for: .normal)
                        self.VC?.timmerView.isHidden = false
                        self.VC?.otpView.isHidden = false
                        self.VC?.nameView.isHidden = true
                        self.VC?.editBtn.isHidden = true
                        self.VC?.mobileNumberTF.isEnabled = false
                        self.VC?.otpBtnStatus = 1
                        self.VC?.otpTimmerLbl.isHidden = false
                        let parameter = [
                            "OTPType": "Enrollment",
                            "UserId": -1,
                            "MobileNo": self.VC?.mobileNumberTF.text ?? "",
                            "UserName": "",
                            "MerchantUserName": "EuroBondMerchantDemo"
                        ] as [String: Any]
                        self.getOTPApi(parameter: parameter)
                    }
                }
            }catch{
                DispatchQueue.main.async{
                    self.VC?.stopLoading()
                    print("parsing Error")
                }
            }
        })
        task.resume()
    }
    func getOTPApi(parameter: JSON){
        DispatchQueue.main.async {
            self.count = 60
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            self.VC?.startLoading()
        }
        
        self.requestAPIs.otp_Post_API(parameters: parameter) { (result, error) in
            
            if result == nil{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
//                        self.VC?.receivedOTP = result?.returnMessage ?? ""
                        self.VC?.receivedOTP = "123456"
                        print(result?.returnMessage ?? "", "-OTP")
                        
                      //  self.VC?.receivedOTP = "123456"
                       
                    }
                }else{
                    DispatchQueue.main.async {
                        print(error)
                        self.VC?.stopLoading()
                    }
                }
            }
        }
    }
    
    @objc func update() {
        if(count > 1) {
            count = count - 1
            self.VC?.otpTimmerLbl.text = "Seconds Remaining : 0:\(count - 1)"
            self.VC?.resendBtnView.isHidden = true
            self.VC?.mobileNumberTF.isEnabled = false
        }else{
            self.VC?.resendBtnView.isHidden = false
            self.VC?.mobileNumberTF.isEnabled = true
            self.timer.invalidate()
        }
    }
    func registerSubmission(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()

        }
        self.requestAPIs.myassistantRegisterSubmissionApi(parameters: parameter) { (result, error) in
            
            if error == nil{
                
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result?.returnMessage ?? "")
                        if String(result?.returnMessage ?? "").prefix(1) == "1"{
                            self.VC?.successView.isHidden = false
                            self.VC?.registrationView.isHidden = true
                            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute:{
                                NotificationCenter.default.post(name: .moveToPrevious, object: nil)
                                self.VC?.dismiss(animated: true)
                                
                            })

                        }else{
                            
                            self.VC?.view.makeToast("Something went wrong!, Try again later..", duration: 2.0, position: .bottom)
                            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute:{
                                NotificationCenter.default.post(name: .moveToPrevious, object: nil)
                                self.VC?.dismiss(animated: true)
                            })
                            
                        }
                            

                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result, "kl;dsfkjlasdjlfkas")
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    print(error, "kl;dsfkjlasdjlfkas")
                }
            }
        }
    }
   
    
}
