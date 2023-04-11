//
//  HYT_DropdownVM.swift
//  Hoya Thailand
//
//  Created by syed on 24/02/23.
//

import Foundation
import UIKit

class HYT_DropdownVM{
    
    var requestAPIs = RestAPI_Requests()
    weak var VC: EBC_DropDownVC?
    var stateListArray = [StateList]()
    var cityListArray = [CityList]()
    
    func stateListinApi(parameter: JSON){
        self.stateListArray.removeAll()
        self.VC?.startLoading()
        requestAPIs.stateList_Api(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    
                    DispatchQueue.main.async {
                               
                        if self.stateListArray.count != 0{
                            self.VC?.heightOfTableView.constant = CGFloat(45 * self.stateListArray.count)
                            self.VC?.rowNumber = self.stateListArray.count
                            
                            
                            self.VC?.dropdownTableView.reloadData()
                            self.VC?.stopLoading()
                            
                        }else{
                            self.VC?.stopLoading()
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
                    print("roleListin error",error?.localizedDescription)
                }
            }
        }
    }
    
    func cityListinApi(parameter: JSON){
        self.cityListArray.removeAll()
        self.VC?.startLoading()
        requestAPIs.cityList_Api(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    
                    DispatchQueue.main.async {
                               
                        if self.cityListArray.count != 0{
                            self.VC?.heightOfTableView.constant = CGFloat(45 * self.cityListArray.count)
                            self.VC?.rowNumber = self.cityListArray.count
                            
                            
                            self.VC?.dropdownTableView.reloadData()
                            self.VC?.stopLoading()
                            
                        }else{
                            self.VC?.stopLoading()
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
                    print("roleListin error",error?.localizedDescription)
                }
            }
        }
    }
    
    
}
