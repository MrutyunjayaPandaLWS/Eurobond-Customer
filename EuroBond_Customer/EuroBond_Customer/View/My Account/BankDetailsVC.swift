//
//  BankDetailsVC.swift
//  GogrejLocksMobileApplication
//
//  Created by ADMIN on 01/07/2022.
//  Copyright © 2022 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class BankDetailsVC: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var uploadDoccumentInfoLbl: UILabel!
    @IBOutlet weak var uploadDoccumentBtn: UIButton!
    @IBOutlet weak var ifscCodeTF: UITextField!
    @IBOutlet weak var ifscCodeLbl: UILabel!
    @IBOutlet weak var bankNameTF: UITextField!
    @IBOutlet weak var bankNameLbl: UILabel!
    @IBOutlet weak var confirmAccountNumberTF: UITextField!
    @IBOutlet weak var connfirmAccountNumberLbl: UILabel!
    @IBOutlet weak var accountNumberTF: UITextField!
    @IBOutlet weak var accountNnumberLbl: UILabel!
    @IBOutlet weak var accountHolderTF: UITextField!
    @IBOutlet weak var accounntHolderNameTitle: UILabel!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadImage.isHidden = true
        submitBtn.isHidden = true
   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 }
    @IBAction func selectUploadDoccumentBtn(_ sender: Any) {
    }
    
    @IBAction func selectSubmitBtn(_ sender: UIButton) {
    }
}
