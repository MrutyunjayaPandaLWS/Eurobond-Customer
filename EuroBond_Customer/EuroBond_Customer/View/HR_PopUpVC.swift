//
//  HR_PopUpVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/11/22.
//

import UIKit
import SlideMenuControllerSwift
import LanguageManager_iOS
protocol popUpAlertDelegate : class {
    func popupAlertDidTap(_ vc: HR_PopUpVC)
}

class HR_PopUpVC: UIViewController {

    @IBOutlet weak var okBTN: UIButton!
    @IBOutlet weak var information: UILabel!
    var delegate: popUpAlertDelegate!
    var descriptionInfo = ""
    var titleInfo = ""
    var isComeFrom = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "CustomerType") ?? "" == "1"{
            self.okBTN.backgroundColor = #colorLiteral(red: 0.7437494397, green: 0.08922102302, blue: 0.1178346947, alpha: 1)
        }else{
            self.okBTN.backgroundColor  = #colorLiteral(red: 0.1643253267, green: 0.3061718345, blue: 0.7360334992, alpha: 1)
        }
        self.information.text = descriptionInfo
        self.okBTN.setTitle("ok".localiz(), for: .normal)
    }

    @IBAction func okayBTN(_ sender: Any) {
        if isComeFrom == "Scanner"{
            NotificationCenter.default.post(name: .restartScan, object: nil)
        }else if isComeFrom == "Failed"{
            self.navigationController?.popToRootViewController(animated: true)
        }else if isComeFrom == "BankSubmission"{
            NotificationCenter.default.post(name: .bankSubmission, object: nil)
        }else if isComeFrom == "QuerySubmission"{
            NotificationCenter.default.post(name: .querySubmission, object: nil)
        }else if isComeFrom == "VoucherSuccess"{
            NotificationCenter.default.post(name: .showPopUp, object: nil)
        }else if isComeFrom == "Register"{
            NotificationCenter.default.post(name: .afterRegister, object: nil)
        }else if isComeFrom == "Planner"{
            NotificationCenter.default.post(name: .plannerList, object: nil)
        }else if isComeFrom == "AccountDeleted"{
            NotificationCenter.default.post(name: .deleteAccount, object: nil)
        }else if isComeFrom == "ProfileImageUpdate"{
            NotificationCenter.default.post(name: .profileImageUpdate, object: nil)
        }else if isComeFrom == "DeactivateAccount"{
            NotificationCenter.default.post(name: .deactivatedAcc, object: nil)
        }
        delegate?.popupAlertDidTap(self)
        self.dismiss(animated: true, completion: nil)
    }
}
