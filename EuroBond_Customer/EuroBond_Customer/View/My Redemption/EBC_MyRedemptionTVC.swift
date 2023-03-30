//
//  EBC_MyRedemptionTVC.swift
//  EuroBond_Customer
//
//  Created by syed on 20/03/23.
//

import UIKit

class EBC_MyRedemptionTVC: UITableViewCell {

    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dateTitleLbl: UILabel!
    @IBOutlet weak var eurosUsedLbl: UILabel!
    @IBOutlet weak var eurosTitleLbl: UILabel!
    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productCategoryLbl: UILabel!
    @IBOutlet weak var redemptionImage: UIImageView!
    @IBOutlet weak var refNoLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        statusView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMinYCorner]
        statusView.layer.cornerRadius = 10
        statusView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
