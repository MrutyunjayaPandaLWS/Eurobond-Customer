//
//  EBC_ProductCatalogueVC.swift
//  EuroBond_Customer
//
//  Created by syed on 27/03/23.
//

import UIKit

class EBC_ProductCatalogueVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    

    @IBOutlet weak var productListingCV: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        productListingCV.delegate = self
        productListingCV.dataSource = self
        
        let collectionViewFLowLayout1 = UICollectionViewFlowLayout()
        collectionViewFLowLayout1.scrollDirection = .horizontal
        collectionViewFLowLayout1.minimumLineSpacing = 0
        collectionViewFLowLayout1.minimumInteritemSpacing = 0
        collectionViewFLowLayout1.estimatedItemSize = CGSize(width: 100, height: 30)
         self.productListingCV.collectionViewLayout = collectionViewFLowLayout1
    
        let collectionViewFLowLayout2 = UICollectionViewFlowLayout()
        collectionViewFLowLayout2.itemSize = CGSize(width: CGFloat(((self.view.bounds.width - 20) - (self.productListingCV.contentInset.left + self.productListingCV.contentInset.right)) / 2), height: 230)
        collectionViewFLowLayout2.minimumLineSpacing = 2.5
        collectionViewFLowLayout2.minimumInteritemSpacing = 2.5
         self.productListingCV.collectionViewLayout = collectionViewFLowLayout2
    }
    
    @IBAction func selectBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func selectProductDetailsBtn(_ sender: UIButton) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EBC_ProductCatalogueCVC", for: indexPath) as! EBC_ProductCatalogueCVC
        cell.productImage.image = UIImage(named: "demoImg-2")
        return cell
    }
    
    
    
    
    

}
