//
//  EBC_RedeemNowVC.swift
//  EuroBond_Customer
//
//  Created by syed on 21/03/23.
//

import UIKit
import LanguageManager_iOS

class EBC_RedeemNowVC: BaseViewController {

    @IBOutlet weak var cartValue: UILabel!
    @IBOutlet weak var eurosLbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var titleVC: UILabel!
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    @IBOutlet weak var PercentageInfoLbl: UILabel!
    
    
    var container: ContainerViewController!
    var flags = "1"
    var requestAPIs = RestAPI_Requests()
    var myCartListArray = [CatalogueSaveCartDetailListResponse]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.balanceLbl.text = "\(self.redeemablePointBal)"
        NotificationCenter.default.addObserver(self, selector: #selector(getCount), name: Notification.Name.cartCount, object: nil)
        segmentController.selectedSegmentIndex = 0
        let font = UIFont.systemFont(ofSize: 13)
        segmentController.setTitleTextAttributes([NSAttributedString.Key.font: font],
                                                for: .normal)
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentController.setTitleTextAttributes(titleTextAttributes1, for: .selected)
        segmentController.setTitleTextAttributes(titleTextAttributes, for: .normal)
        
        self.container.segueIdentifierReceivedFromParent("first")
        self.localizSetup()
    }
    @objc func getCount(){
        self.getMycartList()
    }
    
    func localizSetup(){
        self.PercentageInfoLbl.text = ""
        self.titleVC.text = "Redemption Catalogue".localiz()
        segmentController.setTitle("Physical Products".localiz(), forSegmentAt: 0)
        segmentController.setTitle("eVoucher".localiz(), forSegmentAt: 1)
        segmentController.setTitle("Bank Transfer".localiz(), forSegmentAt: 2)
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"{
            self.container = segue.destination as? ContainerViewController
        }
    }
 
    @IBAction func cartBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_MyCartVC") as! HR_MyCartVC
        self.navigationController?.pushViewController(vc, animated: true)
            }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        if flags == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectSegmentController(_ sender: UISegmentedControl) {
        if segmentController.selectedSegmentIndex == 0{
            container.segueIdentifierReceivedFromParent("first")
            self.eurosLbl.text = "POINTS".localiz()
            self.balanceLbl.text = "\(self.redeemablePointBal)"
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentController.setTitleTextAttributes(titleTextAttributes, for: .selected)
        }else if segmentController.selectedSegmentIndex == 1{
            container.segueIdentifierReceivedFromParent("second")
            self.eurosLbl.text = "Rupees".localiz()
            self.balanceLbl.text = "\(self.redeemableEncashBalance)"
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentController.setTitleTextAttributes(titleTextAttributes, for: .selected)
        }else{
            container.segueIdentifierReceivedFromParent("third")
            self.eurosLbl.text = "Rupees".localiz()
            self.balanceLbl.text = "\(self.redeemableEncashBalance)"
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentController.setTitleTextAttributes(titleTextAttributes, for: .selected)
        }
        
    }
    func getMycartList(){
        self.startLoading()
        let parameters = [
            "ActionType":"2",
            "LoyaltyID":"\(self.loyaltyId)"
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.myCartListApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.myCartListArray = result?.catalogueSaveCartDetailListResponse ?? []
                        self.cartValue.text = "\(self.myCartListArray.count)"
                        print(self.myCartListArray.count, "MyCarTCoutn")

                    }
                    DispatchQueue.main.async {
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
}


extension UISegmentedControl{
    func selectedSegmentTintColor(_ color: UIColor) {
        self.setTitleTextAttributes([.foregroundColor: color], for: .selected)
    }
    func unselectedSegmentTintColor(_ color: UIColor) {
        self.setTitleTextAttributes([.foregroundColor: color], for: .normal)
    }
}
