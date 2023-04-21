//
//  EBC_LoginVM.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 13/04/2023.
//

import Foundation
import UIKit
class EBC_LoginVM {
    
    weak var VC: EBC_Login1VC?
    var requestAPIs = RestAPI_Requests()
    //    var customerTypeArray = [LstAttributesDetails]()
    
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
                if str ?? "" == "0"{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                            self.VC?.view.makeToast("Mobile number doesn't exists", duration: 2.0, position: .bottom)
                            self.VC?.membershipIdTF.text = ""
                            self.VC?.loginBtnStatus = 0
                            self.VC?.termCondBtn.setImage(UIImage(named: "blankcheckbox"), for: .normal)
                            self.VC?.tcStatus = 0
                        }
                }else{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.loginBtnStatus = 2
                        self.VC?.submitBtn.setTitle("Submit", for: .normal)
                        self.VC?.otpView.isHidden = false
                        self.VC?.submitBtnStatus = 1
                        self.VC?.submitButtonTopSpace.constant = 190
                        self.VC?.loginSubViewHeight.constant = 429
                        self.VC?.membershipIdTF.isEnabled = false
                        let parameter = [
                            "OTPType": "Enrollment",
                            "UserId": -1,
                            "MobileNo": self.VC?.membershipIdTF.text ?? "",
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
    
    func verifyMobileNumberAPI1(paramters: JSON){
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
                if str ?? "" == "0"{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.submitBtn.setTitle("Submit", for: .normal)
                        self.VC?.otpView.isHidden = false
                        self.VC?.submitBtnStatus = 1
                        self.VC?.submitButtonTopSpace.constant = 190
                        self.VC?.loginSubViewHeight.constant = 429
                        self.VC?.membershipIdTF.isEnabled = false
                        let parameter = [
                            "OTPType": "Enrollment",
                            "UserId": -1,
                            "MobileNo": self.VC?.membershipIdTF.text ?? "",
                            "UserName": "",
                            "MerchantUserName": "EuroBondMerchantDemo"
                        ] as [String: Any]
                        self.getOTPApi(parameter: parameter)
                    }
                }else{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.view.makeToast("Mobile number already exists", duration: 2.0, position: .bottom)
                        self.VC?.membershipIdTF.text = ""
                        
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
            self.VC?.timmerLbl.text = "Seconds Remaining : 0:\(count - 1)"
            self.VC?.resendOtpBtn.isHidden = true
            self.VC?.membershipIdTF.isEnabled = false
        }else{
            self.VC?.resendOtpBtn.isHidden = false
            self.VC?.membershipIdTF.isEnabled = true
            self.timer.invalidate()
        }
    }

    
    func loginSubmissionApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.login_API(parameters: parameter) { (result, error) in

            if result == nil{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    let loginResponse = result?.userList ?? []

                    print(loginResponse.count)
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        if loginResponse.count != 0{

                             if loginResponse[0].isDelete ?? -1 == 1{
                                self.VC!.view.makeToast("Your account is verification pending! Kindly contact your administrator.", duration: 2.0, position: .bottom)
                            }else{
                                if loginResponse[0].isUserActive ?? -1 == 1{
                                    UserDefaults.standard.setValue(loginResponse[0].userId ?? -1, forKey: "UserID")
                                    UserDefaults.standard.setValue(1, forKey: "IsloggedIn?")
                                    
                                    DispatchQueue.main.async {
                                        if #available(iOS 13.0, *) {
                                            let sceneDelegate = self.VC!.view.window!.windowScene!.delegate as! SceneDelegate
                                            sceneDelegate.setHomeAsRootViewController()
                                        } else {
                                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                            appDelegate.setHomeAsRootViewController()
                                        }
                                    }
                                }

                            }

                        }else{
                            self.VC!.view.makeToast("Something went wrong. Try again later!", duration: 2.0, position: .bottom)
                        }

                    }
                }else{
                    print(error)
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }
        }
    }


//    func customerTypeListApi(parameter: JSON){
//
//        DispatchQueue.main.async {
//            self.VC?.startLoading()
//        }
//
//        self.requestAPIs.getCustomerTypeListApi(parameters: parameter) { (result, error) in
//
//            if result == nil{
//
//                DispatchQueue.main.async {
//                    self.VC?.stopLoading()
//                }
//            }else{
//                if error == nil{
//                    DispatchQueue.main.async {
//                        self.customerTypeArray = result?.lstAttributesDetails ?? []
//                        print(self.customerTypeArray.count, "Attributes Count")
//                        self.VC?.stopLoading()
//                        if self.customerTypeArray.count != 0 {
//                            self.VC?.filterTableView.isHidden = false
//                            self.VC?.filterTableView.reloadData()
//                        }else{
//                            self.VC?.filterTableView.isHidden = true
//                        }
//                    }
//                }else{
//                    DispatchQueue.main.async {
//                        print(error)
//                        self.VC?.stopLoading()
//                    }
//                }
//            }
//        }
//
//    }
}
