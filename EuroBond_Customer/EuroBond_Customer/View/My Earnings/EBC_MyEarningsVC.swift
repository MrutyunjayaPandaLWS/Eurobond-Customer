//
//  EBC_MyEarningsVC.swift
//  EuroBond_Customer
//
//  Created by syed on 20/03/23.
//

import UIKit

class EBC_MyEarningsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var myEarningTV: UITableView!
    @IBOutlet weak var supportBtn: UIButton!
    @IBOutlet weak var myEarningInfoLbl: UILabel!
    @IBOutlet weak var titleVCLBL: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    var flags: String = "1"
    override func viewDidLoad() {
        super.viewDidLoad()

        myEarningTV.delegate = self
        myEarningTV.dataSource = self
//        backBtn.isHidden = true
    }
    

    @IBAction func selectBackBtn(_ sender: UIButton) {
        if flags == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.popViewController(animated: true)
    }

    @IBAction func selectSupportBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_HelpLineVC") as? EBC_HelpLineVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_MyEarningTVC", for: indexPath) as! EBC_MyEarningTVC
        cell.selectionStyle = .none
        
        return cell
    }
}
