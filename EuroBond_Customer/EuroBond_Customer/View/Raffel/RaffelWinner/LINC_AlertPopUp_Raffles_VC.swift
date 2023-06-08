//
//  LINC_AlertPopUp_Raffles_VC.swift
//  LINC
//
//  Created by ArokiaIT on 8/23/21.
//

import UIKit
protocol popuprafflesDelegate : class {
    func YesOrderSummaryDidTap(_ vc: LINC_AlertPopUp_Raffles_VC)
    func NoOrderSummaryDidTap(_ vc: LINC_AlertPopUp_Raffles_VC)

}
class LINC_AlertPopUp_Raffles_VC: UIViewController, dismissScreenDelegate{
    
    @IBOutlet weak var popUpMessageLabel: UILabel!
    var isComeFrom = ""
    var selectedTag = ""
    var raffelConfId = -1
    var totalPoints = 0
    var raffelCampaignId = 0
    var count = 0
//    let VM = LINC_OrderCart_VM()
    var VM2 = LINC_CurrentRafflesDetails_VM()
//    let VMs = LINC_OrderSummary_VM()
    var delegate:popuprafflesDelegate?
    //let loyaltyID = UserDefaults.standard.string(forKey: "UD_LoyaltyId") ?? ""
//    let userID = UserDefaults.standard.integer(forKey: "UD_UserID")
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyID = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""

    override func viewDidLoad() {
        super.viewDidLoad()
  
//        self.VM.VCs = self
//        self.VMs.VCs = self
        self.VM2.VC2 = self
        if isComeFrom == "CurrentRaffleDetails"{
            self.popUpMessageLabel.text = "Are you sure you want buy Ticket?"
        }else if isComeFrom == "OrderSummary"{
            self.popUpMessageLabel.text = "Are you sure want to submit your order?"
        }else if isComeFrom == "orderCart"{
            self.popUpMessageLabel.text = "Are you sure want to remove this product?"
        }else if isComeFrom == "RemoveOrder"{
            self.popUpMessageLabel.text = "Are you sure want to remove this product?"
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    @objc func dismissedScreen(notification:Notification){
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func yesButton(_ sender: Any) {
        if isComeFrom == "CurrentRaffleDetails"{
            let parameter1JSON = [
                "ActionType":1,
                "ActorId":userID,
                "Quantity":"\(count)",
                "RaffelConfId":raffelConfId
            ] as [String:Any]
            print("SavedRaffelsDetails", parameter1JSON)
            self.VM2.raffleSubmit2(parameters: parameter1JSON)
//                let parameterJSON1 = [
//                    "RaffelCampaignId": raffelConfId,
//                    "ActionType": 7,
//                    "ActorId": userID
//                ] as? [String:Any]
//                print("Boyoyasdfsadfdsa", parameterJSON1!)
//                self.VM2.raffleSubmit3(parameters: parameterJSON1!)
//                let parameterJSON2 = [
//                    "ActionType": 8,
//                    "ActorId": userID,
//                    "RaffelCampaignId": raffelConfId
//                ] as? [String:Any]
//                print("TotalTicketCount", parameterJSON2!)
//                self.VM2.raffleTotalTicketsCount(parameters: parameterJSON2!)
        }else if isComeFrom == "OrderSummary"{
            self.delegate?.YesOrderSummaryDidTap(self)
        }else if isComeFrom == "orderCart"{
            let parameterJSON = [
                       "ActionType":"1",
                       "ActorId":"\(userID)",
                       "CustomerCartId":"\(selectedTag)"
                   ] as? [String:Any]
                   print("parameter cart screen", parameterJSON)
//                   self.VM.orderRemove(parameters: parameterJSON!)
//                   self.VM.VC?.cartTableView.reloadData()
                    self.dismiss(animated: true, completion: nil)
        }else if isComeFrom == "RemoveOrder"{
            let parameterJSON = [
                "ActionType":"1",
                "ActorId":"\(userID)",
                "CustomerCartId":"\(selectedTag)"
            ] as? [String:Any]
            print("Parameter", parameterJSON)
//            self.VMs.orderRemove(parameters: parameterJSON!)
//            self.VMs.VC?.orderSummaryTableView.reloadData()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func noButton(_ sender: Any) {
        self.delegate?.NoOrderSummaryDidTap(self)
        self.dismiss(animated: true, completion: nil)
    }
    
    //Delegate
    
    func dismissScreen(_ vc: LINC_OrderSuccess_VC) {
        self.dismiss(animated: true){
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: .orderSuccess, object: nil)
        }
        print("delegate is Called")
    }
    
}
