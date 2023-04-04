//
//  EBC_DreamGiftTVC.swift
//  EuroBond_Customer
//
//  Created by admin on 03/04/23.
//

import UIKit

protocol DreamGiftDelegate{
    func didTappedRedeemBtn(Item: EBC_DreamGiftTVC)
    func didTappedRemovedBtn(Item: EBC_DreamGiftTVC)
}

class EBC_DreamGiftTVC: UITableViewCell {

    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var redeemBtn: GradientButton!
    @IBOutlet weak var tdsPointLbl: UILabel!
    @IBOutlet weak var tdsPointsTitle: UILabel!
    @IBOutlet weak var eurosRequiredBalLbl: UILabel!
    @IBOutlet weak var eurosRequiredTitleLbl: UILabel!
    @IBOutlet weak var circleViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var circleView: GradientView!
    @IBOutlet weak var progressPercentLbl: UILabel!
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var desiredDateLbl: UILabel!
    @IBOutlet weak var desiredDateTitle: UILabel!
    @IBOutlet weak var createdDateLbl: UILabel!
    @IBOutlet weak var createdDateTitle: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var BackgroundImage: UIImageView!
    var delegate: DreamGiftDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        removeBtn.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func selectRedeemBtn(_ sender: Any) {
        delegate?.didTappedRedeemBtn(Item: self)
    }
    
    @IBAction func selectRemoveBtn(_ sender: Any) {
        delegate?.didTappedRemovedBtn(Item: self)
    }
    
    
    
}
