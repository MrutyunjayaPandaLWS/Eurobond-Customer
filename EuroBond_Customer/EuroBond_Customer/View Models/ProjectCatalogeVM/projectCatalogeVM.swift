//
//  File.swift
//  EuroBond_Customer
//
//  Created by Arokia-M3 on 03/05/23.
//

import Foundation
import LanguageManager_iOS

class projectCatalogeVM {
    
    weak var VC: EBC_SearchProjectVC?
    var requestAPIs = RestAPI_Requests()
    var projectCatalogeArray = [LstProductListDetails1]()
    
    func projectCatalogeAPI(parameter: JSON){
            DispatchQueue.main.async {
                self.VC?.startLoading()
            }
            self.requestAPIs.projectCatalogeAPI(parameters: parameter) { (result, error) in
                if error == nil{
                    if result != nil{
                        DispatchQueue.main.async {
                            self.VC?.stopLoading()
                        self.projectCatalogeArray = result?.lstProductListDetails ?? []
                        print(self.projectCatalogeArray.count, "My Project Count")
                        if self.projectCatalogeArray.count != 0 {
                            self.VC?.projectListingCV.isHidden = false
                            self.VC?.projectListingCV.reloadData()
                        }else{
                            self.VC?.projectListingCV.isHidden = true
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
