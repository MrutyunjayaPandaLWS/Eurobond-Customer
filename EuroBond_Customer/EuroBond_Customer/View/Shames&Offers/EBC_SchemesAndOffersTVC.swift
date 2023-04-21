//
//  EBC_SchemesAndOffersTVC.swift
//  EuroBond_Customer
//
//  Created by syed on 21/03/23.
//

import UIKit

protocol SchemesAndOffersDelegate{
    func didTappedViewBtn(_ cell: EBC_SchemesAndOffersTVC)
    
}
class EBC_SchemesAndOffersTVC: UITableViewCell {

    @IBOutlet weak var offersNameLbl: UILabel!
    @IBOutlet weak var offersImage: UIImageView!
    var delegate: SchemesAndOffersDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func selectViewBtn(_ sender: UIButton) {
        delegate?.didTappedViewBtn(self)
    }
}
