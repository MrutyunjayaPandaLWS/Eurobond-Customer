//
//  EBC_BankTransferVC.swift
//  EuroBond_Customer
//
//  Created by syed on 23/03/23.
//

import UIKit
import Lottie
class EBC_BankTransferVC: BaseViewController {

    @IBOutlet weak var comingSoon: LottieAnimationView!
    @IBOutlet weak var bankTransferBtn: UIButton!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var ifscCodeTF: UITextField!
    @IBOutlet weak var ifscCodeLbl: UILabel!
    @IBOutlet weak var accountHolderTF: UITextField!
    @IBOutlet weak var accountHolderNameLbl: UILabel!
    @IBOutlet weak var accountValidImage: UIImageView!
    @IBOutlet weak var accountNumberTF: UITextField!
    @IBOutlet weak var accountLbl: UILabel!
    @IBOutlet weak var bankTransferInfo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lottieAnimation(animationView: comingSoon)
        
    }
    
    @IBAction func selectBankTransferBtn(_ sender: UIButton) {
    }
    
    @IBAction func accountNumberTFEndEdditing(_ sender: UITextField) {
    }
    

}
