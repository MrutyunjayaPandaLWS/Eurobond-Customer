//
//  HR_SelectionVM.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/26/22.
//


import UIKit

class HR_SelectionVM: popUpAlertDelegate {
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    weak var VC: HR_SelectionVC?
 
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
    var stateArray = [StateList]()
    var cityArray = [CityList]()
   
    var myEarningStatusArray = [LstAttributesDetails]()
    
//    func countrylisting(parameters:JSON){
//        print(parameters)
//        self.VC?.startLoading()
//        self.requestAPIs.country_Post_API(parameters: parameters) { (result, error) in
//            if error == nil {
//                if result != nil{
//                    DispatchQueue.main.async {
//                        self.countryArray = (result?.lstCountryDetails) ?? []
//                        print(self.countryArray.count , "Country Count")
//
//                        if self.countryArray.count == 0{
//                            self.VC?.selectionTableView.isHidden = true
//                        }else{
//                            if self.countryArray.count <= 10{
//                                self.VC?.selectionTableHeightConstraint.constant =  CGFloat(self.countryArray.count * 50)
//                            }else{
//                                self.VC?.selectionTableHeightConstraint.constant = 400
//                            }
//                            self.VC?.selectionTableView.isHidden = false
//                            self.VC?.selectionTableView.reloadData()
//                        }
//
//                        self.VC?.stopLoading()
//                    }
//                }else{
//                    print("NO RESPONSE")
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                    }
//                }
//            }else{
//                print("ERROR_ \(error)")
//                DispatchQueue.main.async {
//                    self.VC?.stopLoading()
//                }
//
//            }
//
//        }
//    }
    
    func statelisting(parameters:JSON){
        print(parameters)
        self.VC?.startLoading()
        self.requestAPIs.stateList_Api(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.stateArray = result?.stateList ?? []
                        print(self.stateArray.count, "State Array Count")
                        if self.stateArray.count == 0{
                            self.VC?.selectionTableView.isHidden = true
                        }else{
                            if self.stateArray.count <= 10{
                                self.VC?.selectionTableHeightConstraint.constant =  CGFloat(self.stateArray.count * 50)
                            }else{
                                self.VC?.selectionTableHeightConstraint.constant = 400
                            }
                            
                            self.VC?.selectionTableView.isHidden = false
                            self.VC?.selectionTableView.reloadData()
                        }
                        self.VC?.stopLoading()
                    }
                }else{
                    print("NO RESPONSE")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_ \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }

            }

        }
    }

    func citylisting(parameters:JSON){
        self.VC?.startLoading()
        print(parameters)
        self.requestAPIs.cityList_Api(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.cityArray = result?.cityList ?? []
                        print(self.cityArray.count, "City Count")
                        if self.cityArray.count == 0{
                            self.VC?.selectionTableView.isHidden = true
                        }else{
                            if self.cityArray.count <= 10{
                                self.VC?.selectionTableHeightConstraint.constant =  CGFloat(self.cityArray.count * 50)
                            }else{
                                self.VC?.selectionTableHeightConstraint.constant = 400
                            }
                            self.VC?.selectionTableView.isHidden = false
                            self.VC?.selectionTableView.reloadData()
                        }
                        
                        self.VC?.stopLoading()
                    }
                }else{
                    print("NO RESPONSE")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_ \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }

            }

        }
    }
    
}
