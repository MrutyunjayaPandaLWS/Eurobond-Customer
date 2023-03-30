//
//  UiViewControllerExtenssion.swift
//  Hoya Thailand
//
//  Created by syed on 15/02/23.
//

import Foundation
import UIKit
import Lottie


extension UIViewController{
    
//    func successMessagePopUp(message: String){
//        let vc = storyboard?.instantiateViewController(withIdentifier: "HYT_SuccessMessageVC") as? HYT_SuccessMessageVC
//        vc?.modalTransitionStyle = .crossDissolve
//        vc?.modalPresentationStyle = .overFullScreen
//        vc?.successMessage = message
//        present(vc!, animated: true)
//    }
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 0.5
        shapeLayer.lineDashPattern = [3, 3] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
    
}

