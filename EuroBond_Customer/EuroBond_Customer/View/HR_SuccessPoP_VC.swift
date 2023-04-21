//
//  HR_SuccessPoP_VC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/10/22.
//

import UIKit

class HR_SuccessPoP_VC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func backBTN(_ sender: Any) {
        NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
