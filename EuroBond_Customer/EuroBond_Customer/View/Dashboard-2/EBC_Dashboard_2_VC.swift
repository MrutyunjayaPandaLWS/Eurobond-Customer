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
    }
    
    @IBAction func selectNotificationBtn(_ sender: UIButton) {
    }
    
    
    @IBAction func selectCodeStatusBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectSyncStatusBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectCodeSummeryBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectUploadCodeBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectScanCodeBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectHelpLineBtn(_ sender: Any) {
    }
    
    @IBAction func selectTermCondBtn(_ sender: UIButton) {
    }
    
    
}
