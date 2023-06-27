//
//  LINC_CurrentRafflesDetails_VM.swift
//  LINC
//
//  Created by Arokia-M3 on 14/07/21.
//

import UIKit
import SDWebImage
class LINC_CurrentRafflesDetails_VM{
    weak var VC:LINC_CurrentraffleDetails_VC?
    weak var VC2: LINC_AlertPopUp_Raffles_VC?
    var requestAPIs = RestAPI_Requests()
    var raffleListTicketsArray = [LstRaffleDetails]()
    var currentRafflesArray = [LstRaffleDetails5394]()
    func currentRafflelisting(parameters:JSON){
        self.currentRafflesArray.removeAll()
        self.VC?.startLoading()
//        LoadingIndicator.sharedInstance.showIndicator()
        self.requestAPIs.currentRaffles_Post_API(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
//                        LoadingIndicator.sharedInstance.hideIndicator()
                        self.currentRafflesArray = result?.lstRaffleDetails ?? []
                        for data in self.currentRafflesArray {
                            if self.VC?.raffelCampaignId == data.raffelCampaignId{
                                self.VC?.raffelCampaignId = data.raffelCampaignId ?? 0
                                print(data.noofTicketPurchase)
                                print(data.ticketPoints)
                                self.VC?.totalTicketsPurchaseLbl.text = "\(data.noofTicketPurchase ?? 0)"
                                self.VC?.totalPointsRedeemedLbl.text = "\(data.ticketPoints ?? 0)"
                                self.VC?.descriptionlabel.text = data.raffelCampaignDescription ?? ""
                                let x = (data.validityTo ?? "").split(separator: " ")
                                self.VC?.validUntilLabel.text = "\(x[0])"
                                self.VC?.statusLabel.text = data.status ?? ""
                                self.VC?.pointsperTicketLabel.text = "Total Points \(data.pointsPerTicket ?? 0)"
                                self.VC?.pointsValue = "\(data.pointsPerTicket ?? 0)"
                                self.VC?.ticketCountLabel.text = "Ticket Count : 1"
                                print("Points Values is", self.VC?.pointsValue )
                                print(self.VC?.pointsperTicketLabel.text!, "Total Points")
                                self.VC?.rafflenameLabel.text = data.raffelCampaignName ?? ""
                                let quantityValue = data.quantity ?? ""
                                print(quantityValue)
                                if quantityValue == "0"{
                        //            self.pointsperTicketLabel.text = UIColor.lightGray.cgColor as? String
                                    self.VC?.raffleQuantityStackView.isUserInteractionEnabled = false
                                    self.VC?.ticketCounterView.backgroundColor = UIColor.lightGray
                                    self.VC?.buyTicketView.backgroundColor = UIColor.lightGray
                                    self.VC?.buyTicketButton.isEnabled = false
                                } else {
                        //            self.pointsperTicketLabel.text = UIColor.lightGray.cgColor as? String
                                    self.VC?.raffleQuantityStackView.isUserInteractionEnabled = true
                                    self.VC?.ticketCounterView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                                    self.VC?.buyTicketView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
                                    self.VC?.buyTicketButton.isEnabled = true
                                }
                                
//                                if data.bannerUrl ?? "" != ""{
//                                    let imageURl = data.bannerUrl ?? ""
//                                    let filteredURLArray = imageURl.split(separator: "~")
//                                    let urltoUse = String(rafflesURL + filteredURLArray[0]).replacingOccurrences(of: " ", with: "%20")
//
//                                    let urlt = URL(string: "\(urltoUse)")
//                                    print(urlt)
//                                    let transformer = SDImageResizingTransformer(size: CGSize(width: (self.VC?.view.frame.width)!, height: 200), scaleMode: .fill)
//                                    self.VC?.raffleImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"), context: [.imageTransformer: transformer])
//                                }else{
//                                    self.VC?.raffleImage.image = UIImage(named: "ic_default_img")
//                                }
                            }
                        }
                        
                        
                    }
                }else{
                    self.VC?.stopLoading()
//                    LoadingIndicator.sharedInstance.hideIndicator()
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
  
    func raffleSubmit(parameters:JSON){
        self.VC?.startLoading()
//        LoadingIndicator.sharedInstance.showIndicator()
        self.requestAPIs.submitraffles_Post_API(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
//                        LoadingIndicator.sharedInstance.hideIndicator()
                        print(result?.returnMessage ?? "-1")
                     
                    }
                }else{
                    print("Response not binding")
                    self.VC?.stopLoading()
//                    LoadingIndicator.sharedInstance.hideIndicator()
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
    
    func raffleSubmit2(parameters:JSON){
        self.VC?.startLoading()
//        LoadingIndicator.sharedInstance.showIndicator()
        self.requestAPIs.submitraffles_Post_API(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
//                        LoadingIndicator.sharedInstance.hideIndicator()
                        print(result?.returnMessage ?? "-1")
                        self.raffleListTicketsArray = result?.lstRaffleDetails ?? []
                        self.VC2?.delegate?.YesOrderSummaryDidTap(self.VC2!.self)
                        self.VC2?.dismiss(animated: true, completion: nil)
                      
                    }
                }else{
                    print("Response not binding")
                    self.VC?.stopLoading()
//                    LoadingIndicator.sharedInstance.hideIndicator()
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
    func raffleSubmit3(parameters:JSON){
        self.VC?.raffleListTicketsArray.removeAll()
        self.VC?.startLoading()
//        LoadingIndicator.sharedInstance.showIndicator()
        self.requestAPIs.getRafflesTicketsListApi(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
//                        LoadingIndicator.sharedInstance.hideIndicator()
                        self.VC?.raffleListTicketsArray1 = result?.lstRaffleDetails ?? []
                        print(self.VC?.raffleListTicketsArray1.count,"- Total Tickets Count List")
                        if self.VC?.raffleListTicketsArray1.count != 0 {
                            self.VC?.viewYrTicketsCollectionView.isHidden = false
                            self.VC?.viewYrTicketsCollectionView.reloadData()
                        }else{
                            self.VC?.viewYrTicketsCollectionView.isHidden = true
                        }
                      
                    }
                }else{
                    print("Response not binding")
                    self.VC?.stopLoading()
//                    LoadingIndicator.sharedInstance.hideIndicator()
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
    func raffleTotalTicketsCount(parameters:JSON){
        self.VC?.raffleListTicketsArray.removeAll()
//        LoadingIndicator.sharedInstance.showIndicator()
        self.VC?.startLoading()
        self.requestAPIs.getRafflesTicketsListApi1(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
//                        LoadingIndicator.sharedInstance.hideIndicator()
                        self.VC?.raffleListTicketsArray2 = result?.lstRaffleDetails ?? []
                        print(self.VC?.raffleListTicketsArray2.count,"- Ticket Count")
                        if self.VC?.raffleListTicketsArray1.count != 0 {
//                            self.VC?.raffleListTicketsArray2[0].noofTicketPurchase ?? 0)
                            print(self.VC?.raffleListTicketsArray2[0].noofTicketPurchase ?? 0)
                            print(self.VC?.raffleListTicketsArray2[0].ticketPoints ?? 0)
//                            self.VC?.totalTicketsPurchaseLbl.text = "\(self.VC?.raffleListTicketsArray2[0].noofTicketPurchase ?? 0)"
//                            self.VC?.totalPointsRedeemedLbl.text = "\(self.VC?.raffleListTicketsArray2[0].ticketPoints ?? 0)"
                        }else{
                         
                        }
                      
                    }
                }else{
                    print("Response not binding")
                    self.VC?.stopLoading()
//                    LoadingIndicator.sharedInstance.hideIndicator()
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
//    func customerDashboard(parameters:JSON){
//        self.VC?.startLoading()
////        LoadingIndicator.sharedInstance.showIndicator()
//        self.requestAPIs.customer_Post_API(parameters: parameters) { (result, error) in
//            if error == nil {
//                if result != nil{
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
////                        LoadingIndicator.sharedInstance.hideIndicator()
//                        UserDefaults.standard.setValue(result?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0, forKey: "UD_redeemablePointsBalance")
//                        print(result?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0)
//                        self.VC?.yourPointsBalance.text = "\(result?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0)"
//                        self.VC?.points = "\(result?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0)"
//                    }
//                }else{
//                    print("Response not binding")
//                    self.VC?.stopLoading()
////                    LoadingIndicator.sharedInstance.hideIndicator()
//                }
//            }else{
//                print("ERROR_ \(error)")
//                DispatchQueue.main.async {
//                    self.VC?.stopLoading()
////                    LoadingIndicator.sharedInstance.hideIndicator()
//                }
//            }
//        }
//    }
    
    
    
}
