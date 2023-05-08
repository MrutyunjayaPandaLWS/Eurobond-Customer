//
//  EBC_FAQVC.swift
//  EuroBond_Customer
//
//  Created by admin on 04/04/23.
//

import UIKit
import WebKit
import LanguageManager_iOS

class EBC_FAQVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var faqTitleLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localizSetup()
    }
    
    @IBAction func selectBackBtn(_ sender: Any) {
        NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
        self.navigationController?.popViewController(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    func localizSetup(){
        self.faqTitleLbl.text = "FAQ".localiz()
        if faqTitleLbl.text == "FAQ"{
            self.webView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "eurobond-faq-eng", ofType: "html")!) as URL) as URLRequest)
        }else{
            self.webView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "eurobond-faq-hin", ofType: "html")!) as URL) as URLRequest)
        }
        
        }

}
