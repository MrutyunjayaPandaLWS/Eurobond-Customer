//
//  UpdateFabricatedPasswordVM.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 21/04/2023.
//

import Foundation
import LanguageManager_iOS

class UpdateFabricatedPasswordVM{
    
    weak var VC: EBC_UpdatePasswordVC?
    var requestAPIs = RestAPI_Requests()
    
    func updatePasswordApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.myAssistantUpdatePasswordApi(parameters: parameter) { (result, error) in
            
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        let loginResponse = result?.userList ?? []
                        if loginResponse.isEmpty == false && loginResponse[0].result ?? -1 == 1{
                            self.VC!.dismiss(animated: true){
                                NotificationCenter.default.post(name: .passwordUpdated, object: nil)
                            }
                        }else{
                            self.VC?.view.makeToast("Something went wrong. Try again later".localiz(), duration: 2.0, position: .bottom)
                            self.VC!.dismiss(animated: true)
                        }
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

