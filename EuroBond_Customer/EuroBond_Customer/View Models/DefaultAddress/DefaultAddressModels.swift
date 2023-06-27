//
//  File.swift
//  MSP_Customer
//
//  Created by Arokia-M3 on 06/12/22.
//

import Foundation
import LanguageManager_iOS

class DefaultAddressModels{
    weak var VC: EBC_DefaultAddressVC?
    var requestAPIs = RestAPI_Requests()
    var defaultAddressArray = [LstCustomerJson1]()
    var myCartListArray = [CatalogueSaveCartDetailListResponse]()
    var totalCartValue = 0
    
    func defaultAddressAPi(parameters:JSON){
        self.VC?.startLoading()
        self.requestAPIs.myProfile(parameters: parameters) { (response, error) in
            if error == nil {
                if response != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.defaultAddressArray = response?.lstCustomerJson ?? []
                        self.VC?.customerAddressTV.text = "\(self.defaultAddressArray[0].firstName ?? "-"),\n\(self.defaultAddressArray[0].mobile ?? "-"),\n\(self.defaultAddressArray[0].address1 ?? "-"),\n\(self.defaultAddressArray[0].cityName ?? "-"),\n\(self.defaultAddressArray[0].stateName ?? "-"),\n\(self.defaultAddressArray[0].countryName ?? "-"),\n\(self.defaultAddressArray[0].zip ?? "-")"
//                        self.VC?.selectedname = self.defaultAddressArray[0].firstName ?? "-"
//                        self.VC?.selectedemail = self.defaultAddressArray[0].email ?? "-"
//                        self.VC?.selectedmobile = self.defaultAddressArray[0].mobile ?? "-"
//                        self.VC?.selectedState = self.defaultAddressArray[0].stateName ?? "-"
//                        self.VC?.selectedStateID = self.defaultAddressArray[0].stateId ?? 0
//                        self.VC?.selectedCity = self.defaultAddressArray[0].cityName ?? "-"
//                        self.VC?.selectedCityID = self.defaultAddressArray[0].cityId ?? 0
//                        self.VC?.selectedaddress = self.defaultAddressArray[0].address1 ?? "-"
//                        self.VC?.selectedpincode = self.defaultAddressArray[0].zip ?? "-"
//                        self.VC?.selectedCountryId = self.defaultAddressArray[0].countryId ?? 0
//                        self.VC?.selectedCountry = self.defaultAddressArray[0].countryName ?? "-"
                        self.VC?.selectedname = response?.lstCustomerJson?[0].firstName ?? ""
                        self.VC?.stateID = response?.lstCustomerJson?[0].stateId ?? -1
                        self.VC?.mobile = response?.lstCustomerJson?[0].mobile ?? ""
                        self.VC?.address1 = response?.lstCustomerJson?[0].address1 ?? "-"
                        self.VC?.stateName = response?.lstCustomerJson?[0].stateName ?? "-"
                        self.VC?.districtID = response?.lstCustomerJson?[0].districtId ?? -1
                        self.VC?.cityID = response?.lstCustomerJson?[0].cityId ?? -1
                        self.VC?.cityName = response?.lstCustomerJson?[0].cityName ?? "-"
                        self.VC?.pincode = response?.lstCustomerJson?[0].zip ?? ""
                        self.VC?.countryID = response?.lstCustomerJson?[0].countryId ?? -1
                        self.VC?.countryName = response?.lstCustomerJson?[0].countryName ?? "-"
                        self.VC?.customerNameLabel.text = response?.lstCustomerJson?[0].firstName ?? "-"
                        self.VC?.emailID = response?.lstCustomerJson?[0].email ?? "-"
                        
                    }
                }else{
                    DispatchQueue.main.sync {
                        self.VC?.stopLoading()
                    }
                }
                
            }else{
                DispatchQueue.main.sync {
                    self.VC?.stopLoading()
                }
            }
            
        }
    }

    func cartAddressAPI(parameters:JSON){
        self.VC?.startLoading()
        self.requestAPIs.myCartListApi(parameters: parameters) { (response, error) in
            if error == nil {
                if response != nil{
                    DispatchQueue.main.async {
                            self.myCartListArray = response?.catalogueSaveCartDetailListResponse ?? []
                            print(self.myCartListArray.count,"CartCount")
                        if self.myCartListArray.count > 0 {
                            //self.VC?.cartCountLbl.isHidden = false
                            self.VC?.cartCountLbl.text = "\(self.myCartListArray.count)"
                        }else{
                            self.VC?.cartCountLbl.isHidden = true
                        }
                                for data in self.myCartListArray{
                                    self.totalCartValue = Int(data.sumOfTotalPointsRequired ?? 0.0)
                                    print(self.totalCartValue, "TotalValue")
                                }
                                self.VC?.totalPoints.text = "\(Int(self.totalCartValue))"
                                self.VC?.orderListTableView.reloadData()
                                self.VC?.stopLoading()
                    }
                }
            }
        }
    }
    
    

    
}
