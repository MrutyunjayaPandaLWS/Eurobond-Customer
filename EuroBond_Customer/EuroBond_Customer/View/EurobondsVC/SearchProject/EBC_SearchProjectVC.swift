//
//  EBC_SearchProjectVC.swift
//  EuroBond_Customer
//
//  Created by syed on 27/03/23.
//

import UIKit
import SDWebImage


class EBC_SearchProjectVC: BaseViewController {
    @IBOutlet weak var projectListingCV: UICollectionView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var VCTitle: UILabel!
    
    
    var VM = projectCatalogeVM()
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.projectListingCV.delegate = self
        self.projectListingCV.dataSource = self
        projectCatalogeAPI()
        let collectionViewFLowLayout1 = UICollectionViewFlowLayout()
        collectionViewFLowLayout1.scrollDirection = .horizontal
        collectionViewFLowLayout1.minimumLineSpacing = 0
        collectionViewFLowLayout1.minimumInteritemSpacing = 0
        collectionViewFLowLayout1.estimatedItemSize = CGSize(width: 100, height: 30)
         self.projectListingCV.collectionViewLayout = collectionViewFLowLayout1
    
        let collectionViewFLowLayout2 = UICollectionViewFlowLayout()
        collectionViewFLowLayout2.itemSize = CGSize(width: CGFloat(((self.view.bounds.width - 20) - (self.projectListingCV.contentInset.left + self.projectListingCV.contentInset.right)) / 2), height: 230)
        collectionViewFLowLayout2.minimumLineSpacing = 2.5
        collectionViewFLowLayout2.minimumInteritemSpacing = 2.5
         self.projectListingCV.collectionViewLayout = collectionViewFLowLayout2

        
    }
    func projectCatalogeAPI(){
        let parameter = [
            "ActorId":"\(userID)",
            "ActionType":"5",
            "SearchText":"\(searchTF.text ?? "")"
        ] as [String: Any]
        print(parameter)
        self.VM.projectCatalogeAPI(parameter: parameter)
    }

    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didChangeSearchTF(_ sender: UITextField) {
    }
    
}
extension EBC_SearchProjectVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return VM.projectCatalogeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EBC_SearchProjectCVC", for: indexPath) as! EBC_SearchProjectCVC
        let imageURL = self.VM.projectCatalogeArray[indexPath.row].productImage ?? ""
        let splitDataa = imageURL.dropFirst(1)
        let url = URL(string: "\(PROMO_IMG1)" + "\(splitDataa)")
        print(url)
//        let urlt = URL(string: "\(self.VM.evoucherListingArray[indexPath.row].productImage ?? "")")
//        print(urlt)
        //cell.projectImage.image = UIImage(named: url)
        cell.projectImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
        cell.projectName.text = "Brand \(self.VM.projectCatalogeArray[indexPath.row].brandName ?? "")"
        cell.productColorDataLbl.text = self.VM.projectCatalogeArray[indexPath.row].productName ?? ""
        cell.productColorCodeDataLbl.text = "\(self.VM.projectCatalogeArray[indexPath.row].productCode ?? "")"
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchProjectDetailsVC") as! SearchProjectDetailsVC
        vc.brand = self.VM.projectCatalogeArray[indexPath.row].brandName ?? ""
        vc.colorData = self.VM.projectCatalogeArray[indexPath.row].productName ?? ""
        vc.colorCode = self.VM.projectCatalogeArray[indexPath.row].productCode ?? ""
        vc.productId = "\(self.VM.projectCatalogeArray[indexPath.row].productId ?? 0)"
        vc.brandId = "\(self.VM.projectCatalogeArray[indexPath.row].brandId ?? 0)"
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
}
