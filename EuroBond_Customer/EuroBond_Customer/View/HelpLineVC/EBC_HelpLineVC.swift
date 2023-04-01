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
    override func viewDidLoad() {
        super.viewDidLoad()
        lottieAnimation(animationView: helpAnimation)
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectTapCall(_ sender: UIButton) {
    }
    
    @IBAction func selectRaiseQueryBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_CreatenewQueryVC") as? EBC_CreatenewQueryVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}
