//
//  EBC_VoucherDetails.swift
//  EuroBond_Customer
//
//  Created by syed on 27/03/23.
//

import UIKit

class EBC_VoucherDetails: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var redeemOptionView: UIView!
    @IBOutlet weak var redeemOptionLbl: UILabel!
    @IBOutlet weak var redeemOptionTitleLbl: UILabel!
    @IBOutlet weak var termAndConditionView: UIView!
    @IBOutlet weak var termConditionLbl: UILabel!
    @IBOutlet weak var termAndCondTitleLbl: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var descriptionTitleLbl: UILabel!
    @IBOutlet weak var redeemBtn: UIButton!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var rangeLbl: UILabel!
    @IBOutlet weak var voucherName: UILabel!
    @IBOutlet weak var voucherImage: UIImageView!
    @IBOutlet weak var myCartNumber: UILabel!
    @IBOutlet weak var euros1Lbl: UILabel!
    @IBOutlet weak var totalBalanceLbl: UILabel!
    @IBOutlet weak var titleVC: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectMyCartBtn(_ sender: Any) {
    }
    
    @IBAction func selectRedeemBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectDescriptionBtn(_ sender: UIButton) {
    }
    @IBAction func selectTermAndConditionBtn(_ sender: UIButton) {
    }
    @IBAction func selectRedeemOptionBtn(_ sender: UIButton) {
    }
    
    
    
    
}
