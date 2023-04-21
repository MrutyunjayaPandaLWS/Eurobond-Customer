//
//  CodeStatus_TVC.swift
//  centuryDemo
//
//  Created by Arokia-M3 on 15/03/22.
//

import UIKit

class CodeStatus_TVC: UITableViewCell {

    @IBOutlet var codeStatusImageView: UIImageView!
    @IBOutlet var productCode: UILabel!
    @IBOutlet var productStatus: UILabel!
    @IBOutlet var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
