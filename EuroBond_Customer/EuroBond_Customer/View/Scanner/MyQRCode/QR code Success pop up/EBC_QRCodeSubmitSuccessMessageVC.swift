//
//  EBC_QRCodeSubmitSuccessMessageVC.swift
//  EuroBond_Customer
//
//  Created by admin on 04/04/23.
//

import UIKit

class EBC_QRCodeSubmitSuccessMessageVC: UIViewController {

    @IBOutlet weak var syncStatusBtn: GradientButton!
    @IBOutlet weak var codeStatusBtn: GradientButton!
    @IBOutlet weak var scanAgainBtn: GradientButton!
    @IBOutlet weak var submissionMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view{
            navigationController?.popToRootViewController(animated: true)
            dismiss(animated: true)
        }
    }
    
    @IBAction func selectRemoveBtn(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
        dismiss(animated: true)
    }
    
    @IBAction func selectScanAgainBtn(_ sender: Any) {
    }
    
    @IBAction func selectCodeStatusBtn(_ sender: GradientButton) {
    }
    
    @IBAction func selectSyncStatsusBtn(_ sender: Any) {
    }
    
    
    
}
