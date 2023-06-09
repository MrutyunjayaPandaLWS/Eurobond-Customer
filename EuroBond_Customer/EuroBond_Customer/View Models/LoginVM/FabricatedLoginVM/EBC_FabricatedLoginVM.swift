//
//  EBC_FabricatedLoginVM.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 13/04/2023.
//

import Foundation
import UIKit
import LanguageManager_iOS
class EBC_FabricatedLoginVM {
    
    weak var VC: EBS_LoginVC?
    var requestAPIs = RestAPI_Requests()
    
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
                        self.VC?.view.makeToast("Mobile number doesn't exists".localiz(), duration: 2.0, position: .bottom)
                        self.VC?.userNameTF.text = ""
                        self.VC?.tc2Status = 0
                        self.VC?.chechBox2Btn.setImage(UIImage(named: "blankcheckbox"), for: .normal)
                    }
                }else{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
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
                            if loginResponse[0].result ?? -1 != 1{
                                self.VC!.view.makeToast("Password is Invalid !!".localiz(), duration: 2.0, position: .bottom)
                                self.VC?.passwordTF.text = ""
                            }else if loginResponse[0].isDelete ?? -1 == 1 || loginResponse[0].isUserActive ?? -1 == 0 && loginResponse[0].verifiedStatus ?? -1 == 3 {
                                self.VC!.view.makeToast("Your account is verification pending! Kindly contact your administrator.".localiz(), duration: 2.0, position: .bottom)
                            }else if loginResponse[0].isUserActive ?? -1 == 1 && loginResponse[0].verifiedStatus ?? -1 == 0 || loginResponse[0].isUserActive ?? -1 == 0 && loginResponse[0].verifiedStatus ?? -1 == 0 || loginResponse[0].verifiedStatus ?? -1 == 3 || loginResponse[0].verifiedStatus ?? -1 == 0 || loginResponse[0].verifiedStatus ?? -1 == 5 {
                                self.VC!.view.makeToast("Your account is not activated! Kindly activate your account".localiz(), duration: 2.0, position: .bottom)
                            }else if loginResponse[0].isUserActive ?? -1 == 0 && loginResponse[0].verifiedStatus ?? -1 == 1 || loginResponse[0].isUserActive ?? -1 == 0 && loginResponse[0].verifiedStatus ?? -1 == 4{
                                self.VC!.view.makeToast("Your account has been deactivated! Kindly contact your administrator.".localiz(), duration: 2.0, position: .bottom)
                            }else if loginResponse[0].verifiedStatus ?? -1 == 2 {
                                self.VC!.view.makeToast("Your account verification is failed!, Kindly contact your administrator.".localiz(), duration: 2.0, position: .bottom)
                            }else{
                                if loginResponse[0].isUserActive ?? -1 == 1 && loginResponse[0].verifiedStatus ?? -1 == 1 || loginResponse[0].isUserActive ?? -1 == 1 && loginResponse[0].verifiedStatus ?? -1 == 4{
                                    UserDefaults.standard.setValue(loginResponse[0].userId ?? -1, forKey: "UserID")
                                    UserDefaults.standard.setValue(2, forKey: "IsloggedIn?")
                                    
                                    DispatchQueue.main.async {
                                        if #available(iOS 13.0, *) {
                                            let sceneDelegate = self.VC!.view.window!.windowScene!.delegate as! SceneDelegate
                                            sceneDelegate.setHomeAsRootViewController2()
                                        } else {
                                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                            appDelegate.setHomeAsRootViewController2()
                                        }
                                    }
                                }else{
                                    self.VC!.view.makeToast("Your account is verification pending! Kindly contact your administrator.".localiz(), duration: 2.0, position: .bottom)
                                }

                            }

                        }else{
                            self.VC!.view.makeToast("Something went wrong. Try again later".localiz(), duration: 2.0, position: .bottom)
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
