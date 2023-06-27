//
//  DreamGiftDetailsViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//
import UIKit
import SDWebImage
import Firebase
import Toast_Swift
import LanguageManager_iOS
class DreamGiftDetailsViewController: BaseViewController, popUpDelegate, popUpDelegate1 {
    func popupAlertDidTap1(_ vc: PopupAlertOne_VC) {}
    
    func popupAlertDidTap(_ vc: EBC_SuccessMessageVC) {}
    
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    

    @IBOutlet weak var tdspopints: UILabel!
    @IBOutlet var dreamGiftMessage: UILabel!
    @IBOutlet var dreamGiftImage: UIImageView!
    @IBOutlet var dreamGiftName: UILabel!
    @IBOutlet var createdDate: UILabel!
    @IBOutlet var desiredDate: UILabel!
    @IBOutlet var pointsRequired: UILabel!
    @IBOutlet var redeemablePointsAsOnToday: UILabel!
    @IBOutlet var possibleDate1: UILabel!
    @IBOutlet var possibleDate2: UILabel!
    @IBOutlet var possibledate3: UILabel!
    @IBOutlet var avgPoints1: UILabel!
    @IBOutlet var avgPoints2: UILabel!
    @IBOutlet var avgPoints3: UILabel!
    @IBOutlet weak var dreamGiftType: UILabel!
    @IBOutlet weak var redeemBTN: UIButton!
    @IBOutlet weak var messageView: GradientView!
    @IBOutlet weak var giftDetailsView: UIView!
    @IBOutlet weak var avgPointsTitleLbl: UILabel!
    @IBOutlet weak var expectedRedemption: UILabel!
    
    @IBOutlet weak var tdsPts: UILabel!
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var existingDate: UILabel!
    @IBOutlet weak var expireDate: UILabel!
    @IBOutlet weak var ptsRequired: UILabel!
    @IBOutlet weak var removeBTN: UIButton!
    
    @IBOutlet weak var noOutBtn: GradientButton!
    
    @IBOutlet weak var yesOutBtn: GradientButton!
    
    @IBOutlet weak var yesNoView: UIView!
    
    @IBOutlet weak var removeDreamGiftLbl: UILabel!
    
    
    var giftType = ""
    var giftImage = ""
    var giftName = ""
    var addedDate = ""
    var tdsvalue = 0.0
    var expiredDate = ""
    var pointsRequires = ""
    var pointsBalance = 0
    var avgEarningPoints = ""
    var selectedDreamGiftId = ""
    var dreamGiftRedemptionId = 0
    var selectedGiftStatusID = 0
    var isRedeemable = 0
    var totalPts = 0
    var contractorName = ""
    var VM = DreamGiftDetailsViewModel()
    let verifiedStatus = UserDefaults.standard.integer(forKey: "verificationStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    var isRedeemableStatus = UserDefaults.standard.integer(forKey: "DreamGiftIsRedeemable")
    override func viewDidLoad() {
        super.viewDidLoad()
        giftDetailsAPi()
        languagelocalization()
        print(isRedeemable,"redeemPoints")
        self.dreamGiftType.roundCorners(corners: [.topLeft, .bottomRight], radius: 20)
        self.avgPointsTitleLbl.roundCorners(corners: .topLeft, radius: 8)
        self.expectedRedemption.roundCorners(corners: .bottomLeft, radius: 8)
        self.avgPoints3.roundCorners(corners: .topRight, radius: 8)
        self.possibledate3.roundCorners(corners: .bottomRight, radius: 8)
        self.dreamGiftType.text = giftType
        self.dreamGiftName.text = giftName
        self.createdDate.text = addedDate
        self.desiredDate.text = expiredDate
        self.tdspopints.text = "\(tdsvalue)"
        self.pointsRequired.text = pointsRequires
        print(selectedDreamGiftId, "Dream Gift ID")
        NotificationCenter.default.addObserver(self, selector: #selector(removeGiftDetails), name: Notification.Name.removeDreamGiftDetails, object: nil)
        let receivedImage = giftImage
              print(receivedImage)
              let totalImgURL = productCatalogueImgURL + receivedImage
        dreamGiftImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "ic_default_img"))

        if Int(pointsRequires) ?? 0 <= Int(self.redeemablePointBal){
            print(pointsRequired ?? 0,"pointsRequired")
            print(pointsBalance,"PointBalance")
            print(tdsvalue,"TDs")
            self.dreamGiftMessage.text = "Congratulations! you are eligible to win this existing Dream Gift".localiz()
            self.redeemBTN.isEnabled = true
            self.redeemBTN.backgroundColor = UIColor(red: 189/255, green: 0/255, blue: 0/255, alpha: 1.0)
        }else{
            self.dreamGiftMessage.text = "Congratulations! You are almost near to win this existing Dream Gift".localiz()
            self.redeemBTN.isEnabled = false
            redeemBTN.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1.0)
        }
        self.yesOutBtn.addTarget(self, action: #selector(yesBtnClicked), for: .touchUpInside)
        self.noOutBtn.addTarget(self, action: #selector(noBtnClicked), for: .touchUpInside)

    }
    @objc func removeGiftDetails(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func yesBtnClicked(){
        DispatchQueue.main.async {
            self.removeDreamGift()
        }
        self.yesNoView.isHidden = true
    }
    @objc func noBtnClicked(){
        self.yesNoView.isHidden = true
    }
    func languagelocalization(){
        self.removeDreamGiftLbl.text = "Do_U_Want_To_Remove".localiz()
            self.redeemablePointsAsOnToday.text = "Redeemable points as on today".localiz() + "\(pointsBalance)"
            self.header.text = "Dream Gift Details".localiz()
            self.existingDate.text = "Created Date".localiz()
            self.expireDate.text = "Desired Date".localiz()
            self.ptsRequired.text = "Points Required".localiz()
            self.avgPointsTitleLbl.text = "Average points to be earned per month".localiz()
            self.expectedRedemption.text = "Expected Redemption".localiz()
            self.redeemBTN.setTitle("Redeem Now".localiz(), for: .normal)
            self.removeBTN.setTitle("Remove".localiz(), for: .normal)
            self.tdsPts.text = "TDS points".localiz()
            
        
    }
    
    func giftDetailsAPi(){
        
        
        let parameters = [
            "ActionType": "243",
            "ActorId": "\(self.userId)",
            "DreamGiftId": "\(selectedDreamGiftId)",
            "LoyaltyId": "\(self.loyaltyId)"
        ] as [String: Any]
        print(parameters)
        self.VM.myDreamGiftDetails(parameters: parameters) { response in
            print(response?.lstDreamGift?[0].earlyExpectedDate ?? "")
        
            self.avgPoints1.text = "\(response?.lstDreamGift?[0].avgEarningPoints ?? 0)"
            self.avgPoints2.text = "\(response?.lstDreamGift?[0].earlyExpectedPoints ?? 0)"
            self.avgPoints3.text = "\(response?.lstDreamGift?[0].lateExpectedPoints ?? 0)"
            self.possibleDate1.text = "\(response?.lstDreamGift?[0].lateExpectedDate ?? "")"
            self.possibleDate2.text = "\(response?.lstDreamGift?[0].earlyExpectedDate ?? "")"
            self.possibledate3.text = "\(response?.lstDreamGift?[0].lateExpectedDate ?? "")"
            
        }
    }
    
    @IBAction func redeemNowButton(_ sender: Any) {
        if self.verifiedStatus == 6 || self.verifiedStatus == 4{
                NotificationCenter.default.post(name: .verificationStatus, object: nil)
            
        }else if self.verifiedStatus == 1{
//            if UserDefaults.standard.integer(forKey: "DreamGiftIsRedeemable") == -3{
//                self.view.makeToast("Your PAN Details are pending,Please contact your administrator!", duration: 2.0, position: .bottom)
//            }else if UserDefaults.standard.integer(forKey: "DreamGiftIsRedeemable") == -4{
//                self.view.makeToast("Your PAN Details are rejected,Please contact your administrator!", duration: 2.0, position: .bottom)
//            }else if UserDefaults.standard.integer(forKey: "DreamGiftIsRedeemable") == 1{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DefaultAddressVC") as! EBC_DefaultAddressVC
                vc.redemptionTypeId = 3
                //vc.totalPoints = Int(pointsRequires) ?? 0
                vc.totalPoint = ((Int(pointsRequires) ?? 0) + Int(self.tdsvalue))
                vc.dreamGiftID = Int(selectedDreamGiftId) ?? 0
                vc.giftName = giftName
                vc.contractorName = contractorName
                vc.giftStatusId = selectedGiftStatusID
                self.navigationController?.pushViewController(vc, animated: true)
//            }else{
//                self.view.makeToast("Insufficient point balance to redeem!", duration: 2.0, position: .bottom)
//            }
  
        }
        
       
    }
    
    @IBAction func removeButton(_ sender: Any) {
        self.yesNoView.isHidden = false
        
//        let alertVC = UIAlertController(title: "Are your sure".localiz(), message: "Do_U_Want_To_Remove".localiz(), preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Yes".localiz(), style: UIAlertAction.Style.default) {
//            UIAlertAction in
//            DispatchQueue.main.async {
//                self.removeDreamGift()
//            }
//        }
//        let cancelAction = UIAlertAction(title: "No".localiz(), style: UIAlertAction.Style.cancel) {
//            UIAlertAction in
//        }
//        alertVC.addAction(okAction)
//        alertVC.addAction(cancelAction)
//        self.present(alertVC, animated: true, completion: nil)
        
        
    }
    
    func removeDreamGift(){
        let parameters = [
                "ActionType": 4,
                "ActorId": "\(userId)",
                "DreamGiftId": "\(selectedDreamGiftId)",
                "GiftStatusId": 4
        ] as [String: Any]
        print(parameters)
        self.VM.removeDreamGift(parameters: parameters) { response in
            let result = response?.returnValue ?? 0
            print(result)
            if result == 1 {
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.itsComeFrom = "DreamGiftDetails"
                    vc!.descriptionInfo = "Dream Gift has been removed successfully".localiz()
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
                
            }else{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.itsComeFrom = "DreamGiftDetails"
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Dream Gift has been removed failed".localiz()
//                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                         vc!.descriptionInfo = "ड्रीम गिफ्ट को हटा दिया गया है विफल"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                        vc!.descriptionInfo = "ড্রিম গিফট ব্যর্থ হয়েছে"
//                    }else{
//                        vc!.descriptionInfo = "Dream Gift has been removed failed"
//                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }
        }
    }
    
  
    
    
    
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
