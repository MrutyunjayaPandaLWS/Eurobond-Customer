//
//  EBC_WishListDetailsVC.swift
//  EuroBond_Customer
//
//  Created by admin on 03/04/23.
//

import UIKit

class EBC_WishListDetailsVC: UIViewController {

    @IBOutlet weak var cartValue: UILabel!
    @IBOutlet weak var euroBal1Lbl: UILabel!
    @IBOutlet weak var eurosTopTitleLbl: UILabel!
    @IBOutlet weak var thirdMonthDate: UILabel!
    @IBOutlet weak var secondMonthDate: UILabel!
    @IBOutlet weak var firstMonthExpDate: UILabel!
    @IBOutlet weak var thirdMonthBal: UILabel!
    @IBOutlet weak var secondMonthBal: UILabel!
    @IBOutlet weak var firstMonthBal: UILabel!
    @IBOutlet weak var redeemDateTitle: UILabel!
    @IBOutlet weak var avarageEurosTitle: UILabel!
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var redeemBtn: GradientButton!
    @IBOutlet weak var eurosBalanceLbl: UILabel!
    @IBOutlet weak var eurosTitleLbl: UILabel!
    @IBOutlet weak var desiredDateLbl: UILabel!
    @IBOutlet weak var desiredDateTitleLbl: UILabel!
    @IBOutlet weak var createDateLbl: UILabel!
    @IBOutlet weak var createDateTitle: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var dreamGiftLogoView: GradientLabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var wishListInfoLbl: UILabel!
    @IBOutlet weak var titleName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        dreamGiftLogoView.layer.maskedCorners = [.layerMaxXMaxYCorner]
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
