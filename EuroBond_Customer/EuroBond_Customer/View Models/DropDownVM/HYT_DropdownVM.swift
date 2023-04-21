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
    
    var languageList = [LstAttributesDetails]()
    var queryTopicListArray = [ObjHelpTopicList]()
    
    func languageListApi(parameter: JSON){
        self.languageList.removeAll()
        VC?.startLoading()
        requestAPIs.language_Api(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.languageList = result?.lstAttributesDetails ?? []
                        if self.languageList.count != 0{
                            self.VC?.heightOfTableView.constant = CGFloat(45 * self.languageList.count)
                            self.VC?.rowNumber = self.languageList.count
                            self.VC?.dropdownTableView.reloadData()
                            self.VC?.stopLoading()
                            
                        }else{
                            self.VC?.dropdownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
                            self.VC?.stopLoading()
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.dropdownTableView.isHidden = true
                        self.VC?.noDataFoundLbl.isHidden = false
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("Language Api error",error?.localizedDescription)
                DispatchQueue.main.async {
                    self.VC?.dropdownTableView.isHidden = true
                    self.VC?.noDataFoundLbl.isHidden = false
                    self.VC?.stopLoading()
                }
            }
        }
        
    }
    
    func stateListinApi(parameter: JSON){
        self.stateListArray.removeAll()
        self.VC?.startLoading()
        requestAPIs.stateList_Api(parameters: parameter) { result, error in
            if error == nil{
                if result != nil{
                    
                    DispatchQueue.main.async {
                        self.stateListArray = result?.stateList ?? []
                        if self.stateListArray.count != 0{
                            self.VC?.heightOfTableView.constant = CGFloat(45 * self.stateListArray.count)
                            self.VC?.rowNumber = self.stateListArray.count
                            self.VC?.dropdownTableView.reloadData()
                            self.VC?.stopLoading()
                            
                        }else{
                            self.VC?.dropdownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
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
                        self.cityListArray = result?.cityList ?? []
                        if self.cityListArray.count != 0{
                            self.VC?.heightOfTableView.constant = CGFloat(45 * self.cityListArray.count)
                            self.VC?.rowNumber = self.cityListArray.count
                            
                            
                            self.VC?.dropdownTableView.reloadData()
                            self.VC?.stopLoading()
                            
                        }else{
                            self.VC?.dropdownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
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
    
    func helpTopicsQueryList(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.helpTopicListApi(parameters: parameter) { (result, error) in
            
            if error == nil{
                if result != nil{
                 
                    DispatchQueue.main.async {
                        self.queryTopicListArray = result?.objHelpTopicList ?? []
                        print(self.queryTopicListArray.count, "asdfasdfasdfsad")
                        if self.queryTopicListArray.count != 0{
                            self.VC?.heightOfTableView.constant = CGFloat(45 * self.queryTopicListArray.count)
                            self.VC?.rowNumber = self.queryTopicListArray.count
                            
                            
                            self.VC?.dropdownTableView.reloadData()
                            self.VC?.stopLoading()
                            
                        }else{
                            self.VC?.dropdownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
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
