//
//  SuccessPopUpMessage2.swift
//  EuroBond_Customer
//
//  Created by admin on 29/06/23.
//

import UIKit
import LanguageManager_iOS

@objc protocol SuccessPopUpMessage2Delegate{
    @objc optional func didTappedOkBtn(item: SuccessPopUpMessage2)
}

class SuccessPopUpMessage2: UIViewController {

    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var congratulationLbl: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    var imageStatus = false
    var congralustionStatus = true
    var okBtnStatus = false
    var message = ""
    var imageName = ""
    var status = ""
    var flags = ""
    var delegate: SuccessPopUpMessage2Delegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        backGroundImage.isHidden = true
        okBtn.isHidden = okBtnStatus
        self.okBtn.setTitle("ok".localiz(), for: .normal)
        okBtn.layer.cornerRadius = 17
        congratulationLbl.isHidden = congralustionStatus
        statusImageView.isHidden = imageStatus
        if message != ""{
            messageLbl.text = message
        }else{
            messageLbl.text = "percentageValue".localiz()
        }
        if imageName != ""{
            statusImageView.image = UIImage(named: imageName)
        }
        if status != ""{
            congratulationLbl.text = status
        }
        
    }
    
    @IBAction func didTappedOkBtn(_ sender: Any) {
        dismiss(animated: true){
            self.delegate?.didTappedOkBtn?(item: self)
        }
    }
}
