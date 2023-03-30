//
//  EBC_SearchProjectVC.swift
//  EuroBond_Customer
//
//  Created by syed on 27/03/23.
//

import UIKit

class EBC_SearchProjectVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    @IBOutlet weak var projectListingCV: UICollectionView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var VCTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        projectListingCV.delegate = self
        projectListingCV.dataSource = self
        
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

    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didChangeSearchTF(_ sender: UITextField) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EBC_SearchProjectCVC", for: indexPath) as! EBC_SearchProjectCVC
        cell.projectImage.image = UIImage(named: "demoImg-2")
        return cell
    }
    
    
    
    
    
    
}
