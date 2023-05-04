//
//  SearchProjectDetailsVC.swift
//  EuroBond_Customer
//
//  Created by Arokia-M3 on 03/05/23.
//

import UIKit

class SearchProjectDetailsVC: BaseViewController {
    
    @IBOutlet var brandNaemTitleLbl: UILabel!
    @IBOutlet var brandNameLbl: UILabel!
    @IBOutlet var colorTitleLbl: UILabel!
    @IBOutlet var colorDataLbl: UILabel!
    @IBOutlet var colorCodeLbl: UILabel!
    @IBOutlet var colorCodeDataLbl: UILabel!
    @IBOutlet var collectionViewProjectDetails: UICollectionView!
    @IBOutlet var imageZoom: UIView!
    @IBOutlet var collectionViewImage: UIImageView!
    var brand = ""
    var colorData = ""
    var colorCode = ""
    var productId = ""
    var brandId = ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var VM = ProjectCatalogeDetailsVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.imageZoom.isHidden = true
        self.collectionViewProjectDetails.delegate = self
        self.collectionViewProjectDetails.dataSource = self
        self.brandNameLbl.text = self.brand
        self.colorDataLbl.text = self.colorData
        self.colorCodeDataLbl.text = self.colorCode
        projecDetailsAPI()
        
        
        let collectionViewFLowLayout1 = UICollectionViewFlowLayout()
        collectionViewFLowLayout1.scrollDirection = .horizontal
        collectionViewFLowLayout1.minimumLineSpacing = 0
        collectionViewFLowLayout1.minimumInteritemSpacing = 0
        collectionViewFLowLayout1.estimatedItemSize = CGSize(width: 100, height: 30)
         self.collectionViewProjectDetails.collectionViewLayout = collectionViewFLowLayout1
    
        let collectionViewFLowLayout2 = UICollectionViewFlowLayout()
        collectionViewFLowLayout2.itemSize = CGSize(width: CGFloat(((self.view.bounds.width - 20) - (self.collectionViewProjectDetails.contentInset.left + self.collectionViewProjectDetails.contentInset.right)) / 2), height: 200)
        collectionViewFLowLayout2.minimumLineSpacing = 2.5
        collectionViewFLowLayout2.minimumInteritemSpacing = 2.5
         self.collectionViewProjectDetails.collectionViewLayout = collectionViewFLowLayout2
        
        
    }
    
    @IBAction func backBTN(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func projecDetailsAPI(){
        let parameter = [
            "ActorId": "\(userID)",
            "ActionType": "6",
            "Brand_id": "\(brandId)",//brand id
            "ProductId": "\(productId)"//color id
        ] as [String: Any]
        print(parameter)
        self.VM.projectCatalogeDetailsAPI(parameter: parameter)
    }

    
        @objc func didTap() {
//            if self.VM.projectCatalogeDetailsArray.count > 0 {
//                imageSlideShow.presentFullScreenController(from: self)
//            }
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         let touch = touches.first
         if touch?.view != self.imageZoom {
             //self.dismiss(animated: true, completion: nil)
             self.imageZoom.isHidden = true
        }
    }

    
}


extension SearchProjectDetailsVC : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return VM.projectCatalogeDetailsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCatalogeCVC", for: indexPath) as! ProjectCatalogeCVC

        let imageURL = self.VM.projectCatalogeDetailsArray[indexPath.row].productImage ?? ""
        let splitDataa = imageURL.dropFirst(1)
        let url = URL(string: "\(PROMO_IMG1)" + "\(splitDataa)")
        print(url)
        cell.projectImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        imageZoom.isHidden = false
        let imageURL = self.VM.projectCatalogeDetailsArray[indexPath.row].productImage ?? ""
        let splitDataa = imageURL.dropFirst(1)
        let url = URL(string: "\(PROMO_IMG1)" + "\(splitDataa)")
        collectionViewImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "Logo"))
    }
}
