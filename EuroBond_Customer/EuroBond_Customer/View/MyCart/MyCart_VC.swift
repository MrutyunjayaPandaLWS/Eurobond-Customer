//
//  MyCart_VC.swift
//  centuryDemo
//
//  Created by Arokia-M3 on 14/03/22.
//

import UIKit
import SDWebImage
import Firebase
import Toast_Swift

class MyCart_VC: BaseViewController, MyCartDelegate{
   
    @IBOutlet var myCartTitleLabel: UILabel!
    @IBOutlet var myCartTableView: UITableView!
    @IBOutlet var proceedToCheckoutButton: GradientButton!
    @IBOutlet var totalPointsHeadingLabel: UILabel!
    @IBOutlet var totalPointsLabel: UILabel!
    @IBOutlet weak var checkoutView: UIView!
    @IBOutlet weak var nodataFound: UILabel!
    
    
    var VM = MycartViewModel()
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    //let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var customerCartId = 0
    var quantity = 1
    var productValue = ""
    var finalPoints = 0
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.myCartTableView.delegate = self
        self.myCartTableView.dataSource = self
        self.myCartTableView.separatorStyle = .none

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.myCartList()
        languagelocalization()
    
    }
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.myCartTitleLabel.text = "My Cart"
            self.totalPointsHeadingLabel.text = "Total Points"
            self.proceedToCheckoutButton.setTitle("PROCESS TO CHECKOUT", for: .normal)
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.myCartTitleLabel.text = "मेरी गाड़ी"
            self.totalPointsHeadingLabel.text = "कुल अंक"
            self.proceedToCheckoutButton.setTitle("चेकआउट करने की प्रक्रिया", for: .normal)
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.myCartTitleLabel.text = "আমার কার্ট"
            self.totalPointsHeadingLabel.text = "মোট পয়েন্ট"
            self.proceedToCheckoutButton.setTitle("চেকআউট করার প্রক্রিয়া", for: .normal)
            
        }else{
            self.myCartTitleLabel.text = "నా కార్ట్"
            self.totalPointsHeadingLabel.text = "మొత్తం పాయింట్లు"
            self.proceedToCheckoutButton.setTitle("చెక్అవుట్ చేయడానికి ప్రక్రియ", for: .normal)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkOutButton(_ sender: Any) {
        print(verifiedStatus, "account verified Status")
        if self.verifiedStatus == 6 || self.verifiedStatus == 4 || self.verifiedStatus != 1{
            if self.checkAccountStatus == "1"{
                NotificationCenter.default.post(name: .verificationStatus, object: nil)
            }else{
                NotificationCenter.default.post(name: .verificationStatus, object: nil)
            }
            
        }else if self.verifiedStatus == 1{
            if UserDefaults.standard.integer(forKey: "IsRedeemable") == -3{
                self.view.makeToast("Your PAN Details are pending,Please contact your administrator!", duration: 2.0, position: .bottom)
            }else if UserDefaults.standard.integer(forKey: "IsRedeemable") == -4{
                self.view.makeToast("Your PAN Details are rejected,Please contact your administrator!", duration: 2.0, position: .bottom)
            }else if UserDefaults.standard.integer(forKey: "IsRedeemable") == 1{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DefaultAddressVC") as! EBC_DefaultAddressVC
                vc.totalPoint = finalPoints
                vc.redemptionTypeId = 1
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                self.view.makeToast("Insufficient point balance to redeem!", duration: 2.0, position: .bottom)
            }
        }
        
    }
    
    //Delegate:-
    
    //func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    func increaseCount(_ cell: MyCart_TVC) {
        guard let tappedIndexPath = self.myCartTableView.indexPath(for: cell) else{return}
        if cell.plusBTN.tag == tappedIndexPath.row{
            if Int(self.VM.myCartListArray[tappedIndexPath.row].sumOfTotalPointsRequired ?? 0.0) <= Int(self.pointBalance) ?? 0{
                let calcValue = Int(self.VM.myCartListArray[tappedIndexPath.row].sumOfTotalPointsRequired ?? 0) + Int(self.VM.myCartListArray[tappedIndexPath.row].pointsPerUnit ?? 0)
                print(calcValue, "Calculated Values")
                if calcValue <= Int(self.pointBalance) ?? 0{
                    let totalQTY = Int(self.VM.myCartListArray[tappedIndexPath.row].noOfQuantity ?? 0) + 1
                    self.quantity = totalQTY
                    cell.countTF.text = "\(quantity)"
                    self.customerCartId = self.VM.myCartListArray[tappedIndexPath.row].customerCartId ?? 0
                    self.increaseProduct()
                }else{
                    DispatchQueue.main.async{
//                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                        vc!.delegate = self
//                        vc!.titleInfo = ""
//
//                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                            vc!.descriptionInfo = "Insufficient Point Balance"
//                         }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                             vc!.descriptionInfo = "अपर्याप्त प्वाइंट बैलेंस"
//                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                            vc!.descriptionInfo = "অপর্যাপ্ত পয়েন্ট ব্যালেন্স"
//                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                            vc!.descriptionInfo = "తగినంత పాయింట్ బ్యాలెన్స్ లేదు"
//                          }
//                        vc!.modalPresentationStyle = .overCurrentContext
//                        vc!.modalTransitionStyle = .crossDissolve
//                        self.present(vc!, animated: true, completion: nil)
                    }
                }
                
            }
        }
        self.myCartTableView.reloadData()
    }
    
    func decreaseCount(_ cell: MyCart_TVC) {
        guard let tappedIndexPath = self.myCartTableView.indexPath(for: cell) else{return}
        if self.VM.myCartListArray[tappedIndexPath.row].noOfQuantity ?? 0 >= 1{
            cell.minusBTN.isEnabled = true
            if cell.minusBTN.tag == tappedIndexPath.row{
                if Int(self.VM.myCartListArray[tappedIndexPath.row].sumOfTotalPointsRequired ?? 0.0) <= Int(self.pointBalance) ?? 0{
                    let calcValue = Int(self.VM.myCartListArray[tappedIndexPath.row].sumOfTotalPointsRequired ?? 0) - Int(self.VM.myCartListArray[tappedIndexPath.row].pointsPerUnit ?? 0)
                    print(calcValue, "reduceValues")
                    if calcValue <= Int(self.pointBalance) ?? 0 {
                        if calcValue != 0  && calcValue >= Int(self.VM.myCartListArray[tappedIndexPath.row].pointsPerUnit ?? 0){
                            let totalQuantity = Int(self.VM.myCartListArray[tappedIndexPath.row].noOfQuantity ?? 0) - 1
                            self.quantity = totalQuantity
                            self.customerCartId = self.VM.myCartListArray[tappedIndexPath.row].customerCartId ?? 0
                            if self.quantity >= 1 {
                                cell.countTF.text = "\(quantity)"
                                self.increaseProduct()
                            }else{
                                self.quantity = 1
                            }
                           
                        }
                        
                    }else{
                        DispatchQueue.main.async{
//                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                            vc!.delegate = self
//                            vc!.titleInfo = ""
//                            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                                vc!.descriptionInfo = "Insufficient Point Balance"
//                             }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                                 vc!.descriptionInfo = "अपर्याप्त प्वाइंट बैलेंस"
//                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                                vc!.descriptionInfo = "অপর্যাপ্ত পয়েন্ট ব্যালেন্স"
//                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                                vc!.descriptionInfo = "తగినంత పాయింట్ బ్యాలెన్స్ లేదు"
//                              }
//                            vc!.modalPresentationStyle = .overCurrentContext
//                            vc!.modalTransitionStyle = .crossDissolve
//                            self.present(vc!, animated: true, completion: nil)
                        }
                    }
                }
                
            }
        }else{
//            if self.VM.myCartListArray[tappedIndexPath.row].noOfQuantity ?? 0 < 1{
//                cell.minusBTN.isEnabled = false
//                cell.countTF.text = "1"
//            }
          
        }
        
 
            self.myCartTableView.reloadData()
    }
    
    func removeProduct(_ cell: MyCart_TVC) {
        guard let tappedIndexPath = self.myCartTableView.indexPath(for: cell) else{return}
        if cell.removeProductBTN.tag == tappedIndexPath.row{
            self.customerCartId = self.VM.myCartListArray[tappedIndexPath.row].customerCartId ?? 0
            self.removeProduct()
            self.myCartTableView.reloadData()
        }
    }
    
    //Api:-
    
    func myCartList(){
           let parameters = [
               "ActionType": "2",
               "LoyaltyID": "\(loyaltyId)"
           ] as [String: Any]
           print(parameters)
           self.VM.myCartList(parameters: parameters) { response in
               self.VM.myCartListArray = response?.catalogueSaveCartDetailListResponse ?? []
               print(self.VM.myCartListArray.count)
               if self.VM.myCartListArray.count != 0 {
                   DispatchQueue.main.async {
                      
                       self.myCartTableView.isHidden = false
                       self.checkoutView.isHidden = false
                       self.nodataFound.isHidden = true
                       self.myCartTableView.reloadData()
                       //UserDefaults.standard.set(self.VM.myCartListArray[0].Is_Redeemable ?? 0, forKey: "IsRedeemable")
                       UserDefaults.standard.synchronize()
//                       if self.VM.myCartListArray[0].Is_Redeemable ?? -2 == 1 || self.VM.myCartListArray[0].Is_Redeemable ?? -2 == -3 || self.VM.myCartListArray[0].Is_Redeemable ?? -2 == -4{
//                           self.checkoutView.isHidden = false
//                       }else{
//                           self.checkoutView.isHidden = true
//
//                       }
                       self.stopLoading()
                   }
               }else{
                   
                   DispatchQueue.main.async {
                       self.myCartTableView.isHidden = true
                       self.checkoutView.isHidden = true
                       self.nodataFound.isHidden = false
                       self.stopLoading()
                   }
               }
               
           }
       }
    
    func increaseProduct(){
        
        let parameters = [
            
            "ActionType": "3",
            "ActorId": "\(userID)",
            "CustomerCartId": "\(customerCartId)",
            "CustomerCartList": [
                [
                "CustomerCartId": "\(customerCartId)",
                "Quantity": "\(quantity)"
                ]
            ]
            ] as [String: Any]
        print(parameters)
        self.VM.increaseProductApi(parameters: parameters) { response in
            print(response?.returnMessage ?? "0")
            if response?.returnMessage == "1"{
                DispatchQueue.main.async {
                    self.myCartList()
                    self.myCartTableView.reloadData()
                    self.stopLoading()
                }
            }else{
                DispatchQueue.main.async {
                    self.stopLoading()
                }
            }
        }
    }
    
    
    func removeProduct(){
        let parameters = [
            "ActionType": "4",
            "ActorId": "\(userID)",
            "CustomerCartId": "\(customerCartId)"
        ] as [String: Any]
        print(parameters)
        self.VM.removeProduct(parameters: parameters) { response in
       
            if response?.returnMessage == "1"{
                DispatchQueue.main.async{
                    self.myCartList()
                    self.myCartTableView.reloadData()
//                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                        vc!.delegate = self
//                        vc!.titleInfo = ""
//
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                        vc!.descriptionInfo = "Product has been removed from Cart"
//                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                         vc!.descriptionInfo = "कार्ट से उत्पाद हटा दिया गया है"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                        vc!.descriptionInfo = "পণ্য কার্ট থেকে সরানো হয়েছে"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                        vc!.descriptionInfo = "కార్ట్ నుండి ఉత్పత్తి తీసివేయబడింది"
//                      }
//                        vc!.modalPresentationStyle = .overCurrentContext
//                        vc!.modalTransitionStyle = .crossDissolve
//                        self.present(vc!, animated: true, completion: nil)
                        self.stopLoading()
                    }
                    
            }else{
                DispatchQueue.main.async{
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                    vc!.delegate = self
//                    vc!.titleInfo = ""
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                        vc!.descriptionInfo = "Something went wrong!"
//                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                         vc!.descriptionInfo = "कुछ गलत हो गया!"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                        vc!.descriptionInfo = "কিছু ভুল হয়েছে!"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                        vc!.descriptionInfo = "ఎక్కడో తేడ జరిగింది!"
//                      }
//                    vc!.modalPresentationStyle = .overCurrentContext
//                    vc!.modalTransitionStyle = .crossDissolve
//                    self.present(vc!, animated: true, completion: nil)
                    self.stopLoading()
                }
            }
                
            }
    }
}
extension MyCart_VC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myCartListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCart_TVC") as! MyCart_TVC
        cell.delegate = self
        cell.selectionStyle = .none
        cell.catagoryName.text = self.VM.myCartListArray[indexPath.row].categoryName ?? ""
        cell.productName.text = self.VM.myCartListArray[indexPath.row].productName ?? ""
        cell.pointsLabel.text = "\(self.VM.myCartListArray[indexPath.row].pointsRequired ?? 0)"
        let receivedImage = self.VM.myCartListArray[indexPath.row].productImage ?? ""
        let totalImgURL = productCatalogueImgURL + receivedImage
        cell.productImageView.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "ic_default_img"))
        
        if self.VM.myCartListArray[indexPath.row].noOfQuantity ?? 0 != 0 {
            cell.countTF.text = "\(self.VM.myCartListArray[indexPath.row].noOfQuantity ?? 0)"
        }else{
            cell.countTF.text = "\(self.quantity)"
        }
        
        cell.plusBTN.tag = indexPath.row
        cell.minusBTN.tag = indexPath.row
        cell.removeProductBTN.tag = indexPath.row
        print("\(self.VM.myCartListArray[indexPath.row].sumOfTotalPointsRequired ?? 0)")
        self.totalPointsLabel.text = "\(self.VM.myCartListArray[indexPath.row].sumOfTotalPointsRequired ?? 0)"
        self.finalPoints = Int(self.VM.myCartListArray[indexPath.row].sumOfTotalPointsRequired ?? 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
}



extension UIViewController{

func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
 }
