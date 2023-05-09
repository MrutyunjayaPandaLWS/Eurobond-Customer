//
//  EBC_OffersandSchemeVM.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 18/04/2023.
//

import Foundation
import LanguageManager_iOS
class EBC_OffersandSchemeVM{
    
    weak var VC: EBC_SchemesAndOffersVC?
    var requestAPIs = RestAPI_Requests()
    var offersandPromotionsArray = [LstPromotionJsonList]()

    
    func offersandPromotionsApi(parameters: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.schemeandOffersApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.offersandPromotionsArray = result?.lstPromotionJsonList ?? []
                        print(self.offersandPromotionsArray.count, "Offers Count")
                        if self.offersandPromotionsArray.count != 0{
                           
                            self.VC?.shemesAndOffersTV.isHidden = false
                            self.VC?.shemesAndOffersTV.reloadData()
                            self.VC?.noDataFoundLbl.isHidden = true
                        }else{
                            //self.VC?.view.makeToast("No Data Found".localiz(), duration: 3.0, position: .center)
                            self.VC?.noDataFoundLbl.isHidden = false
                            self.VC?.noDataFoundLbl.text = "No Data Found".localiz()
                            self.VC?.shemesAndOffersTV.isHidden = true
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

