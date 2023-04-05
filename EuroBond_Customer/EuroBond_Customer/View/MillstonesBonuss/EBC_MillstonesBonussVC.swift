//
//  EBC_MillstonesBonussVC.swift
//  EuroBond_Customer
//
//  Created by admin on 03/04/23.
//

import UIKit

class EBC_MillstonesBonussVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    

    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var millStonesListTV: UITableView!
    @IBOutlet weak var addonEurosLbl: UILabel!
    @IBOutlet weak var euroSlabTitleLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var titleVC: UILabel!
    var flags: String = "1"
    override func viewDidLoad() {
        super.viewDidLoad()
        millStonesListTV.delegate = self
        millStonesListTV.dataSource = self
        tableViewHeight.constant = 90
        
    }

    @IBAction func selectBackBtn(_ sender: UIButton) {
        if flags == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_MillstonesBonussTVC", for: indexPath) as! EBC_MillstonesBonussTVC
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    

}
