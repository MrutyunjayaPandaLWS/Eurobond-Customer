//
//  EBC_AboutVC.swift
//  EuroBond_Customer
//
//  Created by admin on 04/04/23.
//

import UIKit
import WebKit
import LanguageManager_iOS

class EBC_AboutVC: UIViewController {

    @IBOutlet weak var aboutWebView: WKWebView!
    @IBOutlet weak var aboutTitleLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localizSetup()
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
        self.navigationController?.popViewController(animated: true)
        navigationController?.popViewController(animated: true)
        
    }
    
    
    func localizSetup(){
        self.aboutTitleLbl.text = "About".localiz()
        if aboutTitleLbl.text == "About"{
            self.aboutWebView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "eurobond-about-eng", ofType: "html")!) as URL) as URLRequest)
        }else{
            self.aboutWebView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "eurobond-about-hin", ofType: "html")!) as URL) as URLRequest)
        }
        
    }
    
    

}
