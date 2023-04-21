//
//  TaxRelatedPopupViewController.swift
//  CenturyPly_JSON
//
//  Created by admin on 20/10/22.
//

import UIKit

class TaxRelatedPopupViewController: UIViewController {

    @IBOutlet weak var dataView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         let touch = touches.first
         if touch?.view != self.dataView {
             self.dismiss(animated: true, completion: nil)
        }
    }
}
