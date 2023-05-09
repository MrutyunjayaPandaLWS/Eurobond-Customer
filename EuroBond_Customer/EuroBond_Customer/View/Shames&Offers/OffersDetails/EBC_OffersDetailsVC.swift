//
//  EBC_OffersDetailsVC.swift
//  EuroBond_Customer
//
//  Created by syed on 23/03/23.
//

import UIKit
import SDWebImage
import LanguageManager_iOS
class EBC_OffersDetailsVC: BaseViewController {

    
    @IBOutlet weak var offersNameLbl: UILabel!
    @IBOutlet weak var offersImage: UIImageView!
    @IBOutlet weak var titleVC: UILabel!
    @IBOutlet weak var descriptionWV: UIWebView!
    var selectedTitle = ""
    var selectedImage = ""
    var selectedOfferId = 0
    var selectedLongDesc = ""
    var selectedShortDesc = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.offersNameLbl.text = self.selectedTitle
        offersImage.contentMode = .scaleAspectFit
        //let htmlString = selectedLongDesc.HTML ?? ""
        //self.descriptionWV.loadHTMLString(htmlString , baseURL:nil)
        let content = "<html><body><p><font size=10>" + selectedLongDesc + "</font></p></body></html>"
        self.descriptionWV.loadHTMLString(self.selectedLongDesc, baseURL: nil)
        let imageURL = self.selectedImage
        print(imageURL)
        if imageURL != ""{
            let filteredURLArray = imageURL.dropFirst(3)
            let urltoUse = String(PROMO_IMG1 + filteredURLArray).replacingOccurrences(of: " ", with: "%20")
            let urlt = URL(string: "\(urltoUse)")
            print(urlt)
            offersImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
        }
        languageLocaliz()
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func languageLocaliz(){
        self.titleVC.text = "Schemes and Offers".localiz()
    }
    
    
}
