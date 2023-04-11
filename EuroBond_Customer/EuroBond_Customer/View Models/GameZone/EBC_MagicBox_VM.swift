//
//  LINC_MagicBox_VM.swift
//  LINC
//
//  Created by Arokia-M3 on 22/07/21.
//

import UIKit

class EBC_MagicBox_VM{
    
    weak var VC: EBC_MagicBoxVC?
    var requestAPIs = RestAPI_Requests()
    
    func magicBoxAPI(paramters: JSON){
        //LoadingIndicator.sharedInstance.showIndicator()
        self.requestAPIs.gamificationSubmit_Post_API(parameters: paramters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        //LoadingIndicator.sharedInstance.hideIndicator()
                        self.VC?.stopLoading()
                        print(result?.returnMessage ?? "")
                    }
                }else{
                    print("NO RESPONSE")
                    //LoadingIndicator.sharedInstance.hideIndicator()
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
