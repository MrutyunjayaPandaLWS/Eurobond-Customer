//
//  LINC_MagicBox_VC.swift
//  LINC
//
//  Created by Arokia-M3 on 17/07/21.
//

import UIKit
import Lottie

class EBC_MagicBoxVC: BaseViewController {
    @IBOutlet var animationView: LottieAnimationView!
    @IBOutlet var taptoopenButton: UIButton!
    @IBOutlet var openAnimationView: LottieAnimationView!
    @IBOutlet var pointsView: UIView!
    @IBOutlet var pointslabel: UILabel!
    var gamedetail = [LstGamificationTransaction]()
    let VM = EBC_MagicBox_VM()
    var referenceId = ""
    var pointResult = 0
    var date = ""
    var customerGamifyTransactionId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.pointslabel.text = "\(gamedetail[0].pointResult ?? 0) Euros"
        animationViewFuction()
        openanimationViewFuction()
    }
    
    @IBAction func taptoEarnButton(_ sender: Any) {
        self.taptoopenButton.isHidden = true
        self.animationView.play { _ in
            self.openAnimationView.isHidden = false
            self.animationView.isHidden = true
            self.openAnimationView.play()
            self.pointsView.isHidden = false
            let parameterJSON = [
                "ActionType" : "2",
                "CustomerGamifyTransactionId" : self.customerGamifyTransactionId,
                "PointResult" : self.pointResult
            ] as? [String:Any]
            print(parameterJSON, "MagicBoxApi")
            self.VM.magicBoxAPI(paramters: parameterJSON!)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func animationViewFuction(){
        self.animationView?.animation = LottieAnimation.named("magic_box")
        self.animationView?.contentMode = .scaleAspectFit
        self.animationView?.loopMode = .playOnce
        self.animationView?.animationSpeed = 0.9
    }

    func openanimationViewFuction(){
        self.openAnimationView?.animation = LottieAnimation.named("magic_box_shield")
        self.openAnimationView?.contentMode = .scaleAspectFit
        self.openAnimationView?.loopMode = .playOnce
        self.openAnimationView?.animationSpeed = 0.9
    }

}
