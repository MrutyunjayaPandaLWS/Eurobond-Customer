import UIKit
import Lottie
import SDWebImage
import Alamofire
//import Firebase
import Toast_Swift
import LanguageManager_iOS
class DreamGiftListingViewController: BaseViewController, AddOrRemoveGiftDelegate, popUpDelegate, popUpDelegate1{
    func popupAlertDidTap1(_ vc: PopupAlertOne_VC) { }
    
    func popupAlertDidTap(_ vc: EBC_SuccessMessageVC) {}
    

    
    @IBOutlet weak var animationLottieView: LottieAnimationView!
    @IBOutlet weak var dreamGifttableView: UITableView!
    @IBOutlet weak var noDataFound: UILabel!
    @IBOutlet weak var header: UILabel!
    
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var selectedDreamGiftId = ""
    var selectedGiftStatusID = 0
    var dreamGiftRedemptionId = 0
    var fromSideMenu = ""
    let verifiedStatus = UserDefaults.standard.integer(forKey: "verificationStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    var VM = DreamGiftListingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // playAnimation()
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
            }
        }else{
            self.VM.VC = self
            self.dreamGifttableView.register(UINib(nibName: "DreamGiftTableViewCell", bundle: nil), forCellReuseIdentifier: "DreamGiftTableViewCell")
            self.dreamGifttableView.delegate = self
            self.dreamGifttableView.dataSource = self
            self.dreamGifttableView.separatorStyle = .none
            NotificationCenter.default.addObserver(self, selector: #selector(afterRemovedProducts), name: Notification.Name.dreamGiftRemoved, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(giftAddedIntoCart), name: Notification.Name.giftAddedIntoCart, object: nil)
            //        var vc = self.storyboard?.instantiateViewController(withIdentifier: "TaxRelatedPopupViewController") as! TaxRelatedPopupViewController
            //        vc.modalPresentationStyle = .overCurrentContext
            //        vc.modalTransitionStyle = .crossDissolve
            //        self.present(vc, animated: true, completion: nil)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        languagelocalization()
        dreamGiftListApi()
        
    }
    
    func languagelocalization(){
        self.header.text = "Dream Gift".localiz()
    }
    
    @objc func afterRemovedProducts(){
        dreamGiftListApi ()
        self.dreamGifttableView.reloadData()
    }
    @objc func giftAddedIntoCart(){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DefaultAddressVC") as! EBC_DefaultAddressVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    

    //Delegate:-
    
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    func redeemGift(_ cell: DreamGiftTableViewCell) {
        
        guard let tappedIndexPath = dreamGifttableView.indexPath(for: cell) else {return}
        if cell.redeemButton.tag == tappedIndexPath.row{
            if self.verifiedStatus == 6 || self.verifiedStatus == 4{
                if self.checkAccountStatus == "1"{
                    NotificationCenter.default.post(name: .verificationStatus, object: nil)
                }else{
                    NotificationCenter.default.post(name: .verificationStatus, object: nil)
                }
                
            }else if self.verifiedStatus == 1{
                print(UserDefaults.standard.integer(forKey: "DreamGiftIsRedeemable"))
//                if UserDefaults.standard.integer(forKey: "DreamGiftIsRedeemable") == -3{
//                    self.view.makeToast("Your PAN Details are pending,Please contact your administrator!", duration: 2.0, position: .bottom)
//                }else if UserDefaults.standard.integer(forKey: "DreamGiftIsRedeemable") == -4{
//                    self.view.makeToast("Your PAN Details are rejected,Please contact your administrator!", duration: 2.0, position: .bottom)
//                }else if UserDefaults.standard.integer(forKey: "DreamGiftIsRedeemable") == 1{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DefaultAddressVC") as! EBC_DefaultAddressVC
                    vc.redemptionTypeId = 3
                    vc.totalPoint = self.VM.myDreamGiftListArray[tappedIndexPath.row].pointsRequired ?? 0
                    
                    vc.dreamGiftID = self.VM.myDreamGiftListArray[tappedIndexPath.row].dreamGiftId ?? 0
                    vc.giftName = self.VM.myDreamGiftListArray[tappedIndexPath.row].dreamGiftName ?? ""
                    vc.contractorName = self.VM.myDreamGiftListArray[tappedIndexPath.row].contractorName ?? ""
                    vc.giftStatusId = self.VM.myDreamGiftListArray[tappedIndexPath.row].giftStatusId ?? 0
                    
                    self.navigationController?.pushViewController(vc, animated: true)
//                }else{
//                    self.view.makeToast("Insufficient point balance to redeem!", duration: 2.0, position: .bottom)
//                }
              
            }else{
                self.view.makeToast("Insufficient point balance to redeem".localiz(), duration: 2.0, position: .bottom)
            }
           
        }
        
    }
    
    func removeGift(_ cell: DreamGiftTableViewCell) {
        guard let tappedIndexPath = dreamGifttableView.indexPath(for: cell) else {return}
        if cell.removeGiftBTN.tag == tappedIndexPath.row{
            self.selectedDreamGiftId = "\(self.VM.myDreamGiftListArray[tappedIndexPath.row].dreamGiftId ?? 0)"
            self.selectedGiftStatusID = self.VM.myDreamGiftListArray[tappedIndexPath.row].giftStatusId ?? 0
            self.removeDreamGift()
            self.dreamGifttableView.reloadData()
        }
    }
    
    //APi:-
    
    func dreamGiftListApi(){
        self.startLoading()
        self.VM.myDreamGiftListArray.removeAll()
        let parameters = [
            "ActionType": "1",
               "ActorId": "\(userID)",
               "LoyaltyId": "\(loyaltyId)",
                "Status": "2"
        ] as [String: Any]
        print(parameters)
        self.VM.myDreamGiftLists(parameters: parameters)
    }
    
    func removeDreamGift(){
        let parameters = [
                "ActionType": 4,
                "ActorId": "\(userID)",
                "DreamGiftId": "\(selectedDreamGiftId)",
                "GiftStatusId": 4
        ] as [String: Any]
        print(parameters)
        self.VM.removeDreamGift(parameters: parameters)
    }
    
 
}
extension DreamGiftListingViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myDreamGiftListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DreamGiftTableViewCell") as? DreamGiftTableViewCell
        cell?.delegate = self
        cell?.selectionStyle = .none
        
        cell?.giftName.text = self.VM.myDreamGiftListArray[indexPath.row].dreamGiftName ?? ""
        cell?.tdsvalue.text = "\(self.VM.myDreamGiftListArray[indexPath.row].tdsPoints ?? 0)"

        cell?.dreamGiftTitle.text = self.VM.myDreamGiftListArray[indexPath.row].giftType ?? ""
       
        let doB1 = String(self.VM.myDreamGiftListArray[indexPath.row].jCreatedDate ?? "")
        let index = doB1.firstIndex(of: " ") ?? doB1.endIndex
        let beginning = doB1[..<index]
        print(beginning)
        cell?.giftCreatedDate.text = "\(beginning)"

        let doB2 = String(self.VM.myDreamGiftListArray[indexPath.row].jDesiredDate ?? "")
        let index2 = doB2.firstIndex(of: " ") ?? doB2.endIndex
        let beginning2 = doB2[..<index]
        print(beginning)
        cell?.desiredDate.text = "\(beginning2)"
        
        cell?.pointsRequired.text = "\(self.VM.myDreamGiftListArray[indexPath.row].pointsRequired ?? 0)"
        let balance = Double(self.VM.myDreamGiftListArray[indexPath.row].pointsBalance ?? 0)
        let pointRequired = Double(self.VM.myDreamGiftListArray[indexPath.row].pointsRequired ?? 0)
        let tdsvalue = self.VM.myDreamGiftListArray[indexPath.row].tdsPoints ?? 0
        print(Int(pointRequired + Double(tdsvalue)),"data")
        print(balance,"Balance")
        let isRedeem = self.VM.myDreamGiftListArray[indexPath.row].is_Redeemable ?? 0
        
//        if isRedeem == 1{
//
//        }else{
//
//        }

        if Int(pointRequired) <= Int(self.redeemablePointBal){
            cell?.redeemButton.isEnabled = true
            cell?.redeemButton.backgroundColor = #colorLiteral(red: 0.04705882353, green: 0.4823529412, blue: 0.7450980392, alpha: 1)
        }else{
            cell?.redeemButton.isEnabled = false
            cell?.redeemButton.backgroundColor = #colorLiteral(red: 0.04705882353, green: 0.4823529412, blue: 0.7450980392, alpha: 0.5686187744)
        }
        
//        if self.VM.myDreamGiftListArray[indexPath.row].is_Redeemable ?? -2 != 1{
//            cell?.redeemButton.isEnabled = false
//            cell?.redeemButton.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1.0)
//        }else{
//            cell?.redeemButton.isEnabled = true
//            cell?.redeemButton.backgroundColor = UIColor(red: 189/255, green: 0/255, blue: 0/255, alpha: 1.0)
//            }
//
        
        cell?.redeemButton.tag = indexPath.row
        cell?.removeGiftBTN.tag = indexPath.row
        print(pointRequired,"pointsReq")
        if pointRequired < balance{
            let percentage = CGFloat(pointRequired/balance) * 100.0
            cell?.percentageValue.text = "100"
            cell?.progressView.progress = Float(percentage)
            cell?.progressPercentageLogoView.constant = CGFloat(((cell?.progressView.frame.width ?? 0) - 20) * percentage/100)
        }else{
          
            let percentage = CGFloat(balance/pointRequired)
            let final = CGFloat(percentage) * 100
            cell?.percentageValue.text = "\(Int(final))%"
            cell?.progressView.progress = Float(percentage / 100)
            cell?.progressPercentageLogoView.constant = CGFloat(((cell?.progressView.frame.width ?? 0) - 20) * percentage / 100)
        }
       
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DreamGiftDetailsViewController") as! DreamGiftDetailsViewController
        vc.giftName = self.VM.myDreamGiftListArray[indexPath.row].dreamGiftName ?? ""
        vc.tdsvalue = Double(self.VM.myDreamGiftListArray[indexPath.row].tdsPoints ?? 0)
        vc.giftType = self.VM.myDreamGiftListArray[indexPath.row].giftType ?? ""
        
        let doB1 = String(self.VM.myDreamGiftListArray[indexPath.row].jCreatedDate ?? "")
        let index = doB1.firstIndex(of: " ") ?? doB1.endIndex
        let beginning = doB1[..<index]
        print(beginning)
        vc.addedDate = "\(beginning)"
        
        let doB2 = String(self.VM.myDreamGiftListArray[indexPath.row].jDesiredDate ?? "")
        let index2 = doB2.firstIndex(of: " ") ?? doB2.endIndex
        let beginning2 = doB2[..<index]
        
        
//        let desiredDate = (self.VM.myDreamGiftListArray[indexPath.row].jDesiredDate ?? "").split(separator: " ")
//        let desiredDateFormat = convertDateFormater1(String(desiredDate[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
        vc.expiredDate = "\(beginning2)"
        vc.pointsRequires = "\(self.VM.myDreamGiftListArray[indexPath.row].pointsRequired ?? 0)"
        vc.avgEarningPoints = "\(self.VM.myDreamGiftListArray[indexPath.row].avgEarningPoints ?? 0)"
        vc.pointsBalance = self.VM.myDreamGiftListArray[indexPath.row].pointsBalance ?? 0
        vc.selectedDreamGiftId = "\(self.VM.myDreamGiftListArray[indexPath.row].dreamGiftId ?? 0)"
        vc.selectedGiftStatusID = self.VM.myDreamGiftListArray[indexPath.row].giftStatusId ?? 0
        vc.contractorName = self.VM.myDreamGiftListArray[indexPath.row].contractorName ?? ""
        vc.isRedeemable = self.VM.myDreamGiftListArray[indexPath.row].is_Redeemable ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
