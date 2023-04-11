//
//  EBC_Dashboard_2_VC.swift
//  EuroBond_Customer
//
//  Created by syed on 18/03/23.
//

import UIKit
import ImageSlideshow

class EBC_Dashboard_2_VC: UIViewController {

    @IBOutlet weak var termCondLbl: UILabel!
    @IBOutlet weak var helpLineLbl: UILabel!
    @IBOutlet weak var needHelpLbl: UILabel!
    @IBOutlet weak var codeSummeryLbl: UILabel!
    @IBOutlet weak var syncStatusLbl: UILabel!
    @IBOutlet weak var codeStatusLbl: UILabel!
    @IBOutlet weak var memberSinceLbl: UILabel!
    @IBOutlet weak var memberSinceTitleLbl: UILabel!
    @IBOutlet weak var membershipIDLbl: UILabel!
    @IBOutlet weak var membershipIDTitleLbl: UILabel!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var deginationLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    @IBOutlet weak var notificationBadgesLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bottomView.layer.masksToBounds = true
        self.bottomView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        bottomView.layer.cornerRadius = 50
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOffset = .zero
        bottomView.layer.cornerRadius = 2
        bottomView.layer.shadowOpacity = 0.1
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
    
    @IBAction func selectNotificationBtn(_ sender: UIButton) {
    }
    
    
    @IBAction func selectCodeStatusBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "EBC_CodeStatusVC") as? EBC_CodeStatusVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectSyncStatusBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "EBC_CodeStatusVC") as? EBC_CodeStatusVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectCodeSummeryBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "EBC_CodeSummeryVC") as? EBC_CodeSummeryVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectUploadCodeBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectScanCodeBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectHelpLineBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "EBC_HelpLineVC") as? EBC_HelpLineVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectTermCondBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "EBC_TermsAndConditionsVC") as? EBC_TermsAndConditionsVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
