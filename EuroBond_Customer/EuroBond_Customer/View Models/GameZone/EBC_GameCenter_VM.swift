//
//  LINC_GameCenter_VM.swift
//  LINC
//
//  Created by Arokia-M3 on 16/07/21.
//

import Foundation

class EBC_GameCenter_VM{
    
    weak var VC:EBC_GameCentre_VC?
    var requestAPIs = RestAPI_Requests()
    var gameListArray = [LstGamificationTransaction]()

    func gameListDetails(parameters:JSON){
        //LoadingIndicator.sharedInstance.showIndicator()
        self.requestAPIs.gamificationListing_Post_API(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                       // LoadingIndicator.sharedInstance.hideIndicator()
                        self.gameListArray = result?.lstGamificationTransaction ?? []
                        print(self.gameListArray.count)
                        if self.gameListArray.count == 0 {
                            self.VC?.gameCentreCollectionView.isHidden = true
                        } else {
                            self.VC?.gameCentreCollectionView.isHidden = false
                        }
                        self.VC?.gameCentreCollectionView.reloadData()
                    }
                }else{
                    print("NO RESPONSE")
                    //LoadingIndicator.sharedInstance.hideIndicator()
                    self.VC?.stopLoading()
                }
            }else{
                print("ERROR_GOODPACK \(error)")
                //LoadingIndicator.sharedInstance.hideIndicator()
                self.VC?.stopLoading()
            }
        }
    }
}
