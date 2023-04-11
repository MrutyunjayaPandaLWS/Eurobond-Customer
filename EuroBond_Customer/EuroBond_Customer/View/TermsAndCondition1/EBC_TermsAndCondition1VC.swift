//
//  EBC_TermsAndCondition1VC.swift
//  EuroBond_Customer
//
//  Created by admin on 10/04/23.
//

import UIKit
import WebKit

protocol TermsAndConditionDelegate{
    func didTappedTermsAndConditionBtn(item: EBC_TermsAndCondition1VC)
}

class EBC_TermsAndCondition1VC: UIViewController {

    @IBOutlet weak var declineBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleVC: UILabel!
    var termsAndCondStatus = 0
    var delegate : TermsAndConditionDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
    
    @IBAction func selectAcceptBtn(_ sender: UIButton) {
        termsAndCondStatus = 1
        delegate?.didTappedTermsAndConditionBtn(item: self)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
    
    @IBAction func selectDeclineBtn(_ sender: Any) {
        termsAndCondStatus = 0
        delegate?.didTappedTermsAndConditionBtn(item: self)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
}
