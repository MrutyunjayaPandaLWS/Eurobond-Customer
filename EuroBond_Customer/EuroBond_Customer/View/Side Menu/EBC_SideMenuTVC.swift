//
//  EBC_SideMenuTVC.swift
//  EuroBond_Customer
//
//  Created by syed on 21/03/23.
//

import UIKit

class EBC_SideMenuTVC: UITableViewCell {

    @IBOutlet weak var lineLable: UILabel!
    @IBOutlet weak var sideMenuBadges: UILabel!
    @IBOutlet weak var sideMenuName: UILabel!
    @IBOutlet weak var sideMenuImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
