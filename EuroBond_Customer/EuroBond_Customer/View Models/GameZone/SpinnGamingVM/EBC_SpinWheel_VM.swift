//
//  LINC_MagicBox_VM.swift
//  LINC
//
//  Created by Arokia-M3 on 22/07/21.
//

import UIKit

class EBC_SpinWheel_VM: popUpDelegate1{
    func popupAlertDidTap1(_ vc: PopupAlertOne_VC) {}
    
    
    weak var VC: VariousWheelSimpleVC?
    var requestAPIs = RestAPI_Requests()
    
    func spinnWheelGamingAPI(paramters: JSON){
        self.VC?.startLoading()
        self.requestAPIs.spinnGamingSubmissionAPI(parameters: paramters) { (result, error) in
            if error == nil {
                if result != nil{
                    let returnmessage = result?.returnMessage ?? ""
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result?.returnMessage ?? "")
                        
                        if returnmessage == "1"{
                            self.VC?.SuccessPopUp.isHidden = false
                            if self.VC?.finishIndexData == "0" {
                                self.VC?.betterLuckNextTime.isHidden = false
                                self.VC?.animationPointsView.isHidden = true
                            }else{
                                self.VC?.animationPointsView.isHidden = false
                                self.VC?.betterLuckNextTime.isHidden = true
                                self.VC?.lottieAnimation(animationView: (self.VC?.animationPointsView)!)
                            }
                        }else{
                            self.VC?.SuccessPopUp.isHidden = false
                            if self.VC?.finishIndexData == "0" {
                                self.VC?.betterLuckNextTime.isHidden = false
                                self.VC?.animationPointsView.isHidden = true
                            }else{
                                self.VC?.lottieAnimation(animationView: (self.VC?.animationPointsView)!)
                                self.VC?.animationPointsView.isHidden = false
                                self.VC?.betterLuckNextTime.isHidden = true
                            }
                            
                        }
                    }
                }else{
                    print("NO RESPONSE")
                    self.VC?.stopLoading()
                }
            }else{
                print("ERROR_GOODPACK \(error)")
               // LoadingIndicator.sharedInstance.hideIndicator()
                self.VC?.stopLoading()
            }
            
        }
    }
    
    
    
    
}
