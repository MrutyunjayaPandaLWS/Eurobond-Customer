//
//  LINC_ScratchCard_VC.swift
//  LINC
//
//  Created by Arokia-M3 on 17/07/21.
//

import UIKit
import SRScratchView
import Lottie

class EBC_ScratchCard_VC: UIViewController,SRScratchViewDelegate {

    @IBOutlet var animationView: LottieAnimationView!
    @IBOutlet var scratchedViewShow: UIView!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var scratchImageView: SRScratchView!
    var previousGameID = -1
    var previousTransactionID = -1
    var previouspointResult = 0
    var gamedetail = [LstGamificationTransaction]()
    var VM = EBC_ScratchCard_VM()
    var customerGamifyTransactionId = 0
    var pointResult = 0
    var isCalled = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.scratchedViewShow.isHidden = false
        self.pointsLabel.text = "\(pointResult) Euros"
        self.scratchImageView.delegate = self
        self.scratchImageView.lineWidth = 40.0
        self.scratchImageView.lineType = .round
        self.scratchImageView.backgroundColor = UIColor.clear
        animationViewFuction()
    }
    
    func scratchCardEraseProgress(eraseProgress: Float) {
        if eraseProgress > 70.0{
            self.scratchImageView.isHidden = true
            self.scratchedViewShow.isHidden = false
            self.animationView!.play()
            if isCalled == 0 {
                isCalled = 1
                let parameters = [
                    "ActionType":"2",
                    "CustomerGamifyTransactionId":"\(customerGamifyTransactionId)",
                    "PointResult":"\(pointResult)"
                        ]
                print(parameters)
                self.VM.magicBoxAPI(paramters: parameters)
                return
            } else {
//                isCalled = 0
                return
            }
        }
    }
    func animationViewFuction(){
        self.animationView.animation = LottieAnimation.named("66949-confetti")
        self.animationView!.contentMode = .scaleAspectFit
        self.animationView!.loopMode = .playOnce
        self.animationView!.animationSpeed = 0.9
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
