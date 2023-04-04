//
//  EBC_WishListVC.swift
//  EuroBond_Customer
//
//  Created by admin on 03/04/23.
//

import UIKit

class EBC_WishListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, WishListDelegate {
    func didTappedRemoveBt(item: EBC_WishListTVC) {
        
    }
    
    func didTappedRedeemBtn(item: EBC_WishListTVC) {
        
    }
    
    
    

    @IBOutlet weak var whislistTV: UITableView!
    @IBOutlet weak var eurostitle: UILabel!
    @IBOutlet weak var eurosBalLbl: UILabel!
    @IBOutlet weak var titleVC: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        whislistTV.delegate = self
        whislistTV.dataSource = self
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectMycartBtn(_ sender: UIButton) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_WishListTVC", for: indexPath) as! EBC_WishListTVC
        cell.selectionStyle = .none
        cell.progressBarView.progress = 0.2
        cell.progressPercent.text = "20 %"
        cell.circleLeadingConstrainnts.constant = CGFloat((cell.progressBarView.frame.width - 18.0) * 0.2)
        cell.productimage.image = UIImage(named: "Xperia-1_grey_groupBF40")
        cell.delegate = self
        return cell
    }

}
