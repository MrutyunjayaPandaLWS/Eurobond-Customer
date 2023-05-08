//
//  HR_SuccessPoP_VC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/10/22.
//

import UIKit

class HR_SuccessPoP_VC: BaseViewController {
    var imageChange = 0

    @IBOutlet var redemptionImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageChange == 1{
            self.redemptionImage.image = UIImage(named: "success")
        }else{
            self.redemptionImage.image = UIImage(named: "successHindi")
        }
    }
    


    @IBAction func backBTN(_ sender: Any) {
        NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
