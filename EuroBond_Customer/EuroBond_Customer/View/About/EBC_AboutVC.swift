//
//  EBC_AboutVC.swift
//  EuroBond_Customer
//
//  Created by admin on 04/04/23.
//

import UIKit
import WebKit

class EBC_AboutVC: UIViewController {

    @IBOutlet weak var aboutWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.aboutWebView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "eurobond-about-eng", ofType: "html")!) as URL) as URLRequest)
        
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
        self.navigationController?.popViewController(animated: true)
        navigationController?.popViewController(animated: true)
        
    }
    
    
    

}
