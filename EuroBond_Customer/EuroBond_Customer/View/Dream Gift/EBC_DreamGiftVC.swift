//
//  EBC_DreamGiftVC.swift
//  EuroBond_Customer
//
//  Created by admin on 03/04/23.
//

import UIKit

class EBC_DreamGiftVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DreamGiftDelegate {
    func didTappedRedeemBtn(Item: EBC_DreamGiftTVC) {
    }
    
    func didTappedRemovedBtn(Item: EBC_DreamGiftTVC) {
    }
    
   
    @IBOutlet weak var dreamListTV: UITableView!
    @IBOutlet weak var titleVC: UILabel!
    var flags = "1"
    override func viewDidLoad() {
        super.viewDidLoad()

        dreamListTV.delegate = self
        dreamListTV.dataSource = self
        
    }
    


    @IBAction func selectBackBtn(_ sender: UIButton) {
        if flags == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.popViewController(animated: true)
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
