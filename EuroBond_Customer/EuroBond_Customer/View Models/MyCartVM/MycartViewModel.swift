//
//  MycartViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class MycartViewModel{

    weak var VC: MyCart_VC?
    var requestAPIs = RestAPI_Requests()
    var myCartListArray = [CatalogueSaveCartDetailListResponse1]()
    
    func myCartList(parameters: JSON, completion: @escaping (MyCartModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.myCartList(parameters: parameters) { (result, error) in
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
    
    func increaseProductApi(parameters: JSON, completion: @escaping (IncreaseProductModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.increaseCartCount(parameters: parameters) { (result, error) in
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
    
    func removeProduct(parameters: JSON, completion: @escaping (RemoveCartModel?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.removeProduct(parameters: parameters) { (result, error) in
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
