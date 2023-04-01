//
//  EBC_CodeStatusTVC.swift
//  EuroBond_Customer
//
//  Created by admin on 30/03/23.
//

import UIKit

class EBC_CodeStatusTVC: UITableViewCell {

    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var qrSubmitDate: UILabel!
    @IBOutlet weak var qrCodeNumber: UILabel!
    @IBOutlet weak var qrCodeStatus: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func didTappedSelectBtn(_ sender: Any) {
    }
}
