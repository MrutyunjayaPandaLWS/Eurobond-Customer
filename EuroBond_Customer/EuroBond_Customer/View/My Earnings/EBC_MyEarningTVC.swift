//
//  EBC_MyEarningTVC.swift
//  EuroBond_Customer
//
//  Created by syed on 20/03/23.
//

import UIKit
import LanguageManager_iOS

class EBC_MyEarningTVC: UITableViewCell {

    @IBOutlet weak var eurosTitleLbl: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var idNumberLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var statusTitleLbl: UILabel!
    @IBOutlet weak var programLbl: UILabel!
    @IBOutlet weak var programeTitleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.programeTitleLbl.text = "Progrom Name".localiz()
        self.statusLbl.text = "Status".localiz()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
