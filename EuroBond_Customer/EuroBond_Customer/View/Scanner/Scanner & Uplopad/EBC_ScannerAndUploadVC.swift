//
//  EBC_ScannerAndUploadVC.swift
//  EuroBond_Customer
//
//  Created by admin on 04/04/23.
//

import UIKit

class EBC_ScannerAndUploadVC: UIViewController {
    func didTappedCodeStatusBtn(item: ScannedCodes_VC) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_CodeStatusVC") as? EBC_CodeStatusVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func didTappedSubmitBtn(item: ScannedCodes_VC) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_QRCodeSubmitSuccessMessageVC") as? EBC_QRCodeSubmitSuccessMessageVC
        vc?.modalTransitionStyle = .coverVertical
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!, animated: true)
    }
    

    @IBOutlet weak var clickHereToSeeLbl: UILabel!
    @IBOutlet weak var selectedQRCodeNnumber: GradientLabel!
    @IBOutlet weak var scanCodeBtn: UIButton!
    @IBOutlet weak var submitBtn: GradientButton!
    @IBOutlet weak var uploadCodeDescLbl: UILabel!
    @IBOutlet weak var enterCodeTitle: UILabel!
    @IBOutlet weak var enterCodeTF: UITextField!
    @IBOutlet weak var uploadView: UIView!
    @IBOutlet weak var scannerImage: UIImageView!
    @IBOutlet weak var scannerView: UIView!
    @IBOutlet weak var titleVC: UILabel!
    var flags: String = "SideMenu"
    var scanner = "Scan"
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        if flags == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectSubmitBtn(_ sender: Any) {
    }
    
    @IBAction func selectScanCodeBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectMyqrCodeListingBtn(_ sender: Any) {
//        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScannedCodes_VC") as? ScannedCodes_VC
//        vc?.modalTransitionStyle = .coverVertical
//        vc?.modalPresentationStyle = .overFullScreen
//        vc?.delegate = self
//        present(vc!, animated: true)
        
    }
    

    
    
    
    
}
