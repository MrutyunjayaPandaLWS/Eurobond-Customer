//
//  EBC_RefferalVC.swift
//  EuroBond_Customer
//
//  Created by syed on 18/03/23.
//

import UIKit
import Toast_Swift

class EBC_RefferalVC: UIViewController {

    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var SkipBtn: UIButton!
    @IBOutlet weak var enterCodeTF: UITextField!
    @IBOutlet weak var enterCodeLbl: UILabel!
    @IBOutlet weak var referralinfoLbl: UILabel!
    @IBOutlet weak var referralTitleLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func selectSkipBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RegisterVC") as? EBC_RegisterVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectVerifyBtn(_ sender: UIButton) {
        if enterCodeTF.text?.count == 0{
            self.view.makeToast("Enter refferal code")
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RegisterVC") as? EBC_RegisterVC
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
}
