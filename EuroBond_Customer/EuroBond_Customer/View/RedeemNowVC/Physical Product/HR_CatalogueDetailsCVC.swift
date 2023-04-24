//
//  HR_CatalogueDetailsCVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/19/22.
//

import UIKit
//import LanguageManager_iOS

protocol AddToCartDelegate {
    func addToCartProducts(_ cell: HR_CatalogueDetailsCVC)
    func addToPlanner(_ cell: HR_CatalogueDetailsCVC)
}


class HR_CatalogueDetailsCVC: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPoints: UILabel!
    @IBOutlet weak var pointstitle: UILabel!
    @IBOutlet weak var addCartButton: UIButton!
    @IBOutlet weak var addedToCartBTN: UIButton!
    @IBOutlet weak var addToPlanner: UIButton!
    @IBOutlet weak var addedToPlanner: UIButton!
    @IBOutlet weak var categoryNameLbl: UILabel!
    var delegate: AddToCartDelegate!
    
    override func awakeFromNib() {
        self.pointstitle.text = "POINTS"
        
            addToPlanner.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
            addCartButton.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
        
    }

    
    @IBAction func addToCartBTN(_ sender: Any) {
        self.delegate.addToCartProducts(self)
        
    }
    @IBAction func addToPlannerBTN(_ sender: Any) {
        self.delegate.addToPlanner(self)
    }
    
    func setCollectionData(redemptionDetailObj: ObjCatalogueList, redeemedPointBalance: Int, cartItems:[AddToCART]){
        self.productName.text = redemptionDetailObj.productName ?? ""
        print(redemptionDetailObj.productName ?? "")
        self.productPoints.text = "\(redemptionDetailObj.pointsRequired ?? 0)"
        let imageURL = redemptionDetailObj.productImage ?? ""
        print(imageURL)
        if imageURL != ""{
            let urltoUse = String(productCatalogueImgURL + imageURL).replacingOccurrences(of: " ", with: "%20")
            let urlt = URL(string: "\(urltoUse)")
            productImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "dashboardLogo"))
        }else{
            self.productImage.image = UIImage(named: "dashboardLogo")
        }
//        print(redemptionDetailObj.pointsRequired ?? 0, "Cell")
//        print(redeemedPointBalance)
//        if (redemptionDetailObj.pointsRequired ?? 0) < redeemedPointBalance{
//            self.addCartButton.isHidden = false
//            self.addedToCartBTN.isHidden = true
//            self.addToPlanner.isHidden = true
//            self.addedToPlanner.isHidden = true
//        }else{
//            print(redemptionDetailObj.isPlanner)
//            if redemptionDetailObj.isPlanner ?? false == true{
//                self.addCartButton.isHidden = true
//               self.addedToCartBTN.isHidden = true
//               self.addToPlanner.isHidden = false
//             self.addedToPlanner.isHidden = true
//            }else{
////                self.addCartButton.isHidden = false
////               self.addedToCartBTN.isHidden = false
////               self.addToPlanner.isHidden = true
////             self.addedToPlanner.isHidden = false
//            }
//        }
//        
        
    }
    
}
