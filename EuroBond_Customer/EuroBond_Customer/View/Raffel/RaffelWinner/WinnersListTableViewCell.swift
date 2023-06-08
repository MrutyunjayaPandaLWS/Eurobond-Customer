//
//  WinnersListTableViewCell.swift
//  LINC
//
//  Created by admin on 12/05/22.
//

import UIKit

class WinnersListTableViewCell: UITableViewCell {

    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var winnerCity: UILabel!
    @IBOutlet weak var winnerLoyaltID: UILabel!
    @IBOutlet weak var ticketNumber: UILabel!
    @IBOutlet weak var winnersname: UILabel!
    @IBOutlet weak var ticketnamelabel: UILabel!
    @IBOutlet weak var rewardpointslabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
