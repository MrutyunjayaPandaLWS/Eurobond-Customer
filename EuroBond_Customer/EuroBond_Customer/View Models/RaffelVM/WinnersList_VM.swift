//
//  WinnersList_VM.swift
//  LINC
//
//  Created by admin on 20/05/22.
//

import UIKit

class WinnersList_VM{
    weak var VC:MyWinnersViewController?
    var requestAPIs = RestAPI_Requests()
    
    var myRafflesWinnersArray = [LstRaffleDetailsRaffledetails]()

    func RaffleWinnerlisting(parameters:JSON){
//        LoadingIndicator.sharedInstance.showIndicator()
        self.requestAPIs.myRafflesDetails_Post_API(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
//                        LoadingIndicator.sharedInstance.hideIndicator()
                        self.myRafflesWinnersArray = result?.lstRaffleDetails ?? []
                        print(self.myRafflesWinnersArray.count)
                        if self.myRafflesWinnersArray.count == 0{
                            self.VC?.viewYrTicketsTableView.reloadData()
                        }else{
                            self.VC?.viewYrTicketsTableView.reloadData()
                        }
                        self.VC?.viewYrTicketsTableView.reloadData()
                    }
                }else{
//                    LoadingIndicator.sharedInstance.hideIndicator()
                    print("Response not binding")
                }
            }else{
                print("ERROR_ \(error)")
                DispatchQueue.main.async {
//                    LoadingIndicator.sharedInstance.hideIndicator()
                }
                
            }
            
        }
    }
}

