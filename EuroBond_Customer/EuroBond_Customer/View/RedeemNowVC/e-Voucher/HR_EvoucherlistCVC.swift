//
//  HR_EvoucherlistCVC.swift
//  HR_Johnson
//
//  Created by ADMIN on 11/05/2022.
//

import UIKit
import SDWebImage
//import LanguageManager_iOS
protocol EvoucherProductDelegate {
    func redeemButton(_ cell: HR_EvoucherlistCVC)
    func amountField(_ cell: HR_EvoucherlistCVC)
    func alertDidTap(_ cell: HR_EvoucherlistCVC)
}


class HR_EvoucherlistCVC: UICollectionViewCell, UITextFieldDelegate, popUpAlertDelegate{
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productRange: UILabel!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var amountBTN: UIButton!
    @IBOutlet weak var redeemBTN: GradientButton!
    
    var delegate: EvoucherProductDelegate!
    var enteredAmount = 0
    var vouchersdata = [ObjCatalogueList13]()
    var alertMsg = ""
    var selectedPoints = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.amountTF.delegate = self
        self.amountTF.placeholder = "Enter Amount"
        self.redeemBTN.setTitle("Redeem", for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("SHOWDATA23"), object: nil)

    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        guard let yourPassedObject = notification.object as? HR_EvoucherListVC else {return}
        if self.vouchersdata[0].productCode == yourPassedObject.productcodeselected{
        self.selectedPoints = yourPassedObject.selectedPoints
        self.amountBTN.setTitle(String(self.selectedPoints), for: .normal)
        NotificationCenter.default.removeObserver(self)
        }
    }
   
    
    @IBAction func amountTFeditingChanged(_ sender: Any) {
        self.enteredAmount = Int(self.amountTF.text ?? "") ?? 0
        if amountTF.text?.count != 0{
            let amt = Int(amountTF.text ?? "0")!
            if amt < Int(vouchersdata[0].min_points!)! || amt > Int(vouchersdata[0].max_points!)!{
                self.redeemBTN.backgroundColor = UIColor.gray
                self.redeemBTN.isEnabled = false
            }else{
                self.redeemBTN.backgroundColor = UIColor(red: 1/255, green: 105/255, blue: 56/255, alpha: 1.0)
                self.redeemBTN.isEnabled = true
            }
        }
    }
    
    @IBAction func redeemButton(_ sender: Any) {
        self.delegate?.redeemButton(self)
    }
    @IBAction func amountListBTN(_ sender: Any) {
        self.delegate?.amountField(self)
//        if vouchersdata[0].min_points ?? "" != "" || vouchersdata[0].max_points ?? "" != ""{
//            if self.amountTF.text?.count == 0{
//                self.alertMsg = "Enter amount to redeem"
//                self.delegate?.alertDidTap(self)
//            }else{
//                self.delegate?.redeemButton(self)
//            }
//        }else{
//            if self.amountBTN.currentTitle == "Amount"{
//                self.alertMsg = "Select amount to redeem"
//                self.delegate?.alertDidTap(self)
//            }else{
//                self.delegate?.redeemButton(self)
//            }
//        }
    }
    
    func setdata(redemablePoints:Int){
        if self.vouchersdata[0].min_points ?? "" == "" || self.vouchersdata[0].max_points ?? "" == ""{
        
        }else{
            if redemablePoints < Int(self.vouchersdata[0].min_points!)!{
                self.redeemBTN.backgroundColor = UIColor.gray
                self.redeemBTN.isEnabled = false
            }else{
                self.redeemBTN.backgroundColor = UIColor(red: 1/255, green: 105/255, blue: 56/255, alpha: 1.0)
                self.redeemBTN.isEnabled = true
            }
        }

    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == amountTF{
            guard let textFieldText = amountTF.text,
                   let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                       return false
               }
               let substringToReplace = textFieldText[rangeOfTextToReplace]
               let count = textFieldText.count - substringToReplace.count + string.count
               return count <= 6        }
        return true
    }
    
}
