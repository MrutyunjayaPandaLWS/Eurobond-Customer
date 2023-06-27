//
//  VariousWheelSimpleViewController.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 7/10/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import UIKit
import SwiftFortuneWheel
import Lottie

class VariousWheelSimpleVC: BaseViewController, popUpDelegate1 {
    func popupAlertDidTap1(_ vc: PopupAlertOne_VC) {}
    
    @IBOutlet weak var SuccessPopUp: UIView!
    @IBOutlet weak var okOutBtn: GradientButton!
    
    @IBOutlet weak var successMessageLbl: UILabel!
    
    @IBOutlet weak var betterLuckNextTime: UIView!
    @IBOutlet weak var animationPointsView: LottieAnimationView!
    @IBOutlet weak var betterLuckNextTimeOutBTN: UIButton!
    
    @IBOutlet weak var betterluckNxtOutLbl: UILabel!
    @IBOutlet weak var centerView: UIView! {
        didSet {
//            centerView.layer.cornerRadius = centerView.bounds.width / 2
//            centerView.layer.borderColor = CGColor.init(srgbRed: CGFloat(256), green: CGFloat(256), blue: CGFloat(256), alpha: 1)
//            centerView.layer.borderWidth = 7
        }
    }
    
    @IBOutlet weak var wheelControl: SwiftFortuneWheel! {
        didSet {
            wheelControl.configuration = .variousWheelSimpleConfiguration
            wheelControl.slices = slices
            wheelControl.pinImage = "SpinnImage-1"
            
            wheelControl.pinImageViewCollisionEffect = CollisionEffect(force: 8, angle: 20)
            
            wheelControl.edgeCollisionDetectionOn = true
        }
    }
    var arrayDataPass = ""
    var prizes = [String]()
    var gameId:Int = 0, resultValue:Int = 0
    var pointResult = ""
    var VM = EBC_SpinWheel_VM()
    var finishIndexData:String = ""
    var fullRotationUntilFinishTextField = "13"
    var animationDurationLBL = "5"
    
    var selectedIndex = -1
    var findingIndex = ""
    

    
    
    lazy var slices: [Slice] = {
        let spinPointsArray = arrayDataPass.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        prizes.append(contentsOf: spinPointsArray)
        if prizes.count < 12{
            let extraPoint = "0"
            prizes.insert(extraPoint, at: 11)
        }
        print(prizes)
        let slices = prizes.map({ Slice.init(contents: [Slice.ContentType.text(text: $0, preferences: .variousWheelSimpleText)]) })
        return slices
    }()

    var finishIndex: Int {
        return Int.random(in: 0..<wheelControl.slices.count)
    }
    
    var rotationStopAtIndex: Int {
        print(pointResult)
        
        if let index = prizes.firstIndex(where: { $0 == pointResult }) {
            print("Index Element: \(index)")
            self.findingIndex = "\(index)"
            print(self.findingIndex)
            
        } else {
            print("Wrong Element")
        }
        
        guard let index = Int(self.findingIndex) else { return 0 }
        guard index < wheelControl.slices.count else { return wheelControl.slices.count - 1 }
        return index
    }

    
    var fullRotationsCount: Int {
        guard let index = Int(fullRotationUntilFinishTextField) else { return 13 }
        return index
    }
    
    var animationDuration: Int {
        guard let index = Int(animationDurationLBL) else { return 5 }
        return index
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.okOutBtn.addTarget(self, action: #selector(sendToGameScreen), for: .touchUpInside)
        self.betterLuckNextTimeOutBTN.addTarget(self, action: #selector(nextTimePopUp), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        centerView.layer.cornerRadius = centerView.bounds.width / 2
    }
    
    @objc func sendToGameScreen(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func nextTimePopUp(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func rotateTap(_ sender: Any) {
//        let finishingIndex = self.finishIndex
//            print(finishingIndex)
        
        let _animationDuration = CFTimeInterval(integerLiteral: Int64(animationDuration))
        wheelControl.startRotationAnimation(finishIndex: rotationStopAtIndex, fullRotationsCount: fullRotationsCount, animationDuration: _animationDuration) { (success) in
            print(self.prizes[self.rotationStopAtIndex])
            self.selectedIndex = self.rotationStopAtIndex
            self.wheelControl.slices = self.slices
            DispatchQueue.main.async {
                self.wheelControl.rotate(toIndex: self.rotationStopAtIndex)
                self.finishIndexData = self.prizes[self.rotationStopAtIndex]
                
                if self.prizes[self.rotationStopAtIndex] == "0" {
                    self.betterluckNxtOutLbl.text = "Better luck next time !"
                }else{
                self.successMessageLbl.text = "\(self.prizes[self.rotationStopAtIndex]) "
                }
                self.spinnWheelData(resultValue: Int(self.prizes[self.rotationStopAtIndex]) ?? 0, gameId: self.gameId)
            }
        }
    }
    
    func spinnWheelData(resultValue: Int, gameId: Int){
        let parameter = [
            "ActionType":"2",
            "CustomerGamifyTransactionId": gameId,
            "PointResult": resultValue
        ]as [String: Any]
        print(parameter)
        self.VM.spinnWheelGamingAPI(paramters: parameter)
    }
    

    
}
