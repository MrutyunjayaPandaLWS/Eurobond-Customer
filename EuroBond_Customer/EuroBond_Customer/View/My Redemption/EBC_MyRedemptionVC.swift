//
//  EBC_MyRedemptionVC.swift
//  EuroBond_Customer
//
//  Created by syed on 20/03/23.
//

import UIKit

class EBC_MyRedemptionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var myRedemptionTV: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    var flags: String = "1"
    override func viewDidLoad() {
        super.viewDidLoad()

        myRedemptionTV.delegate = self
        myRedemptionTV.dataSource = self
//        backBtn.isHidden = true
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        if flags == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_MyRedemptionTVC", for: indexPath) as! EBC_MyRedemptionTVC
        cell.selectionStyle = .none
        if indexPath.row == 1{
            cell.statusView.backgroundColor = approvedColor
        }else{
            cell.statusView.backgroundColor = pendingColor
        }
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_MyRedeemptionDetailsVC") as? EBC_MyRedeemptionDetailsVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
