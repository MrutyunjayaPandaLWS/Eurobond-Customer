//
//  EBC_FAQVC.swift
//  EuroBond_Customer
//
//  Created by admin on 04/04/23.
//

import UIKit
import WebKit

class EBC_FAQVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "eurobond-faq (1)", ofType: "html")!) as URL) as URLRequest)
    }
    
    @IBAction func selectBackBtn(_ sender: Any) {
        NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
        self.navigationController?.popViewController(animated: true)
        navigationController?.popViewController(animated: true)
    }
    

}
