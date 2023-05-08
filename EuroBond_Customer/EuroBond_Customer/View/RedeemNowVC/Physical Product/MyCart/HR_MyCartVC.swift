//
//  HR_MyCartVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/10/22.
//

import UIKit
import CoreData
import SDWebImage
import LanguageManager_iOS
class HR_MyCartVC: BaseViewController, cartDetailsDelegate, popUpAlertDelegate{
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    func increaseProductQty(_ cell: HR_MyCartTVC) {
        guard let tappedIndexPath = self.myCartTableView.indexPath(for: cell) else{return}
        print(tappedIndexPath.row,"index0")
        print(cell.addBTN.tag,"index1")
       // if VM.myCartListArray.count != 0 {
            if cell.addBTN.tag == tappedIndexPath.row{
                
                  DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                if Int(self.VM.myCartListArray[tappedIndexPath.row].sumOfTotalPointsRequired ?? 0) <= Int(self.redeemablePointsBalance) ?? 0 {
                    let calcValue = Int(self.VM.myCartListArray[tappedIndexPath.row].sumOfTotalPointsRequired ?? 0) + Int(self.VM.myCartListArray[tappedIndexPath.row].pointsPerUnit ?? 0)
                    print(calcValue, "Calculated Values")
                    if calcValue <= Int(self.redeemablePointsBalance) ?? 0{
                        //                    self.quantity += 1
                        let totalQTY = Int(self.VM.myCartListArray[tappedIndexPath.row].noOfQuantity ?? 0) + 1
                        
                        
                        self.customerCartId = self.VM.myCartListArray[tappedIndexPath.row].customerCartId ?? 0
                        cell.qtyLbl.text = "\(totalQTY)"
                        self.quantity = totalQTY
                        self.VM.increaseProductApi()
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
                })
           // }
        }
        self.myCartTableView.reloadData()
    }
    
    func decreaseProductQty(_ cell: HR_MyCartTVC) {
        guard let tappedIndexPath = self.myCartTableView.indexPath(for: cell) else{return}
        print(tappedIndexPath.row)
        print(cell.addBTN.tag)
        //print(VM.myCartListArray[tappedIndexPath.row].noOfQuantity ?? 0,"kdhjhdi")
        if VM.myCartListArray.count != 0 {
        if cell.minusBTN.tag == tappedIndexPath.row{
                if self.VM.myCartListArray[tappedIndexPath.row].noOfQuantity ?? 0 >= 1{
                    print(self.VM.myCartListArray[tappedIndexPath.row].noOfQuantity ?? 0, "Tapped Index - Decrease")
                    if cell.minusBTN.tag == tappedIndexPath.row{
                        if Int(self.VM.myCartListArray[tappedIndexPath.row].sumOfTotalPointsRequired ?? 0) <= Int(self.redeemablePointsBalance) ?? 0{
                            let calcValue = Int(self.VM.myCartListArray[tappedIndexPath.row].sumOfTotalPointsRequired ?? 0) - Int(self.VM.myCartListArray[tappedIndexPath.row].pointsPerUnit ?? 0)
                            print(calcValue, "reduceValues")
                            if calcValue <= Int(self.redeemablePointsBalance) ?? 0 {
                                if calcValue != 0  && calcValue >= Int(self.VM.myCartListArray[tappedIndexPath.row].pointsPerUnit ?? 0){
                                    //self.quantity -= 1
                                    let totalQuantity = Int(self.VM.myCartListArray[tappedIndexPath.row].noOfQuantity ?? 0) - 1
                                    self.customerCartId = self.VM.myCartListArray[tappedIndexPath.row].customerCartId ?? 0
                                    self.quantity = totalQuantity
                                    if self.quantity >= 1 {
                                        cell.qtyLbl.text = "\(self.quantity)"
                                        self.VM.increaseProductApi()
                                    }else{
                                        self.quantity = 1
                                    }
                                    
                                    
                                }
                                
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
                }
            }
        }
        
 
            self.myCartTableView.reloadData()
    }
    
    func removeProductsList(_ cell: HR_MyCartTVC){
        guard let tappedIndexPath = self.myCartTableView.indexPath(for: cell) else{return}
//        if cell.removeProductsBTN.tag == tappedIndexPath.row{
        if self.VM.myCartListArray.count > 0{
            self.customerCartId = self.VM.myCartListArray[tappedIndexPath.row].customerCartId ?? 0
            self.VM.removeProduct()
            self.myCartTableView.reloadData()
        }
            
//        }
      
    }
    

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var screenTitleLbl: UILabel!
    @IBOutlet weak var myCartTableView: UITableView!
    @IBOutlet weak var checkoutLbl: UILabel!
    @IBOutlet weak var checkout: GradientButton!
    @IBOutlet weak var checkoutView: UIView!
    @IBOutlet weak var checkoutViewHeight: NSLayoutConstraint!
    @IBOutlet weak var totalPoints: UILabel!
    @IBOutlet weak var requiredPts: UILabel!
    @IBOutlet weak var noDataFound: UILabel!
    @IBOutlet weak var checkOutBtn: GradientView!
    var VM = HR_MyCartVM()
    var customerCartId = 0
    var quantity = 1
    var productValue = ""
    var finalPoints = 0
    var status = 0
    var redeemablePointsBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if UserDefaults.standard.string(forKey: "CustomerType") ?? "" == "1"{
//            self.headerView.backgroundColor = #colorLiteral(red: 0.7437494397, green: 0.08922102302, blue: 0.1178346947, alpha: 1)
//            self.checkOutBtn.backgroundColor = #colorLiteral(red: 0.7437494397, green: 0.08922102302, blue: 0.1178346947, alpha: 1)
//        }else{
            self.headerView.backgroundColor  = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
            self.checkOutBtn.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
        //}
        self.VM.VC = self
        self.myCartTableView.delegate = self
        self.myCartTableView.dataSource = self
        self.noDataFound.isHidden = true
        myCartTableView.register(UINib(nibName: "HR_MyCartTVC", bundle: nil), forCellReuseIdentifier: "HR_MyCartTVC")
        self.screenTitleLbl.text = "My Cart".localiz()
        self.noDataFound.text = "No Data Found".localiz()
        self.requiredPts.text = "REQUIRED EUROS".localiz()
        self.checkoutLbl.text = "Checkout".localiz()
       
   
    }
    override func viewWillAppear(_ animated: Bool) {
     
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "No Internet".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            self.VM.getMycartList()
        }
    }
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func checkoutBTN(_ sender: Any) {
        if UserDefaults.standard.string(forKey: "verificationStatus") == "1"{
        print(self.VM.sumOfProductsCount)
        print(self.redeemablePointsBalance, "Total Redeemable Point Balance")
        if self.VM.sumOfProductsCount <= Int(self.redeemablePointsBalance) ?? 0{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DefaultAddressVC") as! EBC_DefaultAddressVC
            vc.totalPoint = Int(self.VM.sumOfProductsCount)
            self.navigationController?.pushViewController(vc, animated: true)
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
        }}
}
extension HR_MyCartVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if self.VM.myCartListArray.count > 0{
            return  self.VM.myCartListArray.count
         }else{
             return 0
         }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HR_MyCartTVC", for: indexPath) as! HR_MyCartTVC
        cell.delegate = self
        cell.selectionStyle = .none
        cell.categoryName.text = "Category1".localiz() +  "\(self.VM.myCartListArray[indexPath.row].categoryName ?? "")"
        cell.productName.text = self.VM.myCartListArray[indexPath.row].productName ?? ""
        cell.productPoints.text = "\(self.VM.myCartListArray[indexPath.row].pointsRequired ?? 0)"
        let imageURL = self.VM.myCartListArray[indexPath.row].productImage ?? ""
        let urltoUse = String(productCatalogueImgURL + imageURL).replacingOccurrences(of: " ", with: "%20")
        let urlt = URL(string: "\(urltoUse)")
        cell.productImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
        if self.VM.myCartListArray[indexPath.row].noOfQuantity ?? 0 != 0 {
            cell.qtyLbl.text = "\(self.VM.myCartListArray[indexPath.row].noOfQuantity ?? 0)"
        }else{
//            cell.qtyLbl.text = "\(self.quantity)"
        }
        cell.addBTN.tag = indexPath.row
        cell.minusBTN.tag = indexPath.row
        cell.removeProductsBTN.tag = indexPath.row
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}

