//
//  EBC_WelcomeVC.swift
//  EuroBond_Customer
//
//  Created by syed on 17/03/23.
//

import UIKit

class EBC_WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func selectEnglishBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBS_LoginVC") as? EBS_LoginVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectHindiBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBS_LoginVC") as? EBS_LoginVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}
