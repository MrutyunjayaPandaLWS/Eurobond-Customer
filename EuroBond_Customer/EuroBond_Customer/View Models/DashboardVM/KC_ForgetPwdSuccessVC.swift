//
//  KC_ForgetPwdSuccessVC.swift
//  KeshavCement
//
//  Created by ADMIN on 02/01/2023.
//

import UIKit
import LanguageManager_iOS

class KC_ForgetPwdSuccessVC: BaseViewController {

    @IBOutlet weak var newPwdInfo: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    
    var itsComeFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.itsComeFrom == "CLAIMPURCHASE"{
            self.newPwdInfo.text = "Submitted your purchase request".localiz()
        }else if self.itsComeFrom == "SAVEWORKSITEINFO"{
            self.newPwdInfo.text = "Submitted your work details request".localiz()
        }else if self.itsComeFrom == "SUPPORTEXECUTIVE"{
            self.newPwdInfo.text = "Support executive created".localiz()
        }else if self.itsComeFrom == "EXECUTIVE"{
            self.newPwdInfo.text = "Status updated".localiz()
        }else if self.itsComeFrom == "ACCOUNTDEACTIVATE"{
            self.newPwdInfo.text = "Your account is deactivated please check with the administrator".localiz()
            self.infoLbl.text = "Account Deactivated".localiz()
        }
//        else if self.itsComeFrom == "REDEMPTIONSUBMISSION"{
//            self.newPwdInfo.text = "You have successfully redeemed a products"
//        }
        
    }

    @IBAction func okBtn(_ sender: Any) {
        if self.itsComeFrom == "ACCOUNTDEACTIVATE"{
            NotificationCenter.default.post(name: .deactivatedAcc, object: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
