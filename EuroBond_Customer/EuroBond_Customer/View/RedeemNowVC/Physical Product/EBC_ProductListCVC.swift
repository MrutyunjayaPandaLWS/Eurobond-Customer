//
//  EBC_ProductListCVC.swift
//  EuroBond_Customer
//
//  Created by syed on 23/03/23.
//

import UIKit

protocol PhysicalProductListDelegate{
    func didTappedAddToCartBtn(item: EBC_ProductListCVC)
}

class EBC_ProductListCVC: UICollectionViewCell {
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var eurosTitleLbl: UILabel!
    @IBOutlet weak var productValueLbl: UILabel!
    var delegate: PhysicalProductListDelegate?
    
    
    @IBAction func didTappedAddToCartBtn(_ sender: UIButton) {
        delegate?.didTappedAddToCartBtn(item: self)
    }
}
