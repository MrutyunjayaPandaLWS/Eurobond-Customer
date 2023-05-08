//
//  EBC_SignUpVM.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 14/04/2023.
//

import Foundation

import UIKit
import LanguageManager_iOS

class EBC_SignUpVM{
    
    weak var VC: EBC_Signup2VC?
    var requestAPIs = RestAPI_Requests()
    var resultData:PanModels?
    
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
                    
//                    let response = String(result?.returnMessage ?? "").split(separator: "~")
                    print(result?.returnMessage ?? "", "Registration Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                       
                        if String(result?.returnMessage ?? "").prefix(1) == "1" {
                                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_SuccessMessageVC") as! EBC_SuccessMessageVC
                                vc.itsComeFrom = "Registration"
                                vc.modalTransitionStyle = .coverVertical
                                vc.modalPresentationStyle = .overFullScreen
                                self.VC!.present(vc, animated: true)
                            }else{
                                self.VC!.view.makeToast("Registration Failed".localiz(), duration: 3.0, position: .bottom)
                                for controller in self.VC!.navigationController!.viewControllers as Array {
                                    if controller.isKind(of: EBC_Login1VC.self) {
                                        self.VC!.navigationController!.popToViewController(controller, animated: true)
                                        break
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
    
    
    func pancardVerifyApi(parameters: JSON){
        self.VC?.startLoading()
        self.requestAPIs.panVerifyApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        if result?.objPanDetailsRetrieverequest?.isPanValid ?? -1 == 1{
                            
                            self.resultData = result
                            print(self.resultData,"sdkjhds")
                            
//                            if result?.objPanDetailsRetrieverequest?.panImage ?? "" == ""{
//                            //self.VC?.panImage.image = UIImage(named: "sample-pan-card"
//                                self.VC?.imagePanCons.constant = 0
//
//                            }else{
//                                let totalImgURL = productCatalogueImgURL + (result?.objPanDetailsRetrieverequest?.panImage ?? "")
//                                self.VC?.panImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "sample-pan-card"))
//                            }
                        }else {
                            self.VC?.view.makeToast("Pan is invalid".localiz(), duration: 2.0, position: .bottom)
                        }
                        print("No Response")
                        DispatchQueue.main.async {
                            self.VC?.stopLoading()
                        }
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }

        }
    }
    
    }
    
    
    
    
}
