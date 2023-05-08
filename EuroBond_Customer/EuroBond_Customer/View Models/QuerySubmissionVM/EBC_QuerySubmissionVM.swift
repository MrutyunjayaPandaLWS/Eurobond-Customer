//
//  EBC_QuerySubmissionVM.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 17/04/2023.
//

import Foundation
import UIKit
import LanguageManager_iOS
class EBC_QuerySubmissionVM{
    weak var VC: EBC_CreatenewQueryVC?
    var requestAPIs = RestAPI_Requests()
    
    func newQuerySubmissionApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.querySubmissionApi(parameters: parameter, completion: { (result, error) in
            
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        if result?.returnMessage ?? "" != "" || result?.returnMessage ?? "" != nil{
                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as! PopupAlertOne_VC
                            vc.descriptionInfo = "QuerySubmittedSuccessfully".localiz()
                            vc.itsComeFrom = "Query"
                            vc.modalPresentationStyle = .overFullScreen
                            vc.modalTransitionStyle = .coverVertical
                            self.VC?.present(vc, animated: true)
                        }else{
                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as! PopupAlertOne_VC
                            vc.itsComeFrom = "Query"
                            vc.descriptionInfo = "QuerySubmissionFailed".localiz()
                            vc.modalPresentationStyle = .overFullScreen
                            vc.modalTransitionStyle = .coverVertical
                            self.VC?.present(vc, animated: true)
                        }
                    }
                    
                    
                }else{
                    DispatchQueue.main.async{
                        print(result, "result")
                        self.VC?.stopLoading()
                    }
                }
                
            }else{
                DispatchQueue.main.async{
                    print(error, "Error")
                    self.VC?.stopLoading()
                }
            }
        })
            
    }
    
}
