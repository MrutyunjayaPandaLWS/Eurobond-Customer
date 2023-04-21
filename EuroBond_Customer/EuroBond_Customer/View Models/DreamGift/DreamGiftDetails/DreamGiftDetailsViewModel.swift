//
//  DreamGiftDetailsViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class DreamGiftDetailsViewModel{

    weak var VC: DreamGiftDetailsViewController?
    var requestAPIs = RestAPI_Requests()
    var myDreamGiftDetailsArray = [LstDreamGift1]()

    
    func removeDreamGift(parameters: JSON, completion: @escaping (RemoveGiftModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.removeDreamGifts(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                        self.VC?.stopLoading()
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
    
    func myDreamGiftDetails(parameters: JSON, completion: @escaping (DetailsGiftModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.myDreamGiftDetails(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                        self.VC?.stopLoading()
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
