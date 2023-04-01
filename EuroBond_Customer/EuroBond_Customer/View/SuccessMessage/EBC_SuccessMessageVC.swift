//
//  EBC_SuccessMessageVC.swift
//  EuroBond_Customer
//
//  Created by syed on 18/03/23.
//

import UIKit

class EBC_SuccessMessageVC: UIViewController {

    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view{
            dismiss(animated: true)
        }
    }
    
    
    @IBAction func selectOkBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    

}
