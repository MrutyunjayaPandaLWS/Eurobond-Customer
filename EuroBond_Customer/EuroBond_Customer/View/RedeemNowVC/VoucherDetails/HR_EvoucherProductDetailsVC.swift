//
//  HR_EvoucherProductDetailsVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 3/5/22.
//

import UIKit
import SDWebImage
//import LanguageManager_iOS

class HR_EvoucherProductDetailsVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, popUpAlertDelegate, pointsDelegate{
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    
    func selectPointsDidTap(_ VC: HR_RedeemQuantity_VC) {
        self.selectedPoints = VC.selectedpoints
        self.productcodeselected = VC.productCodefromPrevious
        self.selectAmountButton.setTitle(String(self.selectedPoints), for: .normal)
    }
    
    var myredemptionsVouchers = [myredemptionsVouchersModels]()
    @IBOutlet weak var myVouchersDetailsTableView: UITableView!
    @IBOutlet weak var headerlbl: UILabel!
    var selectedRowIndex = -1
    var voucherID = -1
    var amountselected = 0
    var redemptiondate = ""
    var voucherName = ""
    var voucherTC = ""
    var voucherDesc = ""
    var redeemoptions = ""
    var voucherImag = ""
    var voucherCode = ""
    var voucherMinPoints = "-1"
    var voucherMaxPoints = "-1"
    var vouchercategory = ""
    var selectedPoints = 0
    var productcodeselected = ""
    var voucherdelivarytype = ""
    var vouchervendorID = -1
    var vouchervendorname = ""
    var voucherCountryID = -1
    
    
    let redemablePointBalance = UserDefaults.standard.integer(forKey: "RedeemablePointBalance")
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? "-1"
    let layaltyID = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var mobilenumber = UserDefaults.standard.string(forKey: "Mobile") ?? ""
    var emailid = UserDefaults.standard.string(forKey: "CustomerEmail") ?? ""
    var firstname = UserDefaults.standard.string(forKey: "FirstName") ?? ""
    var merchantID = UserDefaults.standard.integer(forKey: "MerchantID")
    
    @IBOutlet weak var voucherNamelabel: UILabel!
    @IBOutlet weak var vouchername: UILabel!
    @IBOutlet weak var voucherimage: UIImageView!
    @IBOutlet weak var amountRange: UILabel!
    @IBOutlet weak var amounttextfield: UITextField!
    @IBOutlet weak var selectAmountButton: UIButton!
    @IBOutlet weak var redeemButton: UIButton!
    @IBOutlet var categoryHeadingLabel: UILabel!
    @IBOutlet var brandHeadingLabel: UILabel!
    
    var VM = QS_VouchersDetails_VM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        localization()
        myVouchersDetailsTableView.delegate = self
        myVouchersDetailsTableView.dataSource = self
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        self.redemptiondate = "\(result)"
        amounttextfield.delegate = self

        myVouchersDetailsTableView.delegate = self
        myVouchersDetailsTableView.dataSource = self
        self.headerlbl.text = "evoucherDetails"
        if voucherMaxPoints != "-1"{
            selectAmountButton.isHidden = true
            amounttextfield.isHidden = false
            amountRange.text = "\("EnterAmountinRange"): \(voucherMinPoints) - \(voucherMaxPoints)"
            selectAmountButton.setTitle("Amount", for: .normal)
            amounttextfield.placeholder = "Amount"
            redeemButton.setTitle("REDEEM", for: .normal)
            
            let points = redemablePointBalance
            let minpoints = Int(voucherMinPoints)
            if points < minpoints! {
                redeemButton.isHidden = false
            }else{
                redeemButton.isHidden = false
            }
        }else if voucherMaxPoints == "-1"{
            selectAmountButton.isHidden = false
            amounttextfield.isHidden = true
            selectAmountButton.setTitle("Amount", for: .normal)
            amountRange.text = "SelectAmount"
            amounttextfield.placeholder = "Amount"
            redeemButton.setTitle("REDEEM", for: .normal)
        }
        self.vouchername.text = voucherName
        self.voucherNamelabel.text = vouchercategory
        self.voucherimage.sd_setImage(with: URL(string: voucherImag), placeholderImage: UIImage(named: "15517sdsd"));
        self.myredemptionsVouchers.append(myredemptionsVouchersModels.init(descriptions: "Descriptions", termsandconditions: voucherDesc))
        self.myredemptionsVouchers.append(myredemptionsVouchersModels.init(descriptions: "Terms_&_Conditions", termsandconditions: voucherTC))
        self.myredemptionsVouchers.append(myredemptionsVouchersModels.init(descriptions: "Redeem_Options", termsandconditions: redeemoptions))
        self.myVouchersDetailsTableView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(handlepopupdateclose), name: Notification.Name.showPopUp, object: nil)
    }
    
    func localization() {
        self.categoryHeadingLabel.text = "Category"
        self.brandHeadingLabel.text = "Brand"
    }
    
    @objc func handlepopupdateclose() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == amounttextfield{
            guard let textFieldText = amounttextfield.text,
                   let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                       return false
               }
               let substringToReplace = textFieldText[rangeOfTextToReplace]
               let count = textFieldText.count - substringToReplace.count + string.count
               return count <= 6
            
        }
        return true
    }
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myredemptionsVouchers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HR_MyVouchersTVC", for: indexPath) as? HR_MyVouchersTVC
        cell?.topic.text = myredemptionsVouchers[indexPath.row].descriptions ?? ""
        cell?.details.text = myredemptionsVouchers[indexPath.row].termsandconditions ?? ""
        cell?.selectionStyle = .none
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedRowIndex {
            return UITableView.automaticDimension //Not expanded
        }
        return 50 //Not expanded
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedRowIndex == indexPath.row {
            selectedRowIndex = -1
        } else {
            selectedRowIndex = indexPath.row
        }
        myVouchersDetailsTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    
    @IBAction func selectAmount(_ sender: Any) {
        DispatchQueue.main.async{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_RedeemQuantity_VC") as! HR_RedeemQuantity_VC
            vc.productCodefromPrevious = self.voucherCode
            vc.delegate = self
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func redeemButton(_ sender: Any) {
        if voucherMinPoints != "-1" || voucherMaxPoints != "-1"{
            if self.amounttextfield.text?.count == 0{
                self.alertmsg(alertmsg: "Enter amount to redeem", buttonalert: "OK")
            }else{
                print(UserDefaults.standard.string(forKey: "TotalPoints") ?? "")
                let totalPts = UserDefaults.standard.string(forKey:"RedeemablePointBalance") ?? ""
                print(totalPts)
                let finalPts = Double(totalPts)
                print(finalPts)
                let totalPointss = Int(finalPts ?? 0.0)
                if Int(self.amounttextfield.text ?? "0")! <= totalPointss{
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
                                let alertVC = UIAlertController(title: "Areyoursure", message: "DoyouWanttoRedeem", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "YES", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    DispatchQueue.main.async {
                                        self.VM.voucherSubmission(ReceiverMobile: self.mobilenumber, ActorId: self.userID, CountryID: self.voucherCountryID, MerchantId: self.merchantID, CatalogueId: self.voucherID, DeliveryType: self.voucherdelivarytype, pointsrequired: self.amounttextfield.text ?? "0", ProductCode: self.voucherCode, ProductImage: self.voucherImag, ProductName: self.voucherName, NoOfQuantity: "1", VendorId: self.vouchervendorID, VendorName: self.vouchervendorname, ReceiverEmail: self.emailid, ReceiverName: self.firstname)
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
                    }
                }else{
                    self.alertmsg(alertmsg: "Insufficient Points Balance", buttonalert: "OK")
                }
            }
        }else{
            if self.selectAmountButton.currentTitle == "Amount"{
                self.alertmsg(alertmsg: "Select_Amount_to_Redeem", buttonalert: "OK")
            }else{
                let totalPts = UserDefaults.standard.string(forKey:"RedeemablePointBalance") ?? ""
                print(totalPts)
                let finalPts = Double(totalPts)
                print(finalPts)
                let totalPointss = Int(finalPts ?? 0.0)
                if totalPointss >= self.selectedPoints{
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
                            let alertVC = UIAlertController(title: "Areyoursure", message: "DoyouWanttoRedeem", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "YES", style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                DispatchQueue.main.async {
                                    self.VM.voucherSubmission(ReceiverMobile: self.mobilenumber, ActorId: self.userID, CountryID: self.voucherCountryID, MerchantId: self.merchantID, CatalogueId: self.voucherID, DeliveryType: self.voucherdelivarytype, pointsrequired: String(self.selectedPoints), ProductCode: self.voucherCode, ProductImage: self.voucherImag, ProductName: self.voucherName, NoOfQuantity: "1", VendorId: self.vouchervendorID, VendorName: self.vouchervendorname, ReceiverEmail: self.emailid, ReceiverName: self.firstname)
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
        }
    }
    @IBAction func enteramounttf(_ sender: Any) {
        if amounttextfield.text != ""{
            let amt = Int(amounttextfield.text ?? "0") ?? 0
            if amt < Int(voucherMinPoints)! || amt > Int(voucherMaxPoints)!{
                self.redeemButton.backgroundColor = UIColor.lightGray
                self.redeemButton.isEnabled = false
            }else{
                self.redeemButton.backgroundColor = UIColor(red: 0/255, green: 183/255, blue: 241/255, alpha: 1.0)
                self.redeemButton.isEnabled = true
            }
        }
    }
    
    
}

class myredemptionsVouchersModels: NSObject {
    var descriptions :String!
    var termsandconditions : String!
    init(descriptions:String!, termsandconditions:String!){
        self.descriptions = descriptions
        self.termsandconditions = termsandconditions
        
        
    }
}
