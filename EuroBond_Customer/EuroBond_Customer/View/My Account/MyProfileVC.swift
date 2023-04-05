//
//  MyProfileVC.swift
//  GogrejLocksMobileApplication
//
//  Created by Arokia IT on 2/14/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit
import SDWebImage

class MyProfileVC: BaseViewController {
    
    
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var DOBLbl: UILabel!
    @IBOutlet weak var pinCodeTF: UITextField!
    @IBOutlet weak var pinCodeLbl: UILabel!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var beneficiaryTypeTF: UITextField!
    @IBOutlet weak var beneficiaryTypeLbl: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    @IBAction func selectEditEmailBtn(_ sender: Any) {
    }
    
    @IBAction func selectDOBBtn(_ sender: Any) {
    }
    
    
}
