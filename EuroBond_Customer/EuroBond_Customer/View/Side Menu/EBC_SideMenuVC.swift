//
//  EBC_SideMenuVC.swift
//  EuroBond_Customer
//
//  Created by syed on 20/03/23.
//

import UIKit
import SlideMenuControllerSwift
import Kingfisher
import LanguageManager_iOS
import CoreData


class EBC_SideMenuVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, popUpAlertDelegate, popUpDelegate1 {
    func popupAlertDidTap1(_ vc: PopupAlertOne_VC) {}
    
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    

    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var logoutLbl: UILabel!
    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
    @IBOutlet weak var earnedEurosLbl: UILabel!
    @IBOutlet weak var pointBalLbl: UILabel!
    @IBOutlet weak var memberSinceLbl: UILabel!
    @IBOutlet weak var memberShipIDLbl: UILabel!
    @IBOutlet weak var membershipIdTitleLbl: UILabel!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var sideMenuTV: UITableView!

    @IBOutlet var deleteOutLbl: UILabel!
    @IBOutlet var myAccountOutLbl: UILabel!
    
    var requestAPIs = RestAPI_Requests()
    var parameters: JSON?
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var uploadedCodes:Array = [UploadedCodes]()
    
    var sideMenuArrayList: [sideMenuModel] = [
        
        sideMenuModel(sideMenuName: "Home".localiz(), sideMenuImage: "home"),
        sideMenuModel(sideMenuName: "Scan QR Code".localiz(), sideMenuImage: "qr"),
        sideMenuModel(sideMenuName: "Enter QR Code".localiz(), sideMenuImage: "upload1"),
        sideMenuModel(sideMenuName: "Code Status".localiz(), sideMenuImage: "Group 7691"),
        sideMenuModel(sideMenuName: "My Earning".localiz(), sideMenuImage: "bxs-coin-stack 1"),
        sideMenuModel(sideMenuName: "My Redemptions".localiz(), sideMenuImage: "reademailalt 1"),
        sideMenuModel(sideMenuName: "Redemption Catalogue".localiz(), sideMenuImage: "card-giftcard 1"),
        sideMenuModel(sideMenuName: "Game Zone".localiz(), sideMenuImage: "Group 6479"),
        sideMenuModel(sideMenuName: "Refer & Earn".localiz(), sideMenuImage: "Layer 3"),
        sideMenuModel(sideMenuName: "Add My Assistant".localiz(), sideMenuImage: "Construction_Worker"),
        sideMenuModel(sideMenuName: "Wishlist".localiz(), sideMenuImage: "wishlist"),
        sideMenuModel(sideMenuName: "Dream Gift".localiz(), sideMenuImage: "gift (4)"),
        sideMenuModel(sideMenuName: "Schemes & Offers".localiz(), sideMenuImage: "bxs-offer 1"),
        sideMenuModel(sideMenuName: "Milestone Bonus".localiz(), sideMenuImage: "performance"),
        sideMenuModel(sideMenuName: "Helpline".localiz(), sideMenuImage: "headset 1"),
        sideMenuModel(sideMenuName: "About".localiz(), sideMenuImage: "document (1)"),
        sideMenuModel(sideMenuName: "FAQ".localiz(), sideMenuImage: "document (1)"),
        sideMenuModel(sideMenuName: "Term and Conditions".localiz(), sideMenuImage: "document (1)")
        
        
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuTV.delegate = self
        sideMenuTV.dataSource = self
        heightOfTableView.constant = CGFloat(50*sideMenuArrayList.count)
        logoutView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        NotificationCenter.default.addObserver(self, selector: #selector(deletedAccount), name: Notification.Name.deleteAccount, object: nil)
        loaclizSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(closingSideMenu), name: Notification.Name.sideMenuClosing, object: nil)
        self.profileNameLbl.text = "\(UserDefaults.standard.string(forKey: "FirstName") ?? "")"
        self.memberShipIDLbl.text = "\(UserDefaults.standard.string(forKey: "LoyaltyId") ?? "")"
        self.pointBalLbl.text = "\(UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? "")"
        self.memberSinceLbl.text = "Member Since \(UserDefaults.standard.string(forKey: "MemberSince") ?? "")"
        let imageurl = "\(UserDefaults.standard.string(forKey: "customerImage") ?? "")".dropFirst(1)
        let imageData = imageurl.split(separator: "~")
        if imageData.count >= 2 {
            print(imageData[1],"jdsnjkdn")
            let totalImgURL = PROMO_IMG1 + (imageData[1])
            print(totalImgURL, "Total Image URL")
            self.profileImage.kf.setImage(with: URL(string: totalImgURL),placeholder: UIImage(named: "ic_default_img"))
        }else{
            let totalImgURL = PROMO_IMG1 + imageurl
            print(totalImgURL, "Total Image URL")
            self.profileImage.kf.setImage(with: URL(string: totalImgURL),placeholder: UIImage(named: "ic_default_img"))
                                }
    }
    
    
    @objc func deletedAccount(){
        UserDefaults.standard.setValue(false, forKey: "IsloggedIn?")
        self.clearTable()
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        if #available(iOS 13.0, *) {
            let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
            sceneDelegate?.setInitialViewAsRootViewController()

        } else {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.setInitialViewAsRootViewController()
        }
    }
    
    func loaclizSetup(){
        self.membershipIdTitleLbl.text = "Membership ID".localiz()
        self.logoutLbl.text = "Logout".localiz()
        self.deleteOutLbl.text = "Delete".localiz()
        self.earnedEurosLbl.text = "Earned Euros".localiz()
        self.myAccountOutLbl.text = "My Account".localiz()
    }
    
    
    @IBAction func selectMyAccountBtn(_ sender: UIButton) {
       
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyProfileandBankDetailsVC") as? MyProfileandBankDetailsVC
            navigationController?.pushViewController(vc!, animated: true)
    }
 
    
    @IBAction func selectDeleteBtn(_ sender: UIButton) {
        
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                    self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
                }
            }else{
                let alert = UIAlertController(title: "", message: "SureWantToDelete".localiz(), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Yes".localiz(), style: .default, handler: { UIAlertAction in
                    self.parameters = [
                        "ActionType": 1,
                        "userid":"\(self.userID)"
                    ] as [String : Any]
                    print(self.parameters!)
                    self.deleteAccountAPI(paramters: self.parameters!)
                }))
                alert.addAction(UIAlertAction(title: "no".localiz(), style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
    }
    
    func clearTable(){
        
        let context = persistanceservice.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ScanCodeSTORE")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    func clearTable1(){
            
            let context = persistanceservice.persistentContainer.viewContext
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UploadedCodes")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print ("There was an error")
            }
        }
    
    
    func clearTable2(){
            
            let context = persistanceservice.persistentContainer.viewContext
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SendUploadedCodes")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print ("There was an error")
            }
        }
    
    @IBAction func selectLogoutBtn(_ sender: UIButton) {
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
            UserDefaults.standard.set(-1, forKey: "IsloggedIn?")
            clearTable()
            clearTable1()
            clearTable2()
            DispatchQueue.main.async {
                if #available(iOS 13.0, *) {
                    DispatchQueue.main.async {
                        let domain = Bundle.main.bundleIdentifier!
                        UserDefaults.standard.removePersistentDomain(forName: domain)
                        UserDefaults.standard.synchronize()
                        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                        sceneDelegate.setInitialLoginVC()
                    }
                } else {
                    DispatchQueue.main.async {
                        let domain = Bundle.main.bundleIdentifier!
                        UserDefaults.standard.removePersistentDomain(forName: domain)
                        UserDefaults.standard.synchronize()
                        if #available(iOS 13.0, *) {
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.setInitialLoginVC()
                        }
                    }
                }
            }
        }
    }
    //["ActionType": 1, "userid": "1377"]
    
    func deleteAccountAPI(paramters: JSON){
        self.requestAPIs.deleteAccount(parameters: paramters) { (result, error) in
            if error == nil{
                if result != nil{
                DispatchQueue.main.async {
                    if result?.returnMessage ?? "-1" == "1"{
                        DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.itsComeFrom = "AccounthasbeenDeleted"
                                vc!.descriptionInfo = "AccDeleted".localiz()
                                vc!.modalPresentationStyle = .overCurrentContext
                                vc!.modalTransitionStyle = .crossDissolve
                                self.present(vc!, animated: true, completion: nil)
                            
                            }
                    }else{
                        DispatchQueue.main.async{
                            self.view.makeToast("SomethingWrong".localiz(), duration: 2.0,position: .bottom)
                            }
                    }
                  self.stopLoading()
                    }
                }else{
                    DispatchQueue.main.async {
                    self.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                self.stopLoading()
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuArrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_SideMenuTVC", for: indexPath) as! EBC_SideMenuTVC
        cell.selectionStyle = .none
        cell.sideMenuName.text = sideMenuArrayList[indexPath.row].sideMenuName
        cell.sideMenuImage.image = UIImage(named: sideMenuArrayList[indexPath.row].sideMenuImage)
        if sideMenuArrayList[indexPath.row].sideMenuName == "Game Zone".localiz(){
            cell.sideMenuBadges.isHidden = true
            cell.sideMenuBadges.text = "3"
        }else{
            cell.sideMenuBadges.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sideMenuArrayList[indexPath.row].sideMenuName{
        case "Home".localiz():
                closeLeft()
        case "Scan QR Code".localiz():
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanOrUpload_VC") as? ScanOrUpload_VC
            vc?.fromSideMenu = "SideMenu"
            vc?.itsFrom = "ScanCode"
            navigationController?.pushViewController(vc!, animated: true)
        case "Enter QR Code".localiz():
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanOrUpload_VC") as? ScanOrUpload_VC
            vc?.fromSideMenu = "SideMenu"
//            vc?.scanner = "Upload"
            navigationController?.pushViewController(vc!, animated: true)
        case "Code Status".localiz():
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CodeStatusListVC") as? CodeStatusListVC
//            vc?.fromSideMenu = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "My Earning".localiz():
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_MyEarningsVC") as? EBC_MyEarningsVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "My Redemptions".localiz():
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_MyRedemptionVC") as? EBC_MyRedemptionVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "Redemption Catalogue".localiz():
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RedeemNowVC") as? EBC_RedeemNowVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "Game Zone".localiz():
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_ComingSoonVC") as? EBC_ComingSoonVC
//            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "Refer & Earn".localiz():
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RefferAndEarnVC") as? EBC_RefferAndEarnVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "Add My Assistant".localiz():
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_MyAssistantVC") as? EBC_MyAssistantVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "Wishlist".localiz():
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_RedemptionPlannerVC") as? HR_RedemptionPlannerVC
//            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "Dream Gift".localiz():
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DreamGiftListingViewController") as? DreamGiftListingViewController
            navigationController?.pushViewController(vc!, animated: true)
        case "Schemes & Offers".localiz():
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_SchemesAndOffersVC") as? EBC_SchemesAndOffersVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "Milestone Bonus".localiz():
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_MillstonesBonussVC") as? EBC_MillstonesBonussVC
            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "Helpline".localiz():
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_HelpLineVC") as? EBC_HelpLineVC
//            vc?.flags = "SideMenu"
            navigationController?.pushViewController(vc!, animated: true)
        case "About".localiz():
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_AboutVC") as? EBC_AboutVC
            navigationController?.pushViewController(vc!, animated: true)
        case "FAQ".localiz():
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_FAQVC") as? EBC_FAQVC
            navigationController?.pushViewController(vc!, animated: true)
        case "Term and Conditions".localiz():
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_TermsAndConditionsVC") as? EBC_TermsAndConditionsVC
            navigationController?.pushViewController(vc!, animated: true)
        default:
            print("no data match")
        }
    }
    
    
    @objc func closingSideMenu(){
        self.closeLeft()

    }

}


struct sideMenuModel{
    let sideMenuName: String
    let sideMenuImage: String
}
