//
//  EBC_DateFilterVC.swift
//  EuroBond_Customer
//
//  Created by admin on 31/03/23.
//

import UIKit

class EBC_DateFilterVC: UIViewController {

    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var cancelbtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectDateTitleLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view{
            dismiss(animated: true)
        }
    }
    
    @IBAction func selectCancelBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func selectConfirmBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    
}
