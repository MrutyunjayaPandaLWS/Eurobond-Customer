//
//  EBC_CodeStatusVC.swift
//  EuroBond_Customer
//
//  Created by admin on 30/03/23.
//

import UIKit

class EBC_CodeStatusVC: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var emptyMessageLbl: UILabel!
    @IBOutlet weak var codeStatusListTV: UITableView!
    @IBOutlet weak var codeStatusImge: UIImageView!
    @IBOutlet weak var codeStatusView: UIView!
    @IBOutlet weak var syncView: UIView!
    @IBOutlet weak var syncImage: UIImageView!
    @IBOutlet weak var syncStatusLbl: UILabel!
    @IBOutlet weak var codeStatusLbl: UILabel!
    @IBOutlet weak var codeSummeryBtn: UIButton!
    @IBOutlet weak var selectAllBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var helpBtn: UIButton!
    @IBOutlet weak var titleVC: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        codeStatusListTV.delegate = self
        codeStatusListTV.dataSource = self
        emptyMessageLbl.isHidden = true
    }

    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectHelpBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_CreatenewQueryVC") as? EBC_CreatenewQueryVC
        navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func selectFilterBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_FilterVC") as? EBC_FilterVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!, animated: true)
    }
    
    @IBAction func selectCodeSummeryBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_CodeSummeryVC") as? EBC_CodeSummeryVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectAllStatusBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectCodeStatusBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectSyncStatusBtn(_ sender: UIButton) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_CodeStatusTVC", for: indexPath) as! EBC_CodeStatusTVC
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
