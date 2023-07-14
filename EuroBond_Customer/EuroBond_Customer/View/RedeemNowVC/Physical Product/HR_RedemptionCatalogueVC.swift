//
//  HR_RedemptionCatalogueVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/10/22.
//

import UIKit
import CoreData
import SDWebImage
import LanguageManager_iOS

class HR_RedemptionCatalogueVC: BaseViewController, popUpAlertDelegate, AddToCartDelegate,  SelectedItemsDelegate, UITextFieldDelegate{
    
    func selectedItem(_ vc: HR_RedemptionCatalogueDetailsVC) {
        self.categoryId = vc.categoryId
        self.selectedPtsRange = vc.pointsRangePts
        self.selectedPtsRange1 = vc.pointsRangePts
        self.sortedBy = vc.sortedBy
        self.VM.catalgoueListArray.removeAll()
        self.startIndex = 1
        self.itsFrom = vc.itsFrom
        
    }
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    func addToPlanner(_ cell: HR_CatalogueDetailsCVC) {
        if UserDefaults.standard.string(forKey: "verificationStatus") == "1"{
        self.plannerProductId = 0
        if cell.addToPlanner.isHidden == false{
            guard let tappedIndexPath = productsDetailCollectionView.indexPath(for: cell) else{return}
            if cell.addToPlanner.tag == tappedIndexPath.row{
                let filterCategory1 = self.VM.plannerListArray.filter { $0.catalogueId == self.VM.catalgoueListArray[tappedIndexPath.row].catalogueId ?? 0 }
                if filterCategory1.count == 0{
                    self.plannerProductId = self.VM.catalgoueListArray[tappedIndexPath.row].catalogueId ?? 0
                    self.VM.addedToPlanner()
                }else{
                    DispatchQueue.main.async{
                    
                       let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                       vc!.delegate = self
                       vc!.titleInfo = ""
                        vc!.descriptionInfo = "Already added to planner".localiz()
                       vc!.modalPresentationStyle = .overCurrentContext
                       vc!.modalTransitionStyle = .crossDissolve
                       self.present(vc!, animated: true, completion: nil)
                }
                }
                
            }
        }
        self.productsDetailCollectionView.reloadData()
    }else{
        DispatchQueue.main.async{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
            vc!.delegate = self
            vc!.titleInfo = ""
            vc!.descriptionInfo = "YourAccountUnverified".localiz()
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        }
    }

    }
    func addToCartProducts(_ cell: HR_CatalogueDetailsCVC){
        if UserDefaults.standard.string(forKey: "verificationStatus") == "1"{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                self.selectedCatalogueID = 0
                if cell.addCartButton.isHidden == false{
                    guard let tappedIndexPath = self.productsDetailCollectionView.indexPath(for: cell) else{return}
                    print(cell.addCartButton.tag)
                    print(tappedIndexPath.row)
                    if cell.addCartButton.tag == tappedIndexPath.row{
                        print(self.redeemablePointsBalance , "Redeemable Point Balance")
                        print(self.VM.sumOfProductsCount, "Sum of products Count")
                        if self.VM.sumOfProductsCount <= Int(self.redeemablePointsBalance) ?? 0 && Int(self.VM.catalgoueListArray[tappedIndexPath.row].pointsRequired ?? 0) != 0 {
                            let calcValue = self.VM.sumOfProductsCount + Int(self.VM.catalgoueListArray[tappedIndexPath.row].pointsRequired ?? 0)
                            print(calcValue, "calcValues")
                            if calcValue <= Int(self.redeemablePointsBalance) ?? 0{
                                self.selectedCatalogueID = self.VM.catalgoueListArray[tappedIndexPath.row].catalogueId ?? 0
                                self.VM.addToCartApi()
                                NotificationCenter.default.post(name: .cartCount, object: nil)
                            }else{
                                DispatchQueue.main.async{
                                    
                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                                    vc!.delegate = self
                                    vc!.titleInfo = ""
                                    vc!.descriptionInfo = "NeedSufficientPointBalance".localiz()
                                    vc!.modalPresentationStyle = .overCurrentContext
                                    vc!.modalTransitionStyle = .crossDissolve
                                    self.present(vc!, animated: true, completion: nil)
                                }
                            }
                            
                        }else{
                            DispatchQueue.main.async{
                                
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.descriptionInfo = "NeedSufficientPointBalance".localiz()
                                vc!.modalPresentationStyle = .overCurrentContext
                                vc!.modalTransitionStyle = .crossDissolve
                                self.present(vc!, animated: true, completion: nil)
                            }
                        }
                        self.productsDetailCollectionView.reloadData()
                    }
                    
                }
            })
    }else{
        DispatchQueue.main.async{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
            vc!.delegate = self
            vc!.titleInfo = ""
            vc!.descriptionInfo = "YourAccountUnverified".localiz()
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        }
    }
    }

    @IBOutlet weak var noDataFound: UILabel!
    @IBOutlet weak var productCategoryCollectionView: UICollectionView!
    
    @IBOutlet weak var productsDetailCollectionView: UICollectionView!
    
    @IBOutlet weak var searchProductTF: UITextField!
    @IBOutlet weak var noDataFoundCategoryList: UILabel!
    
    @IBOutlet var collectionViewTopSPace: NSLayoutConstraint!
    
    @IBOutlet weak var separatorLbl: UILabel!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var highToLowBtn: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBOutlet weak var pointsRangeButton: UIButton!
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var searchViewHeight: NSLayoutConstraint!
    
    
    let VM = HR_RedemptionCatalogueListVM()
    var isComeFrom = ""
    var selectedCategoryName = ""
    var selectedCatalogueID = 0
    var plannerProductId = 0
    var selectedId = 0
    var redeemablePointsBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? "0"
    var productsLIST:Array = [AddToCART]()
    var returnValue = 0
    var selectedCategoryID = "-1"
    var addedRedemablePointBalance = 0
    var productValues = 0
    var addedPoints = 0
    var categoryId = -1
    
    var noofelements = 0
    var startIndex = 1
    var searchTab = 1
    var categoriesId = 0
    var noOfRows = 0
    var itsComeFrom = ""
    
    var selectedPtsRange = ""
    var selectedPtsRange1 = ""
//    var filterByRangeArray = ["All Euros".localiz(), "Under 1000".localiz(), "1000 - 4999", "5000 - 24999", "25000 & Above".localiz()]
    var filterByRangeArray = ["All Euros".localiz(), "5000 - 19000", "20000 - 29000", "30000 & Above"]
    var sortedBy = 0
    var itsFrom = "Search"
    var parameters : JSON?
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
//        self.productCategoryCollectionView.reloadData()

        self.highToLowBtn.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
        let collectionViewFLowLayout1 = UICollectionViewFlowLayout()
        collectionViewFLowLayout1.scrollDirection = .horizontal
        collectionViewFLowLayout1.minimumLineSpacing = 0
        collectionViewFLowLayout1.minimumInteritemSpacing = 0
        collectionViewFLowLayout1.estimatedItemSize = CGSize(width: 100, height: 30)
         self.productCategoryCollectionView.collectionViewLayout = collectionViewFLowLayout1
    
        let collectionViewFLowLayout2 = UICollectionViewFlowLayout()
        collectionViewFLowLayout2.itemSize = CGSize(width: CGFloat(((self.view.bounds.width - 38) - (self.productsDetailCollectionView.contentInset.left + self.productsDetailCollectionView.contentInset.right)) / 2), height: 230)
        collectionViewFLowLayout2.minimumLineSpacing = 2.5
        collectionViewFLowLayout2.minimumInteritemSpacing = 2.5
         self.productsDetailCollectionView.collectionViewLayout = collectionViewFLowLayout2
        self.localizSetup()
        alertPopUp()
    }
 
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        print("refresh")
//        self.productCategoryCollectionView.collectionViewLayout.invalidateLayout()
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "No Internet Connection".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
             self.noDataFound.isHidden = true
            self.noDataFoundCategoryList.isHidden = true
            self.noDataFound.text = "No data found !!"//
            self.searchProductTF.placeholder = "Search Products".localiz()//
            self.searchProductTF.delegate = self
            self.productsDetailCollectionView.isHidden = true
            self.productCategoryCollectionView.delegate = self
            self.productCategoryCollectionView.dataSource = self
            self.productsDetailCollectionView.delegate = self
            self.productsDetailCollectionView.dataSource = self
            if self.itsFrom == "Search" || self.itsFrom == ""{
                self.startIndex = 1
                self.noofelements = 10
                self.VM.catalgoueListArray.removeAll()
                self.searchTab = 1
                self.collectionViewHeight.constant = 0
                self.tableViewTopConstraint.constant = 68
                self.searchView.isHidden = false
                self.searchViewHeight.constant = 45
                self.noDataFound.isHidden = true
                self.highToLowBtn.isHidden = true
                self.collectionViewTopSPace.constant = 55
                self.highToLowBtn.setTitle("Low To High".localiz(), for: .normal)
                self.separatorLbl.isHidden = true
//                if self.loginCustomerTypeId == "1"{
//                    self.searchButton.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.01568627451, blue: 0.0431372549, alpha: 1)
//                }else{
                    self.searchButton.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
               // }
            }else if self.itsFrom == "Category"{
                self.VM.catalgoueListArray.removeAll()
                self.itsFrom = "Category"
                self.selectedPtsRange1 = ""
                self.selectedPtsRange = ""
                self.searchButton.backgroundColor = .lightGray
//                if self.loginCustomerTypeId == "1"{
//                    self.categoryButton.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.01568627451, blue: 0.0431372549, alpha: 1)
//                }else{
                    self.categoryButton.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
             //   }
                
                self.pointsRangeButton.backgroundColor = .lightGray
                self.collectionViewTopSPace.constant = 10
                self.collectionViewHeight.constant = 50
                self.productCategoryCollectionView.isHidden = false
                self.tableViewTopConstraint.constant = 90
                self.highToLowBtn.isHidden = true
                self.searchView.isHidden = true
                self.searchViewHeight.constant = 0
                self.separatorLbl.isHidden = false
            }else if self.itsFrom == "PtsRange"{
                self.VM.catalgoueListArray.removeAll()
                self.searchButton.backgroundColor = .lightGray
                self.categoryButton.backgroundColor = .lightGray
//                if self.loginCustomerTypeId == "1"{
//                    self.pointsRangeButton.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.01568627451, blue: 0.0431372549, alpha: 1)
//                }else{
                    self.pointsRangeButton.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
               // }
                self.collectionViewHeight.constant = 60
                self.productCategoryCollectionView.isHidden = false
                self.tableViewTopConstraint.constant = 140
                self.collectionViewTopSPace.constant = 10
                self.highToLowBtn.isHidden = false
                self.searchView.isHidden = true
                self.searchViewHeight.constant = 0
                self.separatorLbl.isHidden = false
                print(self.selectedPtsRange1)
                print(self.selectedPtsRange)
                self.itsFrom = "PtsRange"
                
          
                
                if self.selectedPtsRange == ""{
                    self.selectedPtsRange1 = "All Euros".localiz()
                }
//                else if self.selectedPtsRange == "0-999"{
//                    self.selectedPtsRange1 = "Under 1000".localiz()
//                }
                else if self.selectedPtsRange1 == "5000-19000"{
                    self.selectedPtsRange1 = "5000 - 19000"
                }else if self.selectedPtsRange == "20000-29000"{
                    self.selectedPtsRange1 = "20000 - 29000"
                }else if self.selectedPtsRange == "30000 - 999999999"{
                    self.selectedPtsRange1 = "30000 & Above"
                }
                self.startIndex = 1
                self.categoriesId = 2
                self.searchTab = 0
                if self.sortedBy == 1{
                    self.sortedBy = 1
                    self.highToLowBtn.setTitle("Low To High".localiz(), for: .normal)
                    
                }else{
                    self.sortedBy = 0
                    self.highToLowBtn.setTitle("High To Low".localiz(), for: .normal)
                   
                }
            }
            self.VM.getMycartList()
            self.productsDetailCollectionView.reloadData()
            NotificationCenter.default.post(name: .cartCount, object: nil)
            
            
        }
    }

    func localizSetup(){
        self.searchButton.setTitle("Search".localiz(), for: .normal)
        self.categoryButton.setTitle("catery".localiz(), for: .normal)
        self.pointsRangeButton.setTitle("Points Range".localiz(), for: .normal)
        self.searchProductTF.placeholder = "Search Products".localiz()
    }
   
    @IBAction func searchProductEditingChanged(_ sender: Any) {
        self.VM.catalgoueListArray.removeAll()
        self.startIndex = 1
        self.itsFrom = "Search"
        self.VM.catalogueListApi(searchText: self.searchProductTF.text ?? "", startIndex: self.startIndex)
//        if self.VM.catalgoueListArray.count > 0 {
//            let arr = self.VM.catalgoueListArray.filter{ ($0.productName!.localizedCaseInsensitiveContains(self.searchProductTF.text!))}
//                   if self.searchProductTF.text! != ""{
//                   if arr.count > 0 {
//                    self.VM.catalgoueListArray.removeAll(keepingCapacity: true)
//                    self.VM.catalgoueListArray = arr
//                       self.productsDetailCollectionView.reloadData()
//                        productsDetailCollectionView.isHidden = false
//                   }else {
//                    self.VM.catalgoueListArray = self.VM.brandArray
//                       self.productsDetailCollectionView.reloadData()
//                    productsDetailCollectionView.isHidden = true
//                   }
//               }else{
//                self.VM.catalgoueListArray = self.VM.brandArray
//                   self.productsDetailCollectionView.reloadData()
//                productsDetailCollectionView.isHidden = false
//               }
//                   let searchText = self.searchProductTF.text!
//               if searchText.count > 0 || self.VM.catalgoueListArray.count == self.VM.brandArray.count {
//                       self.productsDetailCollectionView.reloadData()
//                   }
//               }
        
    }
    
    
    @IBAction func highToLowButton(_ sender: Any) {
        
        if self.sortedBy == 1{
            self.sortedBy = 0
            self.highToLowBtn.setTitle("High To Low".localiz(), for: .normal)
        }else{
            self.sortedBy = 1
            self.highToLowBtn.setTitle("Low To High".localiz(), for: .normal)
        }
        self.VM.catalgoueListArray.removeAll()
        self.startIndex = 1
        self.itsFrom = "PtsRange"
        self.VM.catalogueListApi(searchText: self.searchProductTF.text ?? "", startIndex: self.startIndex)
    }
    @IBAction func searchBtn(_ sender: Any) {
        self.VM.catalgoueListArray.removeAll()
        self.productCategoryCollectionView.reloadData()
//        if self.loginCustomerTypeId == "1"{
//            self.searchButton.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.01568627451, blue: 0.0431372549, alpha: 1)
//        }else{
            self.searchButton.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
      //  }
        self.categoryButton.backgroundColor = .lightGray
        self.pointsRangeButton.backgroundColor = .lightGray
//        self.collectionViewHeight.constant = 0
//        self.productCategoryCollectionView.isHidden = true
//        self.tableViewTopConstraint.constant = 68
//        self.highToLowBtn.isHidden = true
//        self.searchView.isHidden = false
//        self.searchViewHeight.constant = 45
//        self.collectionViewTopSPace.constant = 55
//        self.itsFrom = "Search"
//        self.searchProductTF.text = ""
//        self.startIndex = 1
//        self.searchTab = 1
//        self.categoriesId = 0
//        self.sortedBy = 1
//        self.separatorLbl.isHidden = true
//        self.highToLowBtn.setTitle("Low To High", for: .normal)
                self.productCategoryCollectionView.isHidden = true
        self.startIndex = 1
        self.noofelements = 10
        self.VM.catalgoueListArray.removeAll()
        self.searchTab = 1
        self.categoriesId = 0
        self.collectionViewHeight.constant = 0
        self.tableViewTopConstraint.constant = 68
        self.searchView.isHidden = false
        self.searchViewHeight.constant = 45
        self.noDataFound.isHidden = true
        self.highToLowBtn.isHidden = true
        self.collectionViewTopSPace.constant = 55
        self.itsFrom = "Search"
        self.highToLowBtn.setTitle("Low To High".localiz(), for: .normal)
        self.separatorLbl.isHidden = true
//        self.VM.getMycartList()
        self.VM.catalogueListApi(searchText: self.searchProductTF.text ?? "", startIndex: self.startIndex)
    }
    @IBAction func categoryBtn(_ sender: Any) {
        self.VM.catalgoueListArray.removeAll()
        self.productCategoryCollectionView.reloadData()
        self.highToLowBtn.setTitle("High To Low".localiz(), for: .normal)
        self.itsFrom = "Category"
        self.selectedPtsRange1 = ""
        self.selectedPtsRange = ""
        self.searchButton.backgroundColor = .lightGray
//        if self.loginCustomerTypeId == "1"{
//            self.categoryButton.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.01568627451, blue: 0.0431372549, alpha: 1)
//        }else{
            self.categoryButton.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
       // }
        self.pointsRangeButton.backgroundColor = .lightGray
        self.collectionViewTopSPace.constant = 10
        self.collectionViewHeight.constant = 50
        self.productCategoryCollectionView.isHidden = false
        self.tableViewTopConstraint.constant = 90
        self.highToLowBtn.isHidden = true
        self.searchView.isHidden = true
        self.searchViewHeight.constant = 0
        self.separatorLbl.isHidden = false
        self.categoriesId = 1
        self.startIndex = 1
        self.searchTab = 0
        self.sortedBy = 0
        self.VM.getMycartList()
    }
    
    @IBAction func pointRangeBtn(_ sender: Any) {
      //  self.VM.productCategoryListArray.removeAll()
        self.VM.catalgoueListArray.removeAll()
        self.productCategoryCollectionView.reloadData()
        self.searchButton.backgroundColor = .lightGray
        self.categoryButton.backgroundColor = .lightGray
//        if self.loginCustomerTypeId == "1"{
//            self.pointsRangeButton.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.01568627451, blue: 0.0431372549, alpha: 1)
//        }else{
            self.pointsRangeButton.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
        //}
        self.collectionViewHeight.constant = 60
        self.productCategoryCollectionView.isHidden = false
        self.tableViewTopConstraint.constant = 140
        self.collectionViewTopSPace.constant = 10
        self.highToLowBtn.isHidden = false
        self.searchView.isHidden = true
        self.searchViewHeight.constant = 0
        self.separatorLbl.isHidden = false
        self.itsFrom = "PtsRange"
        self.selectedPtsRange1 = "All Euros".localiz()
        self.selectedPtsRange = ""
        self.startIndex = 1
        self.categoriesId = 2
        self.searchTab = 0
        self.VM.getMycartList()
    }
    
    
}
extension HR_RedemptionCatalogueVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productCategoryCollectionView{
            if self.itsFrom == "Category"{
                return self.VM.productCategoryListArray.count
            }else if self.itsFrom == "PtsRange"{
                return self.filterByRangeArray.count
            }else{
                return 1
            }
        }else if collectionView == productsDetailCollectionView{
            return self.VM.catalgoueListArray.count
        }else{
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productCategoryCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HR_ProductCategoryCVC", for: indexPath) as! HR_ProductCategoryCVC
            cell.categoryName.text = "\(self.VM.productCategoryListArray[indexPath.row].productCategorName ?? "")      ".capitalized
            if self.categoriesId == 1{
                if self.categoryId == Int(self.VM.productCategoryListArray[indexPath.item].productCategoryId!) ?? -1{
                     cell.categoryName.textColor = UIColor.white
                     
//                    if self.loginCustomerTypeId == "1"{
//                        cell.categoryName.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.01568627451, blue: 0.0431372549, alpha: 1)
//                    }else{
                        cell.categoryName.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
                  //  }
                }else{
                        cell.categoryName.textColor = UIColor.white
                        cell.categoryName.backgroundColor = .lightGray
                  
                    }
            }else if self.categoriesId == 2{
                if self.filterByRangeArray.count != 0 {
                    cell.categoryName.textAlignment = .center
                    cell.categoryName.text = "  \(self.filterByRangeArray[indexPath.row])    "
                    
            
                    if self.selectedPtsRange1 == "\(self.filterByRangeArray[indexPath.row])"{
                        cell.categoryName.textColor = UIColor.white
//                        if self.loginCustomerTypeId == "1"{
//                            cell.categoryName.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.01568627451, blue: 0.0431372549, alpha: 1)
//                        }else{
                            cell.categoryName.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
                       // }
                    }else{
                        cell.categoryName.textColor = UIColor.white
                        cell.categoryName.backgroundColor = .lightGray
                    }
                }
                
            }
      
              
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HR_CatalogueDetailsCVC", for: indexPath) as! HR_CatalogueDetailsCVC
            cell.delegate = self
            cell.addCartButton.tag = indexPath.item
            cell.addToPlanner.tag = indexPath.item
            if self.VM.catalgoueListArray.count != 0 {
            cell.categoryNameLbl.text = "Category/\(self.VM.catalgoueListArray[indexPath.row].catogoryName ?? "")"
            cell.setCollectionData(redemptionDetailObj: self.VM.catalgoueListArray[indexPath.item], redeemedPointBalance: Int(self.redeemablePointsBalance) ?? 0, cartItems: productsLIST)
            let filterCategory = self.VM.myCartListArray.filter { $0.catalogueId == self.VM.catalgoueListArray[indexPath.item].catalogueId ?? 0 }
            let filterCategory1 = self.VM.plannerListArray.filter { $0.catalogueId == self.VM.catalgoueListArray[indexPath.item].catalogueId ?? 0 }
            let productPoints = self.VM.catalgoueListArray[indexPath.item].pointsRequired ?? 0
            print(self.redeemablePointsBalance, "OverAllPointBalance")
            
            if productPoints < Int(self.redeemablePointsBalance) ?? 0{
                cell.addedToCartBTN.isHidden = true
                cell.addToPlanner.isHidden = true
                cell.addCartButton.isHidden = false
                cell.addedToPlanner.isHidden = true
                
                cell.addedToCartBTN.setTitle("Added to Cart".localiz(), for: .normal)
                cell.addToPlanner.setTitle("Add to Planner".localiz(), for: .normal)
                cell.addCartButton.setTitle("Add to Cart".localiz(), for: .normal)
                cell.addedToPlanner.setTitle("Added to Planner".localiz(), for: .normal)
                
                if filterCategory.count > 0 {
                    cell.addedToCartBTN.isHidden = false
                    cell.addedToCartBTN.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                    cell.addToPlanner.isHidden = true
                    cell.addCartButton.isHidden = true
                    cell.addedToPlanner.isHidden = true
                    
                    cell.addedToCartBTN.setTitle("Added to Cart".localiz(), for: .normal)
                    cell.addToPlanner.setTitle("Add to Planner".localiz(), for: .normal)
                    cell.addCartButton.setTitle("Add to Cart".localiz(), for: .normal)
                    cell.addedToPlanner.setTitle("Added to Planner".localiz(), for: .normal)
                    
                }
            }else{
                if self.VM.catalgoueListArray[indexPath.row].isPlanner! == true{
                    cell.addedToCartBTN.isHidden = true
                    cell.addToPlanner.isHidden = false
                    cell.addCartButton.isHidden = true
                    cell.addedToPlanner.isHidden = true
                    
                    cell.addedToCartBTN.setTitle("Added to Cart".localiz(), for: .normal)
                    cell.addToPlanner.setTitle("Add to Planner".localiz(), for: .normal)
                    cell.addCartButton.setTitle("Add to Cart".localiz(), for: .normal)
                    cell.addedToPlanner.setTitle("Added to Planner".localiz(), for: .normal)
                    
                }else{
                    cell.addedToCartBTN.isHidden = true
                    cell.addToPlanner.isHidden = true
                    cell.addCartButton.isHidden = true
                    cell.addedToPlanner.isHidden = true
                    
                    cell.addedToCartBTN.setTitle("Added to Cart".localiz(), for: .normal)
                    cell.addToPlanner.setTitle("Add to Planner".localiz(), for: .normal)
                    cell.addCartButton.setTitle("Add to Cart".localiz(), for: .normal)
                    cell.addedToPlanner.setTitle("Added to Planner".localiz(), for: .normal)
                }
                if filterCategory1.count > 0 {
                    cell.addedToCartBTN.isHidden = true
                    cell.addToPlanner.isHidden = true
                    cell.addCartButton.isHidden = true
                    cell.addedToPlanner.isHidden = false
                    
                    cell.addedToCartBTN.setTitle("Added to Cart".localiz(), for: .normal)
                    cell.addToPlanner.setTitle("Add to Planner".localiz(), for: .normal)
                    cell.addCartButton.setTitle("Add to Cart".localiz(), for: .normal)
                    cell.addedToPlanner.setTitle("Added to Planner".localiz(), for: .normal)
                }
                
            }
        }
           
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productCategoryCollectionView{
            
                if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        vc!.descriptionInfo = "No Internet Connection".localiz()
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                    }
                }else{
                    if self.itsFrom != "PtsRange"{
                        self.categoryId = Int(self.VM.productCategoryListArray[indexPath.item].productCategoryId!) ?? -1
                        self.VM.productCategoryListArray[indexPath.item].isSelected = 1
                        self.VM.catalgoueListArray.removeAll()
                        self.itsFrom = "Category"
                        self.startIndex = 1
                        self.selectedPtsRange1 = ""
                        self.selectedPtsRange = ""
                        self.VM.getMycartList()
                    }else{
                        //self.categoryId = -1
                        self.categoriesId = 2
                        self.selectedPtsRange1 = "All Euros".localiz()
                        self.selectedPtsRange1 = "\(self.filterByRangeArray[indexPath.row])"
                        print(self.selectedPtsRange1)
                        if self.selectedPtsRange1 == "All Euros".localiz(){
                            self.selectedPtsRange = ""
                        }
//                        else if self.selectedPtsRange1 == "Under 1000".localiz(){
//                            self.selectedPtsRange = "0-999"
//                        }
                        else if self.selectedPtsRange1 == "5000 - 19000"{
                            self.selectedPtsRange = "5000-19000"
                        }else if self.selectedPtsRange1 == "20000 - 29000"{
                            self.selectedPtsRange = "20000-29000"
                        }else if self.selectedPtsRange1 == "30000 & Above"{
                            self.selectedPtsRange = "30000 - 999999999"
                        }
                        self.VM.catalgoueListArray.removeAll()
                        self.startIndex = 1
                        self.itsFrom = "PtsRange"
                        self.productCategoryCollectionView.reloadData()
                        self.VM.catalogueListApi(searchText: self.searchProductTF.text ?? "", startIndex: self.startIndex)
                        
                    }
                   
                    
                    
                }
          
        }else if collectionView == productsDetailCollectionView{
         
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_RedemptionCatalogueDetailsVC") as! HR_RedemptionCatalogueDetailsVC
            vc.itsComeFrom = "RedemptionCatalgoue"
            vc.delegate = self
            vc.productName = self.VM.catalgoueListArray[indexPath.row].productName ?? ""
            vc.productPointss = self.VM.catalgoueListArray[indexPath.row].pointsRequired ?? 0
            vc.selectedCatalogueIds = self.VM.catalgoueListArray[indexPath.row].catalogueId ?? 0
            print("\(self.VM.catalgoueListArray[indexPath.row].productImage ?? "") - Product Image")
            vc.productImages = self.VM.catalgoueListArray[indexPath.row].productImage ?? ""
            vc.productDesc = self.VM.catalgoueListArray[indexPath.row].productDesc ?? ""
            vc.termsandCondtions = self.VM.catalgoueListArray[indexPath.row].termsCondition ?? ""
            print("\(self.VM.catalgoueListArray[indexPath.row].isPlanner!) Planner is ")
            vc.isPlanner = "\(self.VM.catalgoueListArray[indexPath.row].isPlanner!)"
            vc.categoryTitle = self.VM.catalgoueListArray[indexPath.row].catogoryName ?? ""
            
            vc.categoryId = self.categoryId
            vc.pointsRangePts = self.selectedPtsRange
            vc.sortedBy = self.sortedBy
            vc.itsFrom = self.itsFrom
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == productsDetailCollectionView{
            if indexPath.row == self.VM.catalgoueListArray.count - 1{
                if self.noofelements == 10{
                    self.startIndex = self.startIndex + 1
                    self.VM.catalogueListApi(searchText: self.searchProductTF.text ?? "", startIndex: self.startIndex)
                }else if self.noofelements > 10{
                    self.startIndex = self.startIndex + 1
                    self.VM.catalogueListApi(searchText: self.searchProductTF.text ?? "", startIndex: self.startIndex)
                }else if self.noofelements < 10{
                    print("no need to hit API")
                    return
                }else{
                    print("n0 more elements")
                    return
                }
            }
        }

    }
    
    func alertPopUp(){
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SuccessPopUpMessage2") as? SuccessPopUpMessage2
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
//        vc?.message = "Only 90% of your available Euros can be redeemable"
//        vc?.delegate = self
        present(vc!, animated: true)
    }
    
    
}


