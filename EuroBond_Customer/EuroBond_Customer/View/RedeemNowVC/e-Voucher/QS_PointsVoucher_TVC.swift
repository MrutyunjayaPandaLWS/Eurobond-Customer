//
//  QS_PointsVoucher_TVC.swift
//  HR_Johnson
//
//  Created by ADMIN on 10/05/2022.
//

import UIKit

class QS_PointsVoucher_TVC: UITableViewCell {

    @IBOutlet weak var pointsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
