//
//  EBC_DreamGiftDetailsVC.swift
//  EuroBond_Customer
//
//  Created by admin on 03/04/23.
//

import UIKit

class EBC_DreamGiftDetailsVC: UIViewController {

    @IBOutlet weak var cartNumberValue: UILabel!
    @IBOutlet weak var eurosBalTitle: UILabel!
    @IBOutlet weak var eurosBal1: UILabel!
    @IBOutlet weak var dreamGiftInfoLbl: UILabel!
    @IBOutlet weak var thirdMonthDExpDate: UILabel!
    @IBOutlet weak var secondMonthExpDate: UILabel!
    @IBOutlet weak var firstMonthExpDate: UILabel!
    @IBOutlet weak var exipireDateTitle: UILabel!
    @IBOutlet weak var thirdMonthBal: UILabel!
    @IBOutlet weak var secondMonthBal: UILabel!
    @IBOutlet weak var firstMonthBal: UILabel!
    @IBOutlet weak var avarageBalTitle: UILabel!
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var redeemBtn: GradientButton!
    @IBOutlet weak var eurosBalLbl: UILabel!
    @IBOutlet weak var eurosRequiredTitle: UILabel!
    @IBOutlet weak var desiredDateLbl: UILabel!
    @IBOutlet weak var createdDateLbl: UILabel!
    @IBOutlet weak var desiredDateTitle: UILabel!
    @IBOutlet weak var createDateTitle: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var dreamGiftLogoView: GradientLabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleVC: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    override func viewWillLayoutSubviews() {
        dreamGiftLogoView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMinYCorner]
        dreamGiftLogoView.layer.cornerRadius = 14
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectMyCartBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectRedeemBtn(_ sender: Any) {
    }
    
    @IBAction func selectRemoveBtn(_ sender: UIButton) {
    }
    
    
    
    
}
