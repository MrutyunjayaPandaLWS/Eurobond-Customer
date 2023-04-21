//
//  EBC_ReferandEarnVM.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 18/04/2023.
//

import Foundation
import UIKit
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
                                vc.descriptionInfo = "Thank you for referring to Eurobond Program ! Keep referring to earn euros"
                                vc.itsComeFrom = "ReferandEarn"
                                vc.modalPresentationStyle = .overFullScreen
                                vc.modalTransitionStyle = .coverVertical
                                self.VC?.present(vc, animated: true)
                            }
                        }else{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as! PopupAlertOne_VC
                                vc.descriptionInfo = "Something went wrong! Try again Later."
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
}

