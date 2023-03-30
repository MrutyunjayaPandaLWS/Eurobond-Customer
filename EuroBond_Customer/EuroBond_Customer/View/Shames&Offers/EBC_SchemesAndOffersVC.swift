//
//  EBC_SchemesAndOffersVC.swift
//  EuroBond_Customer
//
//  Created by syed on 21/03/23.
//

import UIKit

class EBC_SchemesAndOffersVC: UIViewController, UITableViewDelegate, UITableViewDataSource, SchemesAndOffersDelegate {
    
    func didTappedViewBtn(item: EBC_SchemesAndOffersTVC) {
        let  vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_OffersDetailsVC") as? EBC_OffersDetailsVC
        navigationController?.pushViewController(vc!, animated: true)
        
    }
    
 
    @IBOutlet weak var shemesAndOffersTV: UITableView!
    @IBOutlet weak var titleVc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        shemesAndOffersTV.delegate = self
        shemesAndOffersTV.dataSource = self
        
    }
    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_SchemesAndOffersTVC", for: indexPath) as! EBC_SchemesAndOffersTVC
        cell.selectionStyle = .none
        cell.delegate = self
        cell.offersImage.image = UIImage(named: "demoImg-2")
        return cell
    }
    
    
}
