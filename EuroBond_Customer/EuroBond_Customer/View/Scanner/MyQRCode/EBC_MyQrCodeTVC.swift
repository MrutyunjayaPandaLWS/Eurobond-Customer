//
//  EBC_MyQrCodeTVC.swift
//  EuroBond_Customer
//
//  Created by admin on 04/04/23.
//

import UIKit

protocol MyQrCodeTbleViewCellDelegate{
    func didTappedDeletBtn(item: EBC_MyQrCodeTVC)
}

class EBC_MyQrCodeTVC: UITableViewCell {

    @IBOutlet weak var qrCodeStatus: UILabel!
    @IBOutlet weak var qrCodeNumber: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    var delegate: MyQrCodeTbleViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func selectDeletBtn(_ sender: UIButton) {
    }
}
