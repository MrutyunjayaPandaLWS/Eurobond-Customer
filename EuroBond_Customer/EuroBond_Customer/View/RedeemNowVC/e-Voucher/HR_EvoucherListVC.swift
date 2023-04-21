//
//  HR_EvoucherListVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 3/5/22.
//

import UIKit
import SDWebImage
//import LanguageManager_iOS
import Lottie

class HR_EvoucherListVC: BaseViewController, popUpAlertDelegate, EvoucherProductDelegate, pointsDelegate{
    
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    func selectPointsDidTap(_ VC: HR_RedeemQuantity_VC) {
        self.selectedPoints = VC.selectedpoints
        self.productcodeselected = VC.productCodefromPrevious
        NotificationCenter.default.post(name: Notification.Name("SHOWDATA23"), object: self)
    }
    
    func redeemButton(_ cell: HR_EvoucherlistCVC) {
         print(cell.vouchersdata[0].min_points ?? "-1")
        if cell.vouchersdata[0].min_points ?? "-1" != "-1" || cell.vouchersdata[0].max_points ?? "-1" != "-1"{
            if cell.amountTF.text?.count == 0{
                self.alertmsg(alertmsg: "Enter amount to redeem", buttonalert: "OK")
            }else{
                let totalPts = UserDefaults.standard.string(forKey:"RedeemablePointBalance") ?? ""
                print(totalPts)
                let finalPts = Double(totalPts)
                print(finalPts)
                let totalPointss = Int(finalPts ?? 0.0)
                print(totalPointss)
                if totalPointss >= Int(cell.amountTF.text ?? "0")!{
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

                        DispatchQueue.main.async {
                            let alertVC = UIAlertController(title: "Are your sure", message: "Do you Want to Redeem", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "YES", style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                DispatchQueue.main.async {
                                    self.VM.voucherSubmission(ReceiverMobile: self.mobilenumber, ActorId: self.userID, CountryID: cell.vouchersdata[0].countryID ?? -1, MerchantId: self.merchantID, CatalogueId: cell.vouchersdata[0].catalogueId ?? -1, DeliveryType: cell.vouchersdata[0].deliveryType ?? "", pointsrequired: cell.amountTF.text ?? "0", ProductCode: cell.vouchersdata[0].productCode ?? "", ProductImage: cell.vouchersdata[0].productImage ?? "", ProductName: cell.vouchersdata[0].productName ?? "", NoOfQuantity: "1", VendorId: cell.vouchersdata[0].vendorId ?? -1, VendorName: cell.vouchersdata[0].vendorName ?? "", ReceiverEmail: self.emailid, ReceiverName: self.firstname)
                                }
                            }
                            let cancelAction = UIAlertAction(title: "NO", style: UIAlertAction.Style.cancel) {
                                UIAlertAction in
                                
                            }
                            alertVC.addAction(okAction)
                            alertVC.addAction(cancelAction)
                            self.present(alertVC, animated: true, completion: nil)
                            
                        }
                        
                         
                        
                    }
                }else{
                    self.alertmsg(alertmsg: "Insufficient Points Balance", buttonalert: "OK")
                }
            }
        }else{
            if cell.amountBTN.currentTitle == "Amount"{
                self.alertmsg(alertmsg: "Select Amount to Redeem", buttonalert: "OK")
            }else{
                if Int((UserDefaults.standard.string(forKey:"RedeemablePointBalance") ?? ""))! >= self.selectedPoints{
                    
                    DispatchQueue.main.async {
                        let alertVC = UIAlertController(title: "Areyoursure", message: "DoyouWanttoRedeem", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "YES", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            DispatchQueue.main.async {
                                self.VM.voucherSubmission(ReceiverMobile: self.mobilenumber, ActorId: self.userID, CountryID: cell.vouchersdata[0].countryID ?? -1, MerchantId: self.merchantID, CatalogueId: cell.vouchersdata[0].catalogueId ?? -1, DeliveryType: cell.vouchersdata[0].deliveryType ?? "", pointsrequired: cell.amountBTN.currentTitle!, ProductCode: cell.vouchersdata[0].productCode ?? "", ProductImage: cell.vouchersdata[0].productImage ?? "", ProductName: cell.vouchersdata[0].productName ?? "", NoOfQuantity: "1", VendorId: cell.vouchersdata[0].vendorId ?? -1, VendorName: cell.vouchersdata[0].vendorName ?? "", ReceiverEmail: self.emailid, ReceiverName: self.firstname)
                            }
                        }
                        let cancelAction = UIAlertAction(title: "NO", style: UIAlertAction.Style.cancel) {
                            UIAlertAction in
                            
                        }
                        alertVC.addAction(okAction)
                        alertVC.addAction(cancelAction)
                        self.present(alertVC, animated: true, completion: nil)
                        
                    }
                    
                   
                }else{
                    self.alertmsg(alertmsg: "Insufficient points balance", buttonalert: "OK")
                }
                }
        }
    }
    
    func amountField(_ cell: HR_EvoucherlistCVC) {
    
        DispatchQueue.main.async{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_RedeemQuantity_VC") as? HR_RedeemQuantity_VC
            vc!.productCodefromPrevious = cell.vouchersdata[0].productCode ?? ""
            vc!.delegate = self
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        }
        
    }
    
    func alertDidTap(_ cell: HR_EvoucherlistCVC) {
        self.alertmsg(alertmsg: "\(cell.alertMsg)", buttonalert: "OK")
    }
    
  
    
    @IBOutlet weak var evoucherListCollectionView: UICollectionView!
    @IBOutlet weak var noDataFound: UILabel!
    
    let VM = HR_EVoucherListVM()
    var selectedPoints = 0
    var productcodeselected = ""
    var redeemablePointsBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    var mobilenumber = UserDefaults.standard.string(forKey: "Mobile") ?? ""
    var emailid = UserDefaults.standard.string(forKey: "CustomerEmail") ?? ""
    var firstname = UserDefaults.standard.string(forKey: "FirstName") ?? ""
    var merchantID = UserDefaults.standard.integer(forKey: "MerchantID")
    let layaltyID = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.noDataFound.text = "No data found !!"
        self.noDataFound.isHidden = true
        evoucherListCollectionView.delegate = self
        evoucherListCollectionView.dataSource = self
        let collectionViewFLowLayout = UICollectionViewFlowLayout()
        collectionViewFLowLayout.itemSize = CGSize(width: CGFloat(((self.view.bounds.width - 26) - (self.evoucherListCollectionView.contentInset.left + self.evoucherListCollectionView.contentInset.right)) / 2), height: 225)
        collectionViewFLowLayout.minimumLineSpacing = 2.5
        collectionViewFLowLayout.minimumInteritemSpacing = 2.5
         self.evoucherListCollectionView.collectionViewLayout = collectionViewFLowLayout
       // self.playAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
            self.VM.evoucherList()
//            self.playAnimation()
        
            
        }
        NotificationCenter.default.addObserver(self, selector: #selector(handlepopupdateclose), name: Notification.Name.showPopUp, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(callSubmissionApi), name: Notification.Name.evoucherListApi, object: nil)
    }
    
    
    @objc func handlepopupdateclose() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
extension HR_EvoucherListVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.VM.evoucherListingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HR_EvoucherlistCVC", for: indexPath) as! HR_EvoucherlistCVC

        cell.delegate = self
        cell.vouchersdata.removeAll()
        cell.vouchersdata.append(self.VM.evoucherListingArray[indexPath.row])
        cell.productName.text = self.VM.evoucherListingArray[indexPath.row].productName ?? ""
        let urlt = URL(string: "\(self.VM.evoucherListingArray[indexPath.row].productImage ?? "")")
        print(urlt)
        cell.productImage.sd_setImage(with: urlt, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
        cell.productRange.text = "Range \(self.VM.evoucherListingArray[indexPath.row].min_points ?? "") - \(self.VM.evoucherListingArray[indexPath.row].max_points ?? "")"

        cell.redeemBTN.tag = indexPath.row
        if self.VM.evoucherListingArray[indexPath.row].min_points ?? "" == "" || self.VM.evoucherListingArray[indexPath.row].max_points ?? "" == ""{
            cell.productRange.text = "Select Amount Range"
            cell.amountBTN.tag = self.VM.evoucherListingArray[indexPath.row].catalogueId ?? 0
            cell.amountTF.isHidden = true
            cell.amountBTN.isHidden = false
        }else{
            cell.productRange.text = "INR \(self.VM.evoucherListingArray[indexPath.row].min_points ?? "") - INR \(self.VM.evoucherListingArray[indexPath.row].max_points ?? "")"
            cell.amountTF.isHidden = false
            cell.amountBTN.isHidden = true
        }
        cell.amountBTN.tag = indexPath.row

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_EvoucherProductDetailsVC") as! HR_EvoucherProductDetailsVC
        
        vc.voucherID = self.VM.evoucherListingArray[indexPath.row].catalogueId ?? -1
        vc.voucherName = self.VM.evoucherListingArray[indexPath.row].productName ?? ""
        vc.voucherTC = self.VM.evoucherListingArray[indexPath.row].termsCondition ?? ""
        vc.voucherDesc = self.VM.evoucherListingArray[indexPath.row].productDesc ?? ""
        vc.redeemoptions = self.VM.evoucherListingArray[indexPath.row].deliveryType ?? ""
        vc.voucherImag = self.VM.evoucherListingArray[indexPath.row].productImage ?? ""
        vc.voucherCode = self.VM.evoucherListingArray[indexPath.row].productCode ?? ""
        vc.voucherMinPoints = self.VM.evoucherListingArray[indexPath.row].min_points ?? "-1"
        vc.voucherMaxPoints = self.VM.evoucherListingArray[indexPath.row].max_points ?? "-1"
        vc.vouchercategory = self.VM.evoucherListingArray[indexPath.row].catogoryName ?? ""
        vc.vouchervendorname = self.VM.evoucherListingArray[indexPath.row].vendorName ?? ""
        vc.vouchervendorID = self.VM.evoucherListingArray[indexPath.row].vendorId ?? -1
        vc.voucherCountryID = self.VM.evoucherListingArray[indexPath.row].countryID ?? -1
        vc.voucherdelivarytype = self.VM.evoucherListingArray[indexPath.row].deliveryType ?? ""
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
  
    
}
