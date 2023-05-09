//
//  EBC_MyProfileUpdateVM.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 18/04/2023.
//

import Foundation
import UIKit
class EBC_MyProfileUpdateVM{
    
    weak var VC: MyProfileandBankDetailsVC?
    var requestAPIs = RestAPI_Requests()
    
    func profileImageUpdate(parameter: JSON){
        
        self.requestAPIs.imageSavingAPI(parameters: parameter) { (result, error) in
            
            if error == nil{
                
                if result != nil{
                    DispatchQueue.main.async {
                        print(result?.returnMessage ?? "", "ReturnMessage")
                        if result?.returnMessage ?? "" == "1"{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as! PopupAlertOne_VC
                                vc.descriptionInfo = "Profile image updated successfully !!"
                                vc.itsComeFrom = "ProfileImage"
                                vc.modalPresentationStyle = .overFullScreen
                                vc.modalTransitionStyle = .coverVertical
                                self.VC?.present(vc, animated: true)
                            }
                        }else{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as! PopupAlertOne_VC
                                vc.descriptionInfo = "Profile image updation failed"
                                vc.itsComeFrom = "ProfileImage"
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
}

