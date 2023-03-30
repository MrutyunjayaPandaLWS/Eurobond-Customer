//
//  EBC_OffersDetailsVC.swift
//  EuroBond_Customer
//
//  Created by syed on 23/03/23.
//

import UIKit

class EBC_OffersDetailsVC: UIViewController {

    @IBOutlet weak var offersDetailsLbl: UILabel!
    @IBOutlet weak var offersNameLbl: UILabel!
    @IBOutlet weak var offersImage: UIImageView!
    @IBOutlet weak var titleVC: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        offersImage.image = UIImage(named: "demoImg-2")
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
