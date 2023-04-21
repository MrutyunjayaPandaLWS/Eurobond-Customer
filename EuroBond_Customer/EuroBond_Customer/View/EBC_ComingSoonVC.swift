//
//  EBC_ComingSoonVC.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 17/04/2023.
//

import UIKit
import Lottie
class EBC_ComingSoonVC: BaseViewController {
    
    
    @IBOutlet weak var comingSoonAnimation: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lottieAnimation(animationView: comingSoonAnimation)
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
