//
//  EBC_MyAssistantTVC.swift
//  EuroBond_Customer
//
//  Created by admin on 31/03/23.
//

import UIKit
import LanguageManager_iOS

protocol MyAssistantTVCDelegate{
    func didTappedResetPassword(_ cell: EBC_MyAssistantTVC)
    func didTappedDeactiveAccount(_ cell: EBC_MyAssistantTVC)
}

class EBC_MyAssistantTVC: UITableViewCell {

    @IBOutlet weak var updatePwdBtn: UIButton!
    @IBOutlet weak var deactivateBtn: UIButton!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var mobileNumberTitleLbl: UILabel!
    @IBOutlet weak var enrollmentDateLbl: UILabel!
    @IBOutlet weak var enrollmentTitle: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var statusTitleLbl: UILabel!
    @IBOutlet weak var supporterNameLbl: UILabel!
    @IBOutlet weak var supporterTitleLbl: UILabel!
    var delegate : MyAssistantTVCDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.supporterNameLbl.text = "Support Name".localiz()
        self.statusTitleLbl.text = "Status".localiz()
        self.enrollmentTitle.text = "Enrollment".localiz()
        self.mobileNumberTitleLbl.text = "Mobile Number".localiz()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func selectResetPasswordBtn(_ sender: UIButton) {
        delegate?.didTappedResetPassword(self)
    }
    
    @IBAction func selectDeactiveBtn(_ sender: UIButton) {
        delegate?.didTappedDeactiveAccount(self)
    }
    
    
}
