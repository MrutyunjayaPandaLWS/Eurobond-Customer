//
//  EBC_SignUpVM.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 14/04/2023.
//

import Foundation

import UIKit
class EBC_SignUpVM{
    
    weak var VC: EBC_Signup2VC?
    var requestAPIs = RestAPI_Requests()
    
    func registrationSubmission(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.registrationSubmissionApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    
                    let response = String(result?.returnMessage ?? "").split(separator: "~")
                    print(result?.returnMessage ?? "", "Registration Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                       
                        if response.count != 0 {
                            if response[0] == "1"{
                                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_SuccessMessageVC") as! EBC_SuccessMessageVC
                                vc.itsComeFrom = "Registration"
                                vc.modalTransitionStyle = .coverVertical
                                vc.modalPresentationStyle = .overFullScreen
                                self.VC!.present(vc, animated: true)
                            }else{
                                self.VC!.view.makeToast("Registration Failed", duration: 3.0, position: .bottom)
                                for controller in self.VC!.navigationController!.viewControllers as Array {
                                    if controller.isKind(of: EBC_Login1VC.self) {
                                        self.VC!.navigationController!.popToViewController(controller, animated: true)
                                        break
                                    }
                                }
                            }
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        print(error)
                        print(result)
                        self.VC?.stopLoading()
                    }
                }
            }
        }
    }
}
