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
        
        
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuTV.delegate = self
        sideMenuTV.dataSource = self
        heightOfTableView.constant = CGFloat(50*sideMenuArrayList.count)
        logoutView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(closingSideMenu), name: Notification.Name.sideMenuClosing, object: nil)
    }
    
    @IBAction func selectMyAccountBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyProfileandBankDetailsVC") as? MyProfileandBankDetailsVC
        navigationController?.pushViewController(vc!, animated: true)
    }
 
    
    @IBAction func selectDeleteBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectLogoutBtn(_ sender: UIButton) {
            UserDefaults.standard.set(0, forKey: "IsloggedIn?")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sideMenuArrayList[indexPath.row].sideMenuName{
        case "Home":
                closeLeft()
        case "Scan QR Code":
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanOrUpload_VC") as? ScanOrUpload_VC
            vc?.fromSideMenu = "SideMenu"
//            vc?.scanner = "Scan"
            navigationController?.pushViewController(vc!, animated: true)
        case "Enter QR Code":
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_ScannerAndUploadVC") as? ScanOrUpload_VC
            vc?.fromSideMenu = "SideMenu"
//            vc?.scanner = "Upload"
            navigationController?.pushViewController(vc!, animated: true)
        case "Code Status":
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_CodeStatusVC") as? EBC_CodeStatusVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "My Eraning":
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_MyEarningsVC") as? EBC_MyEarningsVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "My Redemptions":
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_MyRedemptionVC") as? EBC_MyRedemptionVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "Redemption Catalogue":
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RedeemNowVC") as? EBC_RedeemNowVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "Game Zone":
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_GameCentre_VC") as? EBC_GameCentre_VC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "Refer & Earn":
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RefferAndEarnVC") as? EBC_RefferAndEarnVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "Add My Assistant":
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_MyAssistantVC") as? EBC_MyAssistantVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "Wishlist":
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_WishListVC") as? EBC_WishListVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "Dream Gift":
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DreamGiftVC") as? EBC_DreamGiftVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "Schemes & Offers":
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_SchemesAndOffersVC") as? EBC_SchemesAndOffersVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "Milestone Bonus":
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_MillstonesBonussVC") as? EBC_MillstonesBonussVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "Helpline":
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_QueryListingVC") as? EBC_QueryListingVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "About":
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_AboutVC") as? EBC_AboutVC
            navigationController?.pushViewController(vc!, animated: true)
        case "FAQ":
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_FAQVC") as? EBC_FAQVC
            navigationController?.pushViewController(vc!, animated: true)
        case "Term and Conditions":
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_TermsAndConditionsVC") as? EBC_TermsAndConditionsVC
            navigationController?.pushViewController(vc!, animated: true)
        default:
            print("no data match")
        }
    }
    
    
    @objc func closingSideMenu(){
        self.closeLeft()

    }

}


struct sideMenuModel{
    let sideMenuName: String
    let sideMenuImage: String
    
}
