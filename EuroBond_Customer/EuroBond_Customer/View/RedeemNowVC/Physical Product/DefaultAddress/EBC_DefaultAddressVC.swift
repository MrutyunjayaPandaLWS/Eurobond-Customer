//
//  MSP_DefaultAddressVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 19/11/2022.
//

import UIKit
import Firebase
import Lottie
import LanguageManager_iOS
class EBC_DefaultAddressVC: BaseViewController, SendUpdatedAddressDelegate, popUpDelegate1, popUpAlertDelegate {
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    func popupAlertDidTap1(_ vc: PopupAlertOne_VC) {}
    
//    vc!.stateID = self.stateID
//    vc!.cityID = self.cityID
//    vc!.stateName = self.stateName
//    vc!.cityName = self.cityName
//    vc!.pincode = self.pincode
//    vc!.address1 = self.address1
//    vc!.customerName = self.customerNameLabel.text ?? ""
//    vc!.mobile = self.customerMobileNumber!
//    vc!.emailId = self.emailID
//    vc!.countryId = self.countryID
//    vc!.countryName = self.countryName
//    vc!.redeemedPoints = self.totalPoint
//    vc!.dreamGiftId = self.dreamGiftID
//    vc!.giftPts = self.totalPoint
//    vc!.giftName = self.giftName
//    vc!.contractorName = self.contractorName
//    vc!.giftStatusId = self.giftStatusId
//    vc!.redemptionTypeId = self.redemptionTypeId
    
    func updatedAddressDetails(_ vc: HR_EditAddressVC) {
        self.selectedname = vc.selectedname
        self.emailID = vc.selectedemail
        self.customerMobileNumber = vc.selectedmobile
        self.cityName = vc.selectedState
        self.stateID = vc.selectedStateID
        self.cityName = vc.selectedCity
        self.cityID = vc.selectedCityID
        self.address1 = vc.selectedaddress
        self.pincode = vc.selectedpincode
        self.countryID = 15
        self.countryName = "India"
      //  self.contractorName = vc.selectedname
        self.customerAddressTV.text = "\(selectedname),\n\(vc.selectedmobile),\n\(vc.selectedaddress),\n\(vc.selectedCity),\n\(vc.selectedState),\n\(self.selectedCountry),\n\(vc.selectedemail),\n\(vc.selectedpincode)"
        print(customerAddressTV.text,"sdjhbsd")
    }
    
    @IBOutlet var defaultAddresstitleLbl: UILabel!
    @IBOutlet var addressLbl: UILabel!
    @IBOutlet var customerNameLabel: UILabel!
    @IBOutlet var totalPoints: UILabel!
    @IBOutlet var proceedToCheckoutButton: GradientButton!
    @IBOutlet weak var customerAddressTV: UITextView!
    
    @IBOutlet weak var orderListTableView: UITableView!
    @IBOutlet weak var cartCountLbl: UILabel!
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var notificaitonCountLbl: UILabel!
    
    @IBOutlet var cartListingView: UIView!
    
    @IBOutlet var totalEurostilteLbl: UILabel!
    
    var VM = DefaultAddressModels()
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var loyaltyID = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var pointBalance = UserDefaults.standard.double(forKey: "OverAllPointBalance")
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    
    var selectedname = ""
    var selectedemail = ""
    var selectedmobile = ""
    var selectedState = ""
    var selectedStateID = -1
    var selectedCity = ""
    var selectedCityID = -1
    var selectedaddress = ""
    var selectedpincode = ""
    var selectedCountryId = -1
    var selectedCountry = ""
    var totalPoint = 0
//    var totalPoints = 0
    
    var dreamGiftID = 0
    var giftName = ""
    var contractorName = ""
    var giftStatusId = 0
    var redemptionTypeId = 0
    var isComingFrom = ""
    var receiverName = ""
    var address = ""
    var stateID = -1
    var stateName = ""
    var districtID = -1
    var districtName = ""
    var cityID = -1
    var cityName = ""
    var pincode = ""
    var emailID = ""
    var address1 = ""
    var countryID = -1
    var countryName = ""
    var redemptionDate = ""
    var mobile = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        //self.loaderView.isHidden = true
        self.orderListTableView.delegate = self
        self.orderListTableView.dataSource = self
        self.profileDetailsAPI()
        NotificationCenter.default.addObserver(self, selector: #selector(afterDismissed), name: Notification.Name.dismissCurrentVC, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToMain), name: Notification.Name.goToMain, object: nil)
        if isComingFrom == "DreemGift"{
            self.cartListingView.isHidden = true
            self.orderListTableView.isHidden = true
        }else{
            self.orderListTableView.isHidden = false
            self.cartListingView.isHidden = false
        }
        langLoc()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        print(self.dreamGiftID)
        print(self.totalPoint)
       // self.loaderView.isHidden = true
        if self.dreamGiftID != 0 {
            self.totalPoints.text = "\(Int(self.totalPoint))"
        }else{
            self.myCartListAPI()
        }
     
    }
    @objc func goToMain(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func afterDismissed(){
        self.profileDetailsAPI()
        
        if isComingFrom == "DreemGift"{
            self.cartListingView.isHidden = true
        }else{
            self.myCartListAPI()
        }
        
    }
    
    func langLoc(){
        addressLbl.text =  "Address".localiz()
        defaultAddresstitleLbl.text = "Default Address".localiz()
        totalEurostilteLbl.text = "Total Euros".localiz()
        proceedToCheckoutButton.setTitle("Confirm Order".localiz(), for: .normal)
        
    }
    
    
    @IBAction func editAddressBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_EditAddressVC") as! HR_EditAddressVC
        vc.delegate = self
        vc.selectedname = self.selectedname
        vc.selectedemail = self.emailID
        vc.selectedmobile = self.customerMobileNumber!
        vc.selectedState = self.stateName
        vc.selectedStateID = self.stateID
        vc.selectedCountry = self.countryName
        vc.selectedCountryId = self.countryID
        vc.selectedCity = self.cityName
        vc.selectedCityID = self.cityID
        vc.selectedaddress = self.address1
        vc.selectedpincode = self.pincode
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favoriteBtn(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_WishlistListingVC") as! MSP_WishlistListingVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func processBtn(_ sender: Any) {
        print(stateID)
          print(cityID)
          print(address1)
          print(pincode)

          if UserDefaults.standard.string(forKey: "verificationStatus") == "1"{
              if stateID == -1 || cityID == -1 || address1 == "" || pincode == "" || customerMobileNumber == ""{
                  DispatchQueue.main.async{
                      let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                      vc!.delegate = self
                      vc!.titleInfo = ""
                      vc!.descriptionInfo = "Shipping address requires: State,City,Address,Pin code and Mobile Number,details,Click on 'Edit' to edit and add details".localiz()
                      vc!.modalPresentationStyle = .overCurrentContext
                      vc!.modalTransitionStyle = .crossDissolve
                      self.present(vc!, animated: true, completion: nil)
                  }
              }else{
                  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_RedemptionOTP_VC") as? HR_RedemptionOTP_VC
                  vc!.stateID = self.stateID
                  vc!.cityID = self.cityID
                  vc!.stateName = self.stateName
                  vc!.cityName = self.cityName
                  vc!.pincode = self.pincode
                  vc!.address1 = self.address1
                  vc!.customerName = self.selectedname
                  vc!.mobile = self.customerMobileNumber!
                  vc!.emailId = self.emailID
                  vc!.countryId = self.countryID
                  vc!.countryName = self.countryName
                  vc!.redeemedPoints = self.totalPoint
                  
                  vc!.dreamGiftId = self.dreamGiftID
                  vc!.giftPts = self.totalPoint
                  vc!.giftName = self.giftName
                  vc!.contractorName = self.contractorName
                  vc!.giftStatusId = self.giftStatusId
                  vc!.redemptionTypeId = self.redemptionTypeId
               
                  self.navigationController?.pushViewController(vc!, animated: true)
              }
              
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
    
    @IBAction func cartBtn(_ sender: Any) {

    }
    @IBAction func notificationBtn(_ sender: Any) {

    }
    func profileDetailsAPI(){
        let parameterJSON = [
            "ActionType": "6",
            "CustomerId": "\(userID)"
        ] as [String: Any]
        print(parameterJSON)
        self.VM.defaultAddressAPi(parameters: parameterJSON)
    }
    
    
    func myCartListAPI(){
        let parameters = [
            "ActionType": "2",
            "LoyaltyID": "\(self.loyaltyId)"
        ] as [String: Any]
        print(parameters)
        self.VM.cartAddressAPI(parameters: parameters)
        
    }
    
//    func notificationListApi(){
//        let parameters = [
//            "ActionType": 0,
//            "ActorId": "\(userID)",
//            "LoyaltyId": self.loyaltyID
//        ] as [String: Any]
//        print(parameters)
//        self.VM1.notificationListApi(parameters: parameters) { response in
//            self.VM1.notificationListArray = response?.lstPushHistoryJson ?? []
//            print(self.VM1.notificationListArray.count)
//            if self.VM1.notificationListArray.count > 0{
//                self.notificaitonCountLbl.isHidden = true
//                self.notificaitonCountLbl.text = "\(self.VM1.notificationListArray.count)"
//            }else{
//                self.notificaitonCountLbl.isHidden = true
//            }
//        }
//    }
   
//    func verifyAdhaarExistencyApi(){
//
//        let parameter = [
//            "ActionType": 154,
//            "ActorId": self.userID
//        ] as [String: Any]
//        print(parameter)
//        self.VM.adhaarNumberExistsApi(parameters: parameter) { response in
//
//            let result = response?.lstAttributesDetails ?? []
//
//            if result.count != 0 {
//                let sortedValues = String(result[0].attributeValue ?? "").split(separator: ":")
//                print(sortedValues[0], "asdfsadfas")
//                if sortedValues[0] == "1"{
//                    if self.verifiedStatus != 1{
//                        DispatchQueue.main.async{
//                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                            vc!.delegate = self
//                            vc!.titleInfo = ""
//                            vc!.descriptionInfo = "You are not allowled to redeem .Please contact your administrator"
//                            vc!.modalPresentationStyle = .overCurrentContext
//                            vc!.modalTransitionStyle = .crossDissolve
//                            self.present(vc!, animated: true, completion: nil)
//                        }
//
//                    }
//
//                }else{
//                    DispatchQueue.main.async{
//                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                        vc!.delegate = self
//                        vc!.titleInfo = ""
//
//                        vc!.descriptionInfo = "\(sortedValues[1])"
//
//                        vc!.modalPresentationStyle = .overCurrentContext
//                        vc!.modalTransitionStyle = .crossDissolve
//                        self.present(vc!, animated: true, completion: nil)
//                        self.loaderView.isHidden = true
//                        self.stopLoading()
//                    }
//                }
//            }
//        }
//    }
}
extension EBC_DefaultAddressVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isComingFrom == "DreemGift"{
            return 0
        }else{
            return VM.myCartListArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrderTVC") as! MyOrderTVC
        cell.selectionStyle = .none
        cell.productName.text = VM.myCartListArray[indexPath.row].productName ?? "-"
        cell.catagoryName.text = VM.myCartListArray[indexPath.row].categoryName ?? "-"
        cell.pointsLabel.text = "\(Int(VM.myCartListArray[indexPath.row].pointsRequired ?? 0))"
        //cell.productImageView.image = VM.myCartListArray[indexPath.row].
        let receivedImage = self.VM.myCartListArray[indexPath.row].productImage ?? ""
        let totalImgURL = productCatalogueImgURL + receivedImage
        cell.productImageView.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "ic_default_img"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
