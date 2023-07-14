//
//  HR_RedemptionCatalogueDetailsVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/10/22.
//

import UIKit
import CoreData
import SDWebImage
import LanguageManager_iOS

protocol SelectedItemsDelegate: class{
    
    func selectedItem(_ vc: HR_RedemptionCatalogueDetailsVC)
}
class HR_RedemptionCatalogueDetailsVC: BaseViewController, popUpAlertDelegate{
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
  
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var screenTitleLbl: UILabel!
    @IBOutlet weak var totalPointsLbl: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var cartCount: UILabel!
    @IBOutlet weak var categoryTitleLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var addedToCart: GradientButton!
    
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var pointTitleLbl: UILabel!
    @IBOutlet weak var productPoints: UILabel!
    @IBOutlet weak var descriptionHeader: UILabel!
    @IBOutlet weak var descriptionDetails: UILabel!
    @IBOutlet weak var termandConditionsLbl: UILabel!
    @IBOutlet weak var termsandCondtionsDetails: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var popUpPointsLbl: UILabel!
    @IBOutlet weak var popUpPoints: UILabel!
    @IBOutlet weak var qtyHeader: UILabel!
    @IBOutlet weak var totalQty: UILabel!
    
    @IBOutlet weak var viewCartBTN: UIButton!
    @IBOutlet weak var pointsView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var addedPopUpView: UIView!
    @IBOutlet weak var addToPlanner: UIButton!
    @IBOutlet weak var addedToPlanner: UIButton!
    
    @IBOutlet weak var addToCartOrPlannerView: UIStackView!
    var productImages = ""
    var productName = ""
    var productDesc = ""
    var itsComeFrom = ""
    var isPlanner = ""
    var productPointss = 0
    var categoryTitle = ""
    var selectedCatalogueIds = 0
    var redeemablePointsBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    var VM = HR_RedemptionDetailsVM()
    var addedRedemablePointBalance = 0
    var productsLIST:Array = [AddToCART]()
    var termsandCondtions = ""
    
    var categoryId = -1
    var pointsRangePts = ""
    var sortedBy = 0
    var itsFrom = ""
    var delegate: SelectedItemsDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        localization()
            self.headerView.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
            addToPlanner.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
            addToCart.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
            self.pointsView.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
            self.viewCartBTN.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
    }
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
            self.VM.cartCountApi()
            NotificationCenter.default.post(name: .cartCount, object: nil)
//            self.cartCount.text = "\(UserDefaults.standard.string(forKey: "CartCount")!)"
            print(self.categoryTitle, "asdfadsfadsfadsfsdf")
            self.categoryTitleLbl.text = "Category/ \(self.categoryTitle)"
                self.productNameLbl.text = self.productName
                self.productPoints.text = "\(self.productPointss)"
                self.totalPointsLbl.text = "\(redeemablePointsBalance)"
                let urltoUse = String(productCatalogueImgURL + productImages).replacingOccurrences(of: " ", with: "%20")
                let urlt = URL(string: "\(urltoUse)")
                productImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "dashboardLogo"))
                self.addedPopUpView.isHidden = true
                self.termsandCondtionsDetails.text = self.termsandCondtions
                self.descriptionDetails.text = self.productDesc
//            if self.isPlanner == "true"{
                addToCartOrPlannerView.isHidden = false
                if self.productPointss <= Int(redeemablePointsBalance) ?? 0{
                    self.VM.getMycartList()
                }else{
                    self.VM.redemptionPlannerList()
                }
            
        }
    }
    func localization(){
        self.screenTitleLbl.text = "Redemption Catalogue".localiz()
        self.pointTitleLbl.text = "POINTS".localiz()
        self.categoryTitleLbl.text = "Category Electronics".localiz()
        self.pointsLbl.text = "POINTS".localiz()
        
        self.addedToCart.setTitle("Added to Cart".localiz(), for: .normal)
        self.addToPlanner.setTitle("Add to Planner".localiz(), for: .normal)
        self.addToCart.setTitle("Add to Cart".localiz(), for: .normal)
        self.addedToPlanner.setTitle("Added to Planner".localiz(), for: .normal)
        

        self.descriptionHeader.text = "Descriptions".localiz()
        self.termandConditionsLbl.text = "TermsAndConditions".localiz()
        self.popUpPointsLbl.text = "POINTS".localiz()
        self.qtyHeader.text = "QTY".localiz()
        self.viewCartBTN.setTitle("View Cart".localiz(), for: .normal)
        
//        let filterCategory = self.VM.plannerListArray.filter{$0.catalogueId == self.selectedCatalogueIds}
//        print(selectedCatalogueIds)
//        print(filterCategory.count)
//        if filterCategory.count > 0 {
//            self.addToPlanner.isHidden = true
//            self.addToCart.isHidden = true
//            self.addedToCart.isHidden = true
//            self.addedToPlanner.isHidden = false
//        }else{
//            self.addToPlanner.isHidden = false
//            self.addToCart.isHidden = true
//            self.addedToCart.isHidden = true
//            self.addedToPlanner.isHidden = true
//        }
        
        
        
    }
    
    @IBAction func backBTN(_ sender: Any) {
        self.delegate?.selectedItem(self)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addedToCartButton(_ sender: Any) {
    }
    
    @IBAction func addToCartButton(_ sender: Any) {
        if UserDefaults.standard.string(forKey: "verificationStatus") == "1"{
            print(redeemablePointsBalance,"dslkdm")
            print(self.VM.sumOfProductsCount,"kjdnd")
        if self.VM.sumOfProductsCount <= Int(redeemablePointsBalance) ?? 0{
            let calcValue = self.VM.sumOfProductsCount + Int(productPointss)
            if calcValue <= Int(redeemablePointsBalance) ?? 0{
                self.VM.addToCartApi()
                NotificationCenter.default.post(name: .cartCount, object: nil)
                self.addedPopUpView.isHidden = true
                let urltoUse = String(productCatalogueImgURL + productImages).replacingOccurrences(of: " ", with: "%20")
                let urlt = URL(string: "\(urltoUse)")
                productImg.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "dashboardLogo"))
                self.productImg.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "dashboardLogo"))
                self.popUpPoints.text = "\(productPointss)"
            }else{
                DispatchQueue.main.async{
                   let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                   vc!.delegate = self
                   vc!.titleInfo = ""
                    vc!.descriptionInfo = "Need Sufficient Point Balance"
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
                vc!.descriptionInfo = "Need Sufficient Point Balance"
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
            vc!.descriptionInfo = "Your account is unverified! Kindly contact the administrator to access the redemption Catalogue"
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        }
    }
    }
    
    @IBAction func addToPlannerBTN(_ sender: Any) {
        if UserDefaults.standard.string(forKey: "verificationStatus") == "1"{

        let filterCategory = self.VM.plannerListArray.filter{$0.catalogueId == self.selectedCatalogueIds}
                
        if filterCategory.count > 0 {

                self.addToPlanner.isHidden = true
                self.addToCart.isHidden = true
                self.addedToCart.isHidden = true
                self.addedToPlanner.isHidden = false

        } else {
            self.VM.addedToPlanner()
            self.VM.cartCountApi()
   
        }
        }else{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Your account is unverified! Kindly contact the administrator to access the redemption Catalogue".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func viewCartButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_MyCartVC") as! HR_MyCartVC
        self.navigationController?.pushViewController(vc, animated: true)
            }
    
    @IBAction func cartBTN(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_MyCartVC") as! HR_MyCartVC
        self.navigationController?.pushViewController(vc, animated: true)
            }
    }

