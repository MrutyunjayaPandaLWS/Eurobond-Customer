//
//  EBC_ReferandEarnVM.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 18/04/2023.
//

import Foundation
import UIKit
import LanguageManager_iOS
class EBC_ReferandEarnVM{
    
    weak var VC: EBC_RefferAndEarnVC?
    var requestAPIs = RestAPI_Requests()
    
    func referandEarnSubmissionApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.referandEarnSubmissionApi(parameters: parameter) { (result, error) in
            
            if error == nil{
                
                if result != nil{
                    DispatchQueue.main.async {
                        print(result?.returnMessage ?? "", "ReturnMessage")
                        if String(result?.returnMessage ?? "").prefix(1) == "1"{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as! PopupAlertOne_VC
                                vc.descriptionInfo = "ThanksMessage".localiz()
                                vc.itsComeFrom = "ReferandEarn"
                                vc.modalPresentationStyle = .overFullScreen
                                vc.modalTransitionStyle = .coverVertical
                                self.VC?.present(vc, animated: true)
                            }
                        }else{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as! PopupAlertOne_VC
                                vc.descriptionInfo = "SomethingWentWrong".localiz()
                                vc.itsComeFrom = "ReferandEarn"
                                vc.modalPresentationStyle = .overFullScreen
                                vc.modalTransitionStyle = .coverVertical
                                self.VC?.present(vc, animated: true)
                            }
                        }
                        self.VC?.stopLoading()
                    }
                    
                    
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                    
                }
                
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
                
            }
        }
    }
    
    
    
    
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
                        self.VC?.mobileNumberTF.isEnabled = true
                    }
                }else{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.view.makeToast("Mobile number already exists".localiz(), duration: 2.0, position: .bottom)
                        self.VC?.mobileNumberTF.text = ""
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
}

