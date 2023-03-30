//
//  EBC_PhysicalProductVC.swift
//  EuroBond_Customer
//
//  Created by syed on 23/03/23.
//

import UIKit

class EBC_PhysicalProductVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PhysicalProductListDelegate {
    
    func didTappedAddToCartBtn(item: EBC_ProductListCVC) {
        print("added to cart")
    }
    
    @IBOutlet weak var lineLbl1: UILabel!
    @IBOutlet weak var highToLowView: UIView!
    @IBOutlet weak var categoryListView: UIView!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var priceFilterBtnHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var categoryListHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var searchBarHightConstraints: NSLayoutConstraint!
    @IBOutlet weak var highToLowBtn: UIButton!
    @IBOutlet weak var emptyProductMsgLbl: UILabel!
    @IBOutlet weak var productListingCollectionView: UICollectionView!
    @IBOutlet weak var categoryEmptyMsgLbl: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var searchBarTF: UITextField!
    @IBOutlet weak var pointRangeBarBtn: UIButton!
    @IBOutlet weak var categoryBarBtn: UIButton!
    @IBOutlet weak var searchBarBtn: UIButton!
    var filterByRangeArray = ["All Points", "Under 1000 pts", "1000 - 4999 pts", "5000 - 24999 pts", "25000 & Above pts"]
    var sortedBy = 0
    var bottonStatus = 0
    var flags = "Search"
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        productListingCollectionView.delegate = self
        productListingCollectionView.dataSource = self
        
        let collectionViewFLowLayout1 = UICollectionViewFlowLayout()
        collectionViewFLowLayout1.scrollDirection = .horizontal
        collectionViewFLowLayout1.minimumLineSpacing = 0
        collectionViewFLowLayout1.minimumInteritemSpacing = 0
        collectionViewFLowLayout1.estimatedItemSize = CGSize(width: 100, height: 30)
         self.productListingCollectionView.collectionViewLayout = collectionViewFLowLayout1
    
        let collectionViewFLowLayout2 = UICollectionViewFlowLayout()
        collectionViewFLowLayout2.itemSize = CGSize(width: CGFloat(((self.view.bounds.width - 38) - (self.productListingCollectionView.contentInset.left + self.productListingCollectionView.contentInset.right)) / 2), height: 230)
        collectionViewFLowLayout2.minimumLineSpacing = 2.5
        collectionViewFLowLayout2.minimumInteritemSpacing = 2.5
         self.productListingCollectionView.collectionViewLayout = collectionViewFLowLayout2
        emptyProductMsgLbl.isHidden = true
        categoryEmptyMsgLbl.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBarBtn.backgroundColor = selectedColor1
        categoryBarBtn.backgroundColor = deselectColor
        pointRangeBarBtn.backgroundColor = deselectColor
        searchBarView.isHidden = false
        categoryListView.isHidden = true
        highToLowView.isHidden = true
        lineLbl1.isHidden = true
        searchBarBtn.setTitleColor(UIColor.white, for: .normal)
        categoryBarBtn.setTitleColor(UIColor.black, for: .normal)
        pointRangeBarBtn.setTitleColor(UIColor.black, for: .normal)
        
    }
    
    @IBAction func selectSearcBarBtn(_ sender: UIButton) {
        searchBarBtn.backgroundColor = selectedColor1
        categoryBarBtn.backgroundColor = deselectColor
        pointRangeBarBtn.backgroundColor = deselectColor
        searchBarView.isHidden = false
        categoryListView.isHidden = true
        highToLowView.isHidden = true
        searchBarBtn.setTitleColor(UIColor.white, for: .normal)
        categoryBarBtn.setTitleColor(UIColor.black, for: .normal)
        pointRangeBarBtn.setTitleColor(UIColor.black, for: .normal)
    }
    
    @IBAction func selectCategoryBar(_ sender: UIButton) {
        searchBarBtn.backgroundColor = deselectColor
        categoryBarBtn.backgroundColor = selectedColor1
        pointRangeBarBtn.backgroundColor = deselectColor
        searchBarView.isHidden = true
        categoryListView.isHidden = false
        highToLowView.isHidden = true
        searchBarBtn.setTitleColor(UIColor.black, for: .normal)
        categoryBarBtn.setTitleColor(UIColor.white, for: .normal)
        pointRangeBarBtn.setTitleColor(UIColor.black, for: .normal)
    }
    
    @IBAction func selectPointRangeBtn(_ sender: UIButton) {
        searchBarBtn.backgroundColor = deselectColor
        categoryBarBtn.backgroundColor = deselectColor
        pointRangeBarBtn.backgroundColor = selectedColor1
        searchBarView.isHidden = true
        categoryListView.isHidden = false
        highToLowView.isHidden = false
        
        searchBarBtn.setTitleColor(UIColor.black, for: .normal)
        categoryBarBtn.setTitleColor(UIColor.black, for: .normal)
        pointRangeBarBtn.setTitleColor(UIColor.white, for: .normal)

    }
    
    
    
    @IBAction func selectHighLowBtn(_ sender: UIButton) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView{
            return filterByRangeArray.count
        }else if collectionView == productListingCollectionView{
         return 10
        }else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EBC_CategoryListCVC", for: indexPath) as! EBC_CategoryListCVC
            cell.categoryNameLbl.text = filterByRangeArray[indexPath.row]
            if indexPath.row == 0{
                cell.backgroundView1.backgroundColor = selectedColor2
                cell.categoryNameLbl.textColor = selectedColor1
            }else{
                cell.backgroundView1.backgroundColor = deselectColor
                cell.categoryNameLbl.textColor = UIColor.black
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EBC_ProductListCVC", for: indexPath) as! EBC_ProductListCVC
            cell.delegate = self
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productListingCollectionView{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_ProductDetails") as? EBC_ProductDetails
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
}
