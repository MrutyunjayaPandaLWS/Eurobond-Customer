//
//  EBC_HelpLineVC.swift
//  EuroBond_Customer
//
//  Created by syed on 21/03/23.
//

import UIKit
import Lottie

class EBC_HelpLineVC: BaseViewController {

    @IBOutlet weak var raiseQueryLbl: UILabel!
    @IBOutlet weak var anyQueryTitleLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var callNowLbl: UILabel!
    @IBOutlet weak var helpDescLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleVC: UILabel!
    @IBOutlet weak var helpAnimation: LottieAnimationView!
    let phoneNumber = "+91-9783444200"
    override func viewDidLoad() {
        super.viewDidLoad()
        lottieAnimation(animationView: helpAnimation)
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func selectTapCall(_ sender: UIButton) {
        callNumber(phoneNumber: phoneNumber)
    }
    
    @IBAction func selectRaiseQueryBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_QueryListingVC") as? EBC_QueryListingVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {

            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                     application.openURL(phoneCallURL as URL)

                }
            }
        }
    }
    
}
