//
//  FilterByStatusTVC.swift
//  CenturyPly_JSON
//
//  Created by ADMIN on 07/06/2022.
//

import UIKit

class FilterByStatusTVC: UITableViewCell {

    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var statusType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
