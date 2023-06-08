//
//  ViewwillTickets_VM.swift
//  LINC
//
//  Created by admin on 20/05/22.
//

import Foundation

class ViewwillTickets_VM{
    weak var VC:ViewwillTicketsViewController?
    var requestAPIs = RestAPI_Requests()
    var raffleListTicketsArray = [LstRaffleDetails56]()
    
    
    
    func raffleTicketsList(parameters:JSON){
        self.VC?.startLoading()
        self.requestAPIs.myTicketsRaffles_Post_API(parameters: parameters) { result, error in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.raffleListTicketsArray = result?.lstRaffleDetails ?? []
                        print(self.raffleListTicketsArray.count,"Reffles")
                        if self.raffleListTicketsArray.count > 0 {
                            self.VC?.viewYrTicketsCollectionView.reloadData()
                        }
                    }
                }else{
                    print("Response not binding")
                    self.VC?.stopLoading()
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
