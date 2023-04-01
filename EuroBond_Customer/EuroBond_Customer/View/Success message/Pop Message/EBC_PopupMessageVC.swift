//
//  EBC_PopupMessageVC.swift
//  EuroBond_Customer
//
//  Created by admin on 31/03/23.
//

import UIKit


protocol PopupMessageVCDelegate{
    func didTappedOkBtn(item: EBC_PopupMessageVC)
    func didTappedCancelBtn(item: EBC_PopupMessageVC)
}

class EBC_PopupMessageVC: UIViewController {

    
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var alertMessage: UILabel!
    @IBOutlet weak var alertTitleLbl: UILabel!
    var message: String = ""
    var titleMessage: String = ""
    
    var delegate : PopupMessageVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        alertTitleLbl.text = titleMessage
        alertMessage.text = message
        
    }
    
    @IBAction func selectYesBtn(_ sender: UIButton) {
        dismiss(animated: true)
        delegate?.didTappedOkBtn(item: self)
    }
    
    @IBAction func selectNoBtn(_ sender: UIButton) {
        delegate?.didTappedCancelBtn(item: self)
    }
    
}
