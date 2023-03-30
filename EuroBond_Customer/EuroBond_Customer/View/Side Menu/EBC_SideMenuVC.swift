//
//  EBC_SideMenuVC.swift
//  EuroBond_Customer
//
//  Created by syed on 20/03/23.
//

import UIKit
import SlideMenuControllerSwift

class EBC_SideMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var logoutLbl: UILabel!
    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
    @IBOutlet weak var earnedEurosLbl: UILabel!
    @IBOutlet weak var pointBalLbl: UILabel!
    @IBOutlet weak var memberSinceLbl: UILabel!
    @IBOutlet weak var memberShipIDLbl: UILabel!
    @IBOutlet weak var membershipIdTitleLbl: UILabel!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var sideMenuTV: UITableView!
    
    var sideMenuArrayList: [sideMenuModel] = [
        
        sideMenuModel(sideMenuName: "Home", sideMenuImage: "home"),
        sideMenuModel(sideMenuName: "Scan QR Code", sideMenuImage: "qr"),
        sideMenuModel(sideMenuName: "Enter QR Code", sideMenuImage: "upload1"),
        sideMenuModel(sideMenuName: "Code Status", sideMenuImage: "Group 7691"),
        sideMenuModel(sideMenuName: "My Eraning", sideMenuImage: "bxs-coin-stack 1"),
        sideMenuModel(sideMenuName: "My Redemptions", sideMenuImage: "reademailalt 1"),
        sideMenuModel(sideMenuName: "Redemption Catalogue", sideMenuImage: "card-giftcard 1"),
        sideMenuModel(sideMenuName: "Game Zone", sideMenuImage: "Group 6479"),
        sideMenuModel(sideMenuName: "Refer & Earn", sideMenuImage: "Layer 3"),
        sideMenuModel(sideMenuName: "Add My Assistant", sideMenuImage: "Construction_Worker"),
        sideMenuModel(sideMenuName: "Wishlist", sideMenuImage: "wishlist"),
        sideMenuModel(sideMenuName: "Dream Gift", sideMenuImage: "gift (4)"),
        sideMenuModel(sideMenuName: "Schemes & Offers", sideMenuImage: "bxs-offer 1"),
        sideMenuModel(sideMenuName: "Milestone Bonus", sideMenuImage: "performance"),
        sideMenuModel(sideMenuName: "Helpline", sideMenuImage: "headset 1"),
        sideMenuModel(sideMenuName: "About", sideMenuImage: "document (1)"),
        sideMenuModel(sideMenuName: "FAQ", sideMenuImage: "document (1)"),
        sideMenuModel(sideMenuName: "Term and Conditions", sideMenuImage: "document (1)")
        
//
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuTV.delegate = self
        sideMenuTV.dataSource = self
        heightOfTableView.constant = CGFloat(50*sideMenuArrayList.count)
        logoutView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        
    }
    
    @IBAction func selectMyAccountBtn(_ sender: UIButton) {
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuArrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_SideMenuTVC", for: indexPath) as! EBC_SideMenuTVC
        cell.selectionStyle = .none
        cell.sideMenuName.text = sideMenuArrayList[indexPath.row].sideMenuName
        cell.sideMenuImage.image = UIImage(named: sideMenuArrayList[indexPath.row].sideMenuImage)
        if sideMenuArrayList[indexPath.row].sideMenuName == "Game Zone"{
            cell.sideMenuBadges.isHidden = false
            cell.sideMenuBadges.text = "3"
        }else{
            cell.sideMenuBadges.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @IBAction func selectLogoutBtn(_ sender: UIButton) {
            UserDefaults.standard.set(false, forKey: "IsloggedIn?")
            if #available(iOS 13.0, *) {
                DispatchQueue.main.async {
                    let domain = Bundle.main.bundleIdentifier!
                    UserDefaults.standard.removePersistentDomain(forName: domain)
                    UserDefaults.standard.synchronize()
                    let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                    sceneDelegate.setInitialViewAsRootViewController()
                }
            } else {
                DispatchQueue.main.async {
                    let domain = Bundle.main.bundleIdentifier!
                    UserDefaults.standard.removePersistentDomain(forName: domain)
                    UserDefaults.standard.synchronize()
                    if #available(iOS 13.0, *) {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.setInitialViewAsRootViewController()
                    }
                }
            }
        }
}


struct sideMenuModel{
    let sideMenuName: String
    let sideMenuImage: String
    
}
