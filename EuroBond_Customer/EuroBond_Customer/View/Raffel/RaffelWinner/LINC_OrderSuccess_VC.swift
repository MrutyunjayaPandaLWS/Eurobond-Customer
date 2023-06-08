//
//  LINC_OrderSuccess_VC.swift
//  LINC
//
//  Created by Arokia-M3 on 05/07/21.
//

import UIKit
protocol dismissScreenDelegate: class {
    func dismissScreen(_ vc: LINC_OrderSuccess_VC)
}

class LINC_OrderSuccess_VC: UIViewController {

    @IBOutlet var okButton: UIButton!
    @IBOutlet var orderSuccessMessageLabel: UILabel!
    var isComeFrom = ""
    var delegate:dismissScreenDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
   }
       
    @IBAction func okButton(_ sender: Any) {
        self.delegate?.dismissScreen(self)
            self.dismiss(animated: true, completion: nil)
        
    }

}
