//
//  EBC_VoucherVC.swift
//  EuroBond_Customer
//
//  Created by syed on 23/03/23.
//

import UIKit

class EBC_VoucherVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var emptyMsg: UILabel!
    @IBOutlet weak var voucherListCV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        voucherListCV.delegate = self
        voucherListCV.dataSource = self
        
        let collectionViewFLowLayout1 = UICollectionViewFlowLayout()
        collectionViewFLowLayout1.scrollDirection = .horizontal
        collectionViewFLowLayout1.minimumLineSpacing = 0
        collectionViewFLowLayout1.minimumInteritemSpacing = 0
        collectionViewFLowLayout1.estimatedItemSize = CGSize(width: 100, height: 30)
         self.voucherListCV.collectionViewLayout = collectionViewFLowLayout1
    
        let collectionViewFLowLayout2 = UICollectionViewFlowLayout()
        collectionViewFLowLayout2.itemSize = CGSize(width: CGFloat(((self.view.bounds.width - 10) - (self.voucherListCV.contentInset.left + self.voucherListCV.contentInset.right)) / 2), height: 230)
        collectionViewFLowLayout2.minimumLineSpacing = 2.5
        collectionViewFLowLayout2.minimumInteritemSpacing = 2.5
         self.voucherListCV.collectionViewLayout = collectionViewFLowLayout2
        emptyMsg.isHidden = true

    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EBC_VoucherCVC", for: indexPath) as! EBC_VoucherCVC
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == voucherListCV{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_VoucherDetails") as? EBC_VoucherDetails
            navigationController?.pushViewController(vc!, animated: true)
        }
    }

}
