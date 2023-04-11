//
//  EBC_DashboardVC.swift
//  EuroBond_Customer
//
//  Created by syed on 18/03/23.
//

import UIKit
import ImageSlideshow
import SlideMenuControllerSwift

class EBC_DashboardVC: UIViewController {


    @IBOutlet weak var myEarningsLbl: UILabel!
    @IBOutlet weak var myredemptionLbl: UILabel!
    @IBOutlet weak var codeStatusLbl: UILabel!
    @IBOutlet weak var bottomView1: UIView!
    @IBOutlet weak var helplineLbl: UILabel!
    @IBOutlet weak var eurobondsLbl: UILabel!
    @IBOutlet weak var referAndEarnLbl: UILabel!
    @IBOutlet weak var shemesAndOffersLbl: UILabel!
    @IBOutlet weak var gameZoneLbl: UILabel!
    @IBOutlet weak var redeemNowLbl: UILabel!
    @IBOutlet weak var totalBalanceLbl: UILabel!
    @IBOutlet weak var totalEurosTitleLbl: UILabel!
    @IBOutlet weak var memberTypeLbl: UILabel!
    @IBOutlet weak var memberTypeTitleLbl: UILabel!
    @IBOutlet weak var membershipIDLbl: UILabel!
    @IBOutlet weak var membershipIdTitleLbl: UILabel!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    @IBOutlet weak var notificationBadges: UILabel!
    @IBOutlet weak var menuBtn: UIButton!

    var status = 1
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bottomView1.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        bottomView1.layer.cornerRadius = 30
        slideMenuController()?.changeLeftViewWidth(self.view.frame.size.width * 0.89)
        SlideMenuOptions.contentViewScale = 1
    }
    
    @IBAction func selectMenuBtn(_ sender: UIButton) {
        openLeft()
        
    }
    
    @IBAction func selectNotificationBtn(_ sender: UIButton) {
 
    }
    
    @IBAction func selectRedeemNowBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RedeemNowVC") as?  EBC_RedeemNowVC
        navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func selectGameZoneBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_GameCentre_VC") as?  EBC_GameCentre_VC //EBC_GameZoneVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectOffersBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_SchemesAndOffersVC") as?  EBC_SchemesAndOffersVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func selectReferAndEarnBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RefferAndEarnVC") as?  EBC_RefferAndEarnVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectEurobondsBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_EurobondsVC") as?  EBC_EurobondsVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectHelpLineBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_HelpLineVC") as?  EBC_HelpLineVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func selectScanCodeBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectUploadCodeBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectCodeStatusBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_CodeStatusVC") as? EBC_CodeStatusVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectMyredeemptionBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_MyRedemptionVC") as? EBC_MyRedemptionVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectMyEarningsBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_MyEarningsVC") as? EBC_MyEarningsVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
