//
//  EBC_ProductDetails.swift
//  EuroBond_Customer
//
//  Created by syed on 27/03/23.
//

import UIKit

class EBC_ProductDetails: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var termAndCondLbl: UILabel!
    @IBOutlet weak var termAndCondTitleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var desriptionTitleLbl: UILabel!
    @IBOutlet weak var addCartBtn: UIButton!
    @IBOutlet weak var productValue: UILabel!
    @IBOutlet weak var euros2: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var myCartNumber: UILabel!
    @IBOutlet weak var euros1Lbl: UILabel!
    @IBOutlet weak var totalBalanceLbl: UILabel!
    @IBOutlet weak var titleVc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        bottomView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    @IBAction func selectBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectCartBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectAddCartBtn(_ sender: UIButton) {
    }
    
    
}
