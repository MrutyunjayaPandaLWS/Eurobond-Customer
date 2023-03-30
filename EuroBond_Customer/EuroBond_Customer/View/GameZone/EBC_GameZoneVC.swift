//
//  EBC_GameZoneVC.swift
//  EuroBond_Customer
//
//  Created by syed on 21/03/23.
//

import UIKit

class EBC_GameZoneVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
