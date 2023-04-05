//
//  EBC_QueryListingVC.swift
//  EuroBond_Customer
//
//  Created by admin on 04/04/23.
//

import UIKit

class EBC_QueryListingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var queryListingTV: UITableView!
    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var titleVC: UILabel!
    
    var flags: String = "1"
    override func viewDidLoad() {
        super.viewDidLoad()

        queryListingTV.delegate = self
        queryListingTV.dataSource = self
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        if flags == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectNewQueryBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_CreatenewQueryVC") as? EBC_CreatenewQueryVC
        navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_QueryListingTVC", for: indexPath) as! EBC_QueryListingTVC
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    
    
}
