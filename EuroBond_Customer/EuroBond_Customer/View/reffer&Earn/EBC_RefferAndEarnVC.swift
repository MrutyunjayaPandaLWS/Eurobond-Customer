//
//  EBC_RefferAndEarnVC.swift
//  EuroBond_Customer
//
//  Created by syed on 21/03/23.
//

import UIKit

class EBC_RefferAndEarnVC: UIViewController {

    @IBOutlet weak var otherOptionBtn: UIButton!
    @IBOutlet weak var referalCodeLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var referInfo: UILabel!
    @IBOutlet weak var referMoneyLbl: UILabel!
    @IBOutlet weak var titleVC: UILabel!
    var flags: String = "SideMenu"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func selectBackBtn(_ sender: UIButton) {
        if flags == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectSubmitBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectCopyBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectShareBtn(_ sender: UIButton) {
    }
    
    
}
