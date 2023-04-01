//
//  EBC_FilterVC.swift
//  EuroBond_Customer
//
//  Created by admin on 31/03/23.
//

import UIKit

class EBC_FilterVC: UIViewController {

    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var filterBtn2: UIButton!
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var fromDateLbl: UILabel!
    @IBOutlet weak var filterBtn1: UIButton!
    @IBOutlet weak var selectStatusLbl: UILabel!
    @IBOutlet weak var selectStatusStackView: UIStackView!
    @IBOutlet weak var filterView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        filterBtn2.isHidden = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view{
            dismiss(animated: true)
        }
    }
    
    
    @IBAction func selectStatusBtn(_ sender: UIButton) {
    }
    
    @IBAction func filterBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func selectFromDateBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DateFilterVC") as? EBC_DateFilterVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!, animated: true)
    }
    @IBAction func selectToDate(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DateFilterVC") as? EBC_DateFilterVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!, animated: true)
    }
    
    @IBAction func selectFilterBtn2(_ sender: UIButton) {
    }
    
    @IBAction func selectOkBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
