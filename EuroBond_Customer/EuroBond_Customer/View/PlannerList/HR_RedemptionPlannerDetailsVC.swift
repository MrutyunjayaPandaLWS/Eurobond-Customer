//
//  HR_RedemptionPlannerDetailsVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/11/22.
//

import UIKit
import SDWebImage
import LanguageManager_iOS
class HR_RedemptionPlannerDetailsVC: BaseViewController, popUpAlertDelegate{
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}

    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var overallstack: UIStackView!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var totalPts: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var cartCount: UILabel!
    @IBOutlet weak var congratulationsLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var redeemNowLbl: UILabel!
//    @IBOutlet weak var recommendedLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var redeemLbl: UILabel!
    @IBOutlet weak var redeempointsLbl: UILabel!
    @IBOutlet weak var totalRedeemPts: UILabel!
    @IBOutlet weak var redeemSummary: UILabel!
    @IBOutlet weak var redeemInfo: UILabel!
    @IBOutlet weak var redeemedPoints: UILabel!
    @IBOutlet weak var redeemedPtsTitle: UILabel!
    
    @IBOutlet weak var redeemBTN1: UIButton!
    @IBOutlet weak var redeemOfferBTN: UIButton!
    @IBOutlet weak var earningSummaryLbl: UILabel!
    @IBOutlet weak var earnedTotalPts: UILabel!
    @IBOutlet weak var earningPtsTitle: UILabel!
    @IBOutlet weak var expectInfoLbl: UILabel!
    @IBOutlet weak var redeemOfferBTNView: GradientView!
    @IBOutlet weak var redeemBTNView: GradientView!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var infoView: UIView!
    var VM = HR_RedemptionPlannerDetailsVM()
  
    var totalPoints = ""
    var selectedCatalogueID = 0
    var cartTotalCount = ""
    var redemptionId = 0
    
    
    var catalogueId = 0
    var actualRedemptionDate = ""
    var cashValue = 0
    var catalogueType = 0
    var redemptionPlannerId = 0
    var vendorName = ""
    var vendorId = 0
    var productImage = ""
    var productName = ""
    var requiredPoints = 0
    var redeemableAverageEarning = ""
    var productDesc = ""
    var termsandContions = ""
    var totalCartValue = 0
    var redeemablePointsBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
   // var redeemablePointsBalance = UserDefaults.standard.string(forKey: "TotalPoints") ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        localization()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.VM.getMycartList()
        self.VM.redemptionPlannerList()
        if self.requiredPoints >= Int(redeemablePointsBalance) ?? 0{
            self.redeemBTNView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.redeemBTN1.isEnabled = false
            self.redeemOfferBTNView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.redeemOfferBTN.isEnabled = false
            let calcValues = Int(self.requiredPoints) - (Int(redeemablePointsBalance) ?? 0)
            self.yellowView.isHidden = false
            self.whiteView.isHidden = true
            self.infoLbl.text = "You need".localiz() + "\(calcValues)" + "more redeemable euros to redeem this product".localiz()
        }else if self.requiredPoints <= Int(redeemablePointsBalance) ?? 0{
            self.redeemBTNView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            self.redeemBTN1.isEnabled = true
            self.redeemOfferBTNView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            self.redeemOfferBTN.isEnabled = true
            self.infoLbl.text = "Congratulation! You are eligible to redeem this product".localiz()
            self.yellowView.isHidden = true
            self.whiteView.isHidden = false

        }
        
        self.totalPts.text = self.totalPoints
        self.cartCount.text = self.cartTotalCount
        self.productNameLbl.text = self.productName
        self.redeemedPoints.text = self.redeemablePointsBalance
        self.totalRedeemPts.text = "\(self.requiredPoints)"
        print(self.requiredPoints)
        self.totalCartValue = Int(self.requiredPoints) ?? 0
        self.earnedTotalPts.text = self.redeemableAverageEarning
        let urltoUse = String(productCatalogueImgURL + productImage).replacingOccurrences(of: " ", with: "%20")
        let urlt = URL(string: "\(urltoUse)")
        productImg.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
    }
    func localization(){
        self.screenTitle.text = "Wishlist".localiz()
        self.pointsLbl.text = "EUROS".localiz()
        self.congratulationsLbl.text = "Congratulations".localiz()
        self.messageLbl.text = "eligible Msg".localiz()
        self.redeemNowLbl.text = "Redeem Now".localiz()
//        self.recommendedLbl.text = "RecommendedProducts"
        //self.redeemedPoints.text = "POINTS"
        self.redeemLbl.text = "Redeem Now".localiz()
        self.redeemSummary.text = "Redemption Planner Summary".localiz()
        self.redeemInfo.text = "Redeemable Euros As OnToday".localiz()
       // self.redeemedPoints.text = "Points"
        self.earningSummaryLbl.text = "Average Earning".localiz()
        self.earningPtsTitle.text = "Euros".localiz()
        self.expectInfoLbl.text = "Your expected redemption of".localiz() + "\(self.productName)" + "is in".localiz() + "\(actualRedemptionDate)"
        
    }
    
    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cartBTN(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_MyCartVC") as!
        HR_MyCartVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func redeemNowBTN(_ sender: Any) {
        let filterCategory = self.VM.myCartListArray.filter { $0.catalogueId == selectedCatalogueID}
        if filterCategory.count > 0{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Gift product is already added in the Redeem list".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            print(self.totalCartValue)
            print(self.redeemablePointsBalance)
            if self.totalCartValue <= (Int(self.redeemablePointsBalance) ?? 0) {
               
                    self.VM.addToCartApi(redemptionPlannerId: redemptionPlannerId)
                }else{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Insufficient Point Balance".localiz()
                   
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }
            
        }
    }
  
    @IBAction func redeemBTN(_ sender: Any) {
        print(self.selectedCatalogueID)
        let filterCategory = self.VM.myCartListArray.filter { $0.catalogueId == selectedCatalogueID}
        print(filterCategory.count)
        if filterCategory.count > 0{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Gift product is already added in the Redeem list".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            print(self.totalCartValue)
            print(self.redeemablePointsBalance)
            if self.totalCartValue <= (Int(self.redeemablePointsBalance) ?? 0) {
                    self.VM.addToCartApi(redemptionPlannerId: redemptionPlannerId)
                    }else{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.descriptionInfo = "Insufficient Point Balance".localiz()
                           
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                        }
                    }
            
        }
    }
    @IBAction func removeProductsBTN(_ sender: Any) {
        self.VM.removeRedemptionPlanner()
        self.navigationController?.popViewController(animated: true)
    }
}
