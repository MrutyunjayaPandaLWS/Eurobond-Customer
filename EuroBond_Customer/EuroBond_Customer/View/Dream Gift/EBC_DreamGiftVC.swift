//
//  EBC_DreamGiftVC.swift
//  EuroBond_Customer
//
//  Created by admin on 03/04/23.
//

import UIKit

class EBC_DreamGiftVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, DreamGiftDelegate, popUpAlertDelegate {
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    func didTappedRedeemBtn(Item: EBC_DreamGiftTVC) {
    }
    
    func didTappedRemovedBtn(Item: EBC_DreamGiftTVC) {
    }
    
   
    @IBOutlet weak var dreamListTV: UITableView!
    @IBOutlet weak var titleVC: UILabel!
    var flags = "1"
//    var VM = DreamGiftListingVM()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.VM.VC = self
        dreamListTV.delegate = self
        dreamListTV.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "No Internet Connection".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            self.dreamGiftListApi()
        }
    }


    @IBAction func selectBackBtn(_ sender: UIButton) {
        if flags == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func dreamGiftListApi(){
       // self.VM.myDreamGiftListArray.removeAll()
        let parameters = [
            "ActionType": "1",
            "ActorId": "\(self.userId)",
            "LoyaltyId": "\(loyaltyId)",
            "Status": "2"
        ] as [String: Any]
        print(parameters)
//        self.VM.dreamGiftListApi(parameter: parameters)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_DreamGiftTVC", for: indexPath) as! EBC_DreamGiftTVC
        cell.selectionStyle = .none
        cell.progressBarView.progress = 0.20
        cell.circleViewLeadingConstraint.constant = CGFloat((cell.progressBarView.frame.width - 20) * 0.2)
        cell.progressPercentLbl.text = "20 %"
        cell.eurosRequiredBalLbl.text = "15000"
        cell.tdsPointLbl.text = "100000"
        cell.createdDateLbl.text = "02-04-2023"
        cell.desiredDateLbl.text = "20-04-2923"
        cell.delegate = self
        cell.productName.text = "Royal Enfield Classic 350 Bike"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc =  UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DreamGiftDetailsVC") as? EBC_DreamGiftDetailsVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}
