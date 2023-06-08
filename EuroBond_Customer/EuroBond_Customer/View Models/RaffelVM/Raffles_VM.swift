//
//  LINC_Raffles_VM.swift
//  LINC
//
//  Created by Arokia-M3 on 14/07/21.
//

import UIKit

class Raffles_VM{
    weak var VC:Raffles_VC?
    var requestAPIs = RestAPI_Requests()
    var currentRafflesArray = [LstRaffleDetails5394]()
    var myRafflesArray = [LstRaffleDetails4]()

    func Rafflelisting(parameters:JSON){
        self.myRafflesArray.removeAll()
        //LoadingIndicator.sharedInstance.showIndicator()
        self.VC?.stopLoading()
        self.requestAPIs.myRaffles_Post_API(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        //LoadingIndicator.sharedInstance.hideIndicator()
                        self.myRafflesArray = result?.lstRaffleDetails ?? []
                        if self.myRafflesArray.count == 0{
                            self.VC?.noDataFoundLabel.isHidden = false
                            self.VC?.raffleCollectionView.isHidden = true
                            self.VC?.raffleCollectionView.reloadData()
                        }else{
                            self.VC?.raffleCollectionView.isHidden = false
                            self.VC?.noDataFoundLabel.isHidden = true
                            self.VC?.raffleCollectionView.reloadData()
                            
                        }
                    }
                }else{
                    print("Response not binding")
                    self.VC?.stopLoading()
                    //LoadingIndicator.sharedInstance.hideIndicator()
                }
            }else{
                print("ERROR_ \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                   // LoadingIndicator.sharedInstance.hideIndicator()
                }
                
            }
            
        }
    }

    func currentRafflelisting(parameters:JSON){
        self.currentRafflesArray.removeAll()
        self.VC?.stopLoading()
        self.requestAPIs.currentRaffles_Post_API(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.currentRafflesArray = result?.lstRaffleDetails ?? []
                        if self.currentRafflesArray.count == 0{
                            self.VC?.noDataFoundLabel.isHidden = false
                            self.VC?.raffleCollectionView.isHidden = true
                            self.VC?.raffleCollectionView.reloadData()
                        }else{
                            self.VC?.raffleCollectionView.isHidden = false
                            self.VC?.noDataFoundLabel.isHidden = true
                            self.VC?.raffleCollectionView.reloadData()
                        }
                    }
                }else{
                    self.VC?.stopLoading()
                    print("Response not binding")
                }
            }else{
                print("ERROR_ \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
//                    LoadingIndicator.sharedInstance.hideIndicator()
                }
                
            }
            
        }
    }
    
}
