//
//  EBC_GameZoneVC.swift
//  EuroBond_Customer
//
//  Created by syed on 21/03/23.
//

import UIKit

class EBC_GameZoneVC: UIViewController {
    
    
    var flags = "1"

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
    
}
