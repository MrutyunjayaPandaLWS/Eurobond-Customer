//
//  EBC_WishListVC.swift
//  EuroBond_Customer
//
//  Created by admin on 03/04/23.
//

import UIKit
import LanguageManager_iOS

class EBC_WishListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, WishListDelegate {
    func didTappedRemoveBt(item: EBC_WishListTVC) {
        
    }
    
    func didTappedRedeemBtn(item: EBC_WishListTVC) {
        
    }
    
    
    

    @IBOutlet weak var whislistTV: UITableView!
    @IBOutlet weak var eurostitle: UILabel!
    @IBOutlet weak var eurosBalLbl: UILabel!
    @IBOutlet weak var titleVC: UILabel!
    var flags = "1"
    override func viewDidLoad() {
        super.viewDidLoad()

        whislistTV.delegate = self
        whislistTV.dataSource = self
        localizSetup()
        alertPopUp()
    }
    func localizSetup(){
        titleVC.text = "Whislist".localiz()
        eurostitle.text = "EUROS".localiz()
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        if flags == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectMycartBtn(_ sender: UIButton) {
    }
    
    func alertPopUp(){
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SuccessPopUpMessage2") as? SuccessPopUpMessage2
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
//        vc?.message = "Only 90% of your available Euros can be redeemable"
//        vc?.delegate = self
        present(vc!, animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc =  UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_WishListDetailsVC") as? EBC_WishListDetailsVC
        navigationController?.pushViewController(vc!, animated: true)
    }

}
