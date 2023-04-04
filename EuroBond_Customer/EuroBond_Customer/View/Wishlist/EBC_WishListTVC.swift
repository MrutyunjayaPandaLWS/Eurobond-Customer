//
//  EBC_WishListTVC.swift
//  EuroBond_Customer
//
//  Created by admin on 03/04/23.
//

import UIKit

protocol WishListDelegate{
    func didTappedRemoveBt(item: EBC_WishListTVC)
    func didTappedRedeemBtn(item: EBC_WishListTVC)
}

class EBC_WishListTVC: UITableViewCell {

    @IBOutlet weak var redeemBtn: GradientButton!
    @IBOutlet weak var circleLeadingConstrainnts: NSLayoutConstraint!
    @IBOutlet weak var progressPercent: UILabel!
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var pointsRequiredLbl: UILabel!
    @IBOutlet weak var pointsRequiredtitle: UILabel!
    @IBOutlet weak var desiredDateLbl: UILabel!
    @IBOutlet weak var desiredDateTitleLbl: UILabel!
    @IBOutlet weak var createdDateLbl: UILabel!
    @IBOutlet weak var createdDateTitleLbl: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productimage: UIImageView!
    var delegate: WishListDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func selectRemoveBtn(_ sender: UIButton) {
        delegate?.didTappedRemoveBt(item: self)
    }
    
    @IBAction func selectRedeemBtn(_ sender: UIButton) {
        delegate?.didTappedRedeemBtn(item: self)
    }
    
    
    
    
}
