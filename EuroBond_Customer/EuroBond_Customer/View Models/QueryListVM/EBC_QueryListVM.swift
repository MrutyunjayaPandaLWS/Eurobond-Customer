//
//  EBC_QueryListVM.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 17/04/2023.
//

import Foundation

class EBC_QueryListVM{
    weak var VC: EBC_QueryListingVC?
    var requestAPIs = RestAPI_Requests()
    
    var queryListingArray = [ObjCustomerAllQueryJsonList]()
    func queryListingApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.queryListApi(parameters: parameter) { (result, error) in
            
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.queryListingArray = result?.objCustomerAllQueryJsonList ?? []
                        print(self.queryListingArray.count)
                        if self.queryListingArray.count != 0 {
                            self.VC?.emptyMessage.isHidden = true
                            self.VC?.queryListingTV.isHidden = false
                        }else{
                            self.VC?.emptyMessage.isHidden = false
                            self.VC?.queryListingTV.isHidden = true
                        }
                        self.VC?.queryListingTV.reloadData()
                    }
                }else{
                    DispatchQueue.main.async {
                        print(result, "result")
                        self.VC?.stopLoading()
                    }
                }
                
            }else{
                DispatchQueue.main.async {
                    print(error, "Error")
                    self.VC?.stopLoading()
                }
            }
        }
    }
}
