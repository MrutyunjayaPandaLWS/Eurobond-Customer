//
//  EBC_MyAssistantTVC.swift
//  EuroBond_Customer
//
//  Created by admin on 31/03/23.
//

import UIKit

protocol MyAssistantTVCDelegate{
    func didTappedResetPassword(item: EBC_MyAssistantTVC)
    func didTappedDeactiveAccount(item: EBC_MyAssistantTVC)
}

class EBC_MyAssistantTVC: UITableViewCell {

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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func selectResetPasswordBtn(_ sender: UIButton) {
        delegate?.didTappedResetPassword(item: self)
    }
    
    @IBAction func selectDeactiveBtn(_ sender: UIButton) {
        delegate?.didTappedDeactiveAccount(item: self)
    }
    
    
}
