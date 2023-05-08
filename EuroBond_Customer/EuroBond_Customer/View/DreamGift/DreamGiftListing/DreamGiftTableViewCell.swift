//
//  DreamGiftTableViewCell.swift
//  CenturyPly_JSON
//
//  Created by admin on 14/03/22.
//

import UIKit
import LanguageManager_iOS

protocol AddOrRemoveGiftDelegate{
    func redeemGift(_ cell: DreamGiftTableViewCell)
    func removeGift(_ cell: DreamGiftTableViewCell)
}

class DreamGiftTableViewCell: UITableViewCell {

    @IBOutlet weak var tdsvalue: UILabel!
    @IBOutlet weak var dreamGiftTitle: UILabel!
    @IBOutlet weak var giftName: UILabel!
    @IBOutlet weak var giftCreatedDate: UILabel!
    @IBOutlet weak var desiredDate: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var pointsRequired: UILabel!
    @IBOutlet weak var redeemButton: UIButton!
    @IBOutlet weak var removeGiftBTN: UIButton!
    @IBOutlet weak var progressViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var percentageValue: UILabel!
//    @IBOutlet weak var percentageLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var expiredDate: UILabel!
    @IBOutlet weak var ptsRequired: UILabel!
    @IBOutlet var progressPercentageLogoView: NSLayoutConstraint!
    
    
    var delegate: AddOrRemoveGiftDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.dreamGiftTitle.roundCorners(corners: [.bottomRight], radius: 20)
        progressView.layer.cornerRadius = 3.0
        
        self.createdDate.text = "Created Date".localiz()
        self.expiredDate.text = "Desired Date".localiz()
        self.ptsRequired.text = "Points Required".localiz()
        self.redeemButton.setTitle("Redeem".localiz(), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func redeemBTN(_ sender: Any) {
        self.delegate.redeemGift(self)
    }
    @IBAction func removeGift(_ sender: Any) {
        self.delegate.removeGift(self)
    }
    
}
