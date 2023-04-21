//
//  HR_RedeemQuantity_VC.swift
//  HR_Johnson
//
//  Created by ADMIN on 10/05/2022.
//

import UIKit
//import LanguageManager_iOS
    protocol pointsDelegate {
        func selectPointsDidTap(_ VC: HR_RedeemQuantity_VC)
    }

class HR_RedeemQuantity_VC: BaseViewController, UITableViewDelegate, UITableViewDataSource, popUpAlertDelegate {
        func popupAlertDidTap(_ vc: HR_PopUpVC) {}
        
         let VM = QS_redeemQuantity_VM()
        @IBOutlet var pointsTableView: UITableView!
        @IBOutlet var selectAmountLabel: UILabel!
        var productCodefromPrevious = ""
        let userID = UserDefaults.standard.string(forKey: "UserID") ?? "-1"
        var delegate:pointsDelegate?
        var selectedpoints = 0
        override func viewDidLoad() {
            super.viewDidLoad()
            self.VM.VC = self
            self.pointsTableView.delegate = self
            self.pointsTableView.dataSource = self
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                     let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                 vc!.descriptionInfo = "No Internet"
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                 }
            }else{
            self.VM.myVouchersAPI(userID: userID, productCode: productCodefromPrevious)
            }
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
            {
                let touch = touches.first
                if touch?.view == self.view {
                    self.dismiss(animated: true, completion: nil) }
            }
        
    }
    extension HR_RedeemQuantity_VC{
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.filteredpointsArray.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QS_PointsVoucher_TVC", for: indexPath) as? QS_PointsVoucher_TVC
            cell?.pointsLabel.text = String(self.VM.filteredpointsArray[indexPath.row].fixedPoints ?? 0)
            return cell!
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.selectedpoints = self.VM.filteredpointsArray[indexPath.row].fixedPoints ?? 0
            self.delegate?.selectPointsDidTap(self)
            self.dismiss(animated: true, completion: nil)
        }
    }
