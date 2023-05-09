//
//  EBC_MillstonesBonussVC.swift
//  EuroBond_Customer
//
//  Created by admin on 03/04/23.
//

import UIKit
import LanguageManager_iOS

class EBC_MillstonesBonussVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    

    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var millStonesListTV: UITableView!
    @IBOutlet weak var addonEurosLbl: UILabel!
    @IBOutlet weak var euroSlabTitleLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var titleVC: UILabel!
    var flags: String = "1"
    var euroBalanceArray = [">25000", ">50,000", ">100,000"]
    var addOnEuros = ["2500", "6000", "15000"]
    var millstonesArray = [EuroBalance]()
    override func viewDidLoad() {
        super.viewDidLoad()
        millStonesListTV.delegate = self
        millStonesListTV.dataSource = self
        tableViewHeight.constant = 140
        languageLocalize()
    }
    func languageLocalize(){
        titleVC.text = "Millstone Bonus".localiz()
        infoLbl.text = "BonusEurostobeawardedtomembersonrechingbelowslabs".localiz()
        euroSlabTitleLbl.text = "Euro Slab".localiz()
        addonEurosLbl.text = "Add on Euros".localiz()
    }
    @IBAction func selectBackBtn(_ sender: UIButton) {
        if flags == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.euroBalanceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_MillstonesBonussTVC", for: indexPath) as! EBC_MillstonesBonussTVC
        cell.selectionStyle = .none
        cell.euroSlabBalanceLbl.text = self.euroBalanceArray[indexPath.row]
        cell.AddonEurosLbl.text = self.addOnEuros[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    

}

class EuroBalance: NSObject{
    
    var euroSlabBalance: String!
    var addonEuros: String!
    init(euroSlabBalance: String, addonEuros: String){
        self.euroSlabBalance = euroSlabBalance
        self.addonEuros = addonEuros
    }
}
