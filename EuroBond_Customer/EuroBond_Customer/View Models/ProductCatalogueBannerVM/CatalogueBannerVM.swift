//
//  CatalogueBannerVM.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 19/04/2023.
//

import Foundation
import UIKit

class CatalogueBannerVM{
    
    weak var VC: EBC_ProductCatalogueVC?
    var requestAPIs = RestAPI_Requests()
    var productCatalgoueListArray = [ObjImageGalleryList1]()
    func productCatalogueList(parameter: JSON){
        DispatchQueue.main.async {
            self.VC!.startLoading()
        }
        self.requestAPIs.cataloguedBanner_API(parameters: parameter) { (result, error) in
            
            if error == nil{
                if result != nil{
                    
                    DispatchQueue.main.async {
                        
                        self.productCatalgoueListArray = result?.objImageGalleryList ?? []
                        print(self.productCatalgoueListArray.count)
                        if self.productCatalgoueListArray.count != 0 {
                            self.VC!.productListingCV.isHidden = false
                            self.VC!.productListingCV.reloadData()
                        }else{
                            self.VC!.productListingCV.isHidden = true
                        }
                        
                        self.VC!.stopLoading()
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.VC!.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC!.stopLoading()
                }
            }
        }
    }
}
