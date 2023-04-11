//
//  HYT_LanguageVM.swift
//  Hoya Thailand
//
//  Created by syed on 24/02/23.
//

import Foundation
import UIKit
import Toast_Swift

class LanguageVM{
    var requestAPIs = RestAPI_Requests()
//    weak var VC: EBC_LanguageDropDownVC?
    var languageList = [LstAttributesDetails]()
    func languageListApi(parameter: JSON){
        self.languageList.removeAll()
//        VC?.startLoading()
        requestAPIs.language_Api(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.languageList = result?.lstAttributesDetails ?? []
                        if result?.lstAttributesDetails?.count != 0 {
//                            self.VC?.languageTV.reloadData()
//                            self.VC?.stopLoading()
                        }else{
                            DispatchQueue.main.async {
//                                self.VC?.stopLoading()
                            }
                        }
                    }
                }else{
                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("Language Api error",error?.localizedDescription)
                DispatchQueue.main.async {
//                    self.VC?.stopLoading()
                }
            }
        }
        
    }
    
}
