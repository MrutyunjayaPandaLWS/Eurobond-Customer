//
//  EBC_QueryListingTVC.swift
//  EuroBond_Customer
//
//  Created by admin on 04/04/23.
//

import UIKit

class EBC_QueryListingTVC: UITableViewCell {

    @IBOutlet weak var messageTimeLbl: UILabel!
    @IBOutlet weak var messageDateLbl: UILabel!
    @IBOutlet weak var messageDetailsLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var queryRefNoLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
