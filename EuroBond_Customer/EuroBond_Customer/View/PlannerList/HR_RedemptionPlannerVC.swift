//
//  HR_RedemptionPlannerVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/10/22.
//

import UIKit
import SDWebImage
//import LanguageManager_iOS
class HR_RedemptionPlannerVC: BaseViewController, RedeemePlannedProductDelegate, popUpAlertDelegate {
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}

    
    func redeemProducts(_ cell: HR_RedemptionPlannerTVC) {
        self.selectedCatalogueID = -1
        guard let tappedIndex = redemptionPlannerTableView.indexPath(for: cell) else{return}
        self.selectedCatalogueID = self.VM.plannerListArray[tappedIndex.row].catalogueId ?? 0
        if cell.redeemBTN.tag == tappedIndex.row{
            let filterCategory = self.VM.myCartListArray.filter { $0.catalogueId == self.VM.plannerListArray[tappedIndex.row].catalogueId ?? 0}
            if filterCategory.count > 0{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                  vc!.descriptionInfo = "Gift product is already added in the Redeem list"
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
                print(self.totalCartValue, "Cart Value")
                print(self.redeemablePointsBalance, "Total points")
                print(self.selectedCatalogueID ?? 0)
                if self.totalCartValue < (Int(self.redeemablePointsBalance) ?? 0) {
                    let calcValue = self.totalCartValue + Int(self.VM.plannerListArray[tappedIndex.row].pointsRequired ?? 0)
                    print(calcValue)
                    if calcValue <= (Int(self.redeemablePointsBalance) ?? 0){
                        self.VM.addToCartApi(redemptionPlannerId: self.VM.plannerListArray[tappedIndex.row].redemptionPlannerId ?? 0)
                    }else{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                
                                vc!.descriptionInfo = "Insufficent Point Balance"
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
                        vc!.descriptionInfo = "Insufficent Point Balance"
                       
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                    }
                }
             
            }
            
            
            self.redemptionPlannerTableView.reloadData()
        }
    }
    
    
    func removeProducts(_ cell: HR_RedemptionPlannerTVC) {
        guard let tappedIndexPath = redemptionPlannerTableView.indexPath(for: cell) else {return}
        if cell.removeButton.tag == tappedIndexPath.row{
            self.removeProductId = self.VM.plannerListArray[tappedIndexPath.row].redemptionPlannerId ?? 0
            print(self.removeProductId, "Selected Product Id")
            self.VM.removeRedemptionPlanner()
        }
    }
    

    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var totalPts: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var cartCount: UILabel!
    @IBOutlet weak var redemptionPlannerTableView: UITableView!
    
    @IBOutlet weak var addToPlanner: GradientButton!
    
    var redeemablePointsBalance = UserDefaults.standard.string(forKey: "TotalPoints") ?? ""
    var VM = HR_RedemptionPlannerVM()
    var removeProductId = 0
    var itsComeFrom = ""
    var selectedCatalogueID = -1
    var selectedPlannerID = -1
    var totalCartValue = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.screenTitle.text = "Redemption Planner"
        self.points.text = "POINTS"
        self.totalPts.text! = "\(redeemablePointsBalance)"
        
        redemptionPlannerTableView.register(UINib(nibName: "HR_RedemptionPlannerTVC", bundle: nil), forCellReuseIdentifier: "HR_RedemptionPlannerTVC")
        NotificationCenter.default.addObserver(self, selector: #selector(callAPi), name: Notification.Name.plannerList, object: nil)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.redemptionPlannerTableView.delegate = self
        self.redemptionPlannerTableView.dataSource = self
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "No Internet Connection"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            self.VM.getMycartList()
            self.VM.redemptionPlannerList()
            self.VM.cartCountApi()
        }
    }
    @objc func callAPi(){
        self.VM.redemptionPlannerList()
    }
    
    @IBAction func backBTN(_ sender: Any) {
        if self.itsComeFrom == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func cartBTN(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_MyCartVC") as! HR_MyCartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func addToPlannerBTN(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RedeemNowVC") as! EBC_RedeemNowVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension HR_RedemptionPlannerVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.plannerListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HR_RedemptionPlannerTVC", for: indexPath) as! HR_RedemptionPlannerTVC
        cell.delegate = self
        cell.selectionStyle = .none
        cell.productName.text = self.VM.plannerListArray[indexPath.row].productName ?? ""
        cell.productPoints.text = "\(self.VM.plannerListArray[indexPath.row].pointsRequired ?? 0)"
        cell.desiredDate.text = self.VM.plannerListArray[indexPath.row].actualRedemptionDate ?? "00/00/0000"
        let imageURL = self.VM.plannerListArray[indexPath.row].productImage ?? ""
        if imageURL != ""{
            let urltoUse = String(productCatalogueImgURL + imageURL).replacingOccurrences(of: " ", with: "%20")
            let urlt = URL(string: "\(urltoUse)")
            cell.productImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
        }
        print(self.VM.plannerListArray[indexPath.row].sumOfTotalPointsRequired ?? 0, "TotalSum")
        if self.VM.plannerListArray[indexPath.row].pointsRequired ?? 0 >= Int(self.redeemablePointsBalance) ?? 0{
            cell.redeemBTN.isEnabled = false
            cell.redeemBTN.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }else if self.VM.plannerListArray[indexPath.row].pointsRequired ?? 0 <= Int(self.redeemablePointsBalance) ?? 0{
            cell.redeemBTN.isEnabled = true
            cell.redeemBTN.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        }
        cell.removeButton.tag = indexPath.row
        cell.redeemBTN.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_RedemptionPlannerDetailsVC") as! HR_RedemptionPlannerDetailsVC
        vc.totalPoints = self.totalPts.text!
        vc.cartTotalCount = "\(self.VM.myCartListArray.count)"
        vc.redemptionPlannerId = self.VM.plannerListArray[indexPath.row].redemptionPlannerId ?? 0
        vc.selectedCatalogueID = self.VM.plannerListArray[indexPath.row].catalogueId ?? 0
        vc.catalogueId = self.VM.plannerListArray[indexPath.row].catalogueId ?? 0
        vc.cashValue = self.VM.plannerListArray[indexPath.row].cashValue ?? 0
        vc.vendorId = self.VM.plannerListArray[indexPath.row].vendorId ?? 0
        vc.vendorName = self.VM.plannerListArray[indexPath.row].vendorName ?? ""
        vc.productName = self.VM.plannerListArray[indexPath.row].productName ?? ""
        vc.productImage = self.VM.plannerListArray[indexPath.row].productImage ?? ""
        vc.redeemableAverageEarning = self.VM.plannerListArray[indexPath.row].redeemableAverageEarning ?? ""
        vc.requiredPoints = self.VM.plannerListArray[indexPath.row].pointsRequired ?? 0
        vc.productDesc = self.VM.plannerListArray[indexPath.row].productDesc ?? ""
        vc.termsandContions = self.VM.plannerListArray[indexPath.row].termsCondition ?? ""
        vc.actualRedemptionDate = self.VM.plannerListArray[indexPath.row].actualRedemptionDate ?? ""

        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
