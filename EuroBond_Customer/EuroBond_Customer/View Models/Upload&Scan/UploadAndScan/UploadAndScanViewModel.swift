//
//  UploadAndScanViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class UploadAndScanViewModel{
    
    weak var VC: ScanOrUpload_VC?
    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var requestAPIs = RestAPI_Requests()
    
    func submitCodesApi(parameters: JSON, completion: @escaping (ScannedandUploadCodesModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.submitCodesApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
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
