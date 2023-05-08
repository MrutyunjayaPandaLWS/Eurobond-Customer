//
//  EBC_EurobondsVC.swift
//  EuroBond_Customer
//
//  Created by syed on 21/03/23.
//

import UIKit

class EBC_EurobondsVC: UIViewController {

    @IBOutlet weak var whatsNewLbl: UILabel!
    @IBOutlet weak var whatsNewInfoLbl: UILabel!
    @IBOutlet weak var projectSearchLbl: UILabel!
    @IBOutlet weak var searchProjectInfo: UILabel!
    @IBOutlet weak var youTubeLbl: UILabel!
    @IBOutlet weak var youtubeInfo: UILabel!
    @IBOutlet weak var productCatalogueInfo: UILabel!
    @IBOutlet weak var productCatalogueLbl: UILabel!
    @IBOutlet weak var VCtitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        langLocaliz()
    }
    
    func langLocaliz(){
        VCtitle.text = "EurobondProfile".localiz()
        productCatalogueLbl.text = "Product Catalogue".localiz()
        productCatalogueInfo.text = "Get the Product Details".localiz()
        youtubeInfo.text = "For Product videos".localiz()
        youTubeLbl.text = "Eurobond Youtube".localiz()
        searchProjectInfo.text = "Search Project".localiz()
        projectSearchLbl.text = "Project Search".localiz()
        whatsNewInfoLbl.text = "Check Latest Updates".localiz()
        whatsNewLbl.text = "WhatNew".localiz()
        
        
        
    }

    @IBAction func selectBackbtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectProductCatalogueBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_ProductCatalogueVC") as? EBC_ProductCatalogueVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func selectYouTubeBtn(_ sender: UIButton) {

//        UIApplication.shared.openURL(NSURL(string:"https://www.youtube.com/@EurobondMumbai")! as URL)
        if let youtubeURL = URL(string: "https://www.youtube.com/@EurobondMumbai"),
             UIApplication.shared.canOpenURL(youtubeURL) {
             // redirect to app
             UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
         } else if let youtubeURL = URL(string: "https://www.youtube.com/@EurobondMumbai") {
             // redirect through safari
             UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
         }
    }
    
    @IBAction func selectProjectSearchBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_SearchProjectVC") as? EBC_SearchProjectVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func SelectWhaitsNewBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_WhatsNewVC") as? EBC_WhatsNewVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    
    
}
