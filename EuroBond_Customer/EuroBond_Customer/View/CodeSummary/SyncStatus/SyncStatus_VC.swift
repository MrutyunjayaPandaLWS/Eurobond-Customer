//
//  SyncStatus_VC.swift
//  centuryDemo
//
//  Created by Arokia-M3 on 15/03/22.
//

import UIKit
import Firebase

class SyncStatus_VC: BaseViewController, checkMarkDelegate {

    @IBOutlet var syncStatusTitleLabel: UILabel!
    @IBOutlet var checkMarkButton: UIButton!
    @IBOutlet var syncStatusTableView: UITableView!
    
//    var vm = SyncStatusViewModel()
//    var syncStatusListingArray = [QrUsegereport]()
  //  let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var statusID = -1
    var selectedFromDate = ""
    var selectedToDate = ""
    var statusListingArray = ["All Status","Valid Code","In-Valid Code","Code is busy","Success and points credited","Technical issue","Invalid length","Invalid member","Success but points not credited","Code Generated","Code Mapped","Auto Banking Success","Auto Banking Failed","QR Code is not available for your location","Code Already scanned by you","Code Already used by others"]
    var statusIDListingArray = [-1,1,2,4,5,6,7,8,9,10,11,12,13,14,18,19]
    var statusImageListingArray = ["sand_clock","ic_status_success","ic_status_reject","ic_status_code_is_busy","success_and_point_credited","ic_status_technical_issue","invalid_length","invalid_member","ic_status_success_but_points_not_credited","ic_status_code_generated","ic_status_code_mapped","auto_banking_success","auto_banking_failed","ic_status_qr_code_is_not_available_for_your_location","code_already_banked_by_you","code_already_banked_by_others"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        syncStatusTableView.delegate = self
        syncStatusTableView.dataSource = self
        apiCalling()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Sync Status")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    @IBAction func sendQuery(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreateNewQueryViewController") as! CreateNewQueryViewController
//        vc.isFrom = 10
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func filterButton(_ sender: Any) {
    }
    @IBAction func checkMarkButton(_ sender: Any) {
//        for data in self.syncStatusListingArray {
//            data.isSelected = 1
//        }
//        self.syncStatusTableView.reloadData()
    }
    
    @IBAction func codeSummary(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CodeSummary_VC") as! CodeSummary_VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func apiCalling() {
        let parameters = ["ActionType":210,"MemberID":"\(loyaltyId)","QrCodeStatusID":self.statusID,"FromDate":"\(selectedFromDate)","ToDate":"\(selectedToDate)"] as [String : Any]
//        self.vm.syncStatusListingAPI(parameters: parameters) { response in
//            self.syncStatusListingArray = response?.qrUsegereport ?? []
//            DispatchQueue.main.async {
//                self.syncStatusTableView.reloadData()
//                self.stopLoading()
//            }
//        }
    }
    
    func checkMarkDidTap(_ vc: SyncStatus_TVC) {
        guard let tappedIndexPath = syncStatusTableView.indexPath(for: vc) else { return }
        //self.syncStatusListingArray[tappedIndexPath.row].isSelected ?? 0 == 1
        self.syncStatusTableView.reloadData()
    }
}

extension SyncStatus_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.syncStatusListingArray.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SyncStatus_TVC") as! SyncStatus_TVC
//        cell.CodeLabel.text = self.syncStatusListingArray[indexPath.row].scratchCode ?? ""
//        cell.dateLabel.text = self.syncStatusListingArray[indexPath.row].bankingDate ?? ""
//        cell.statusLabel.text = self.syncStatusListingArray[indexPath.row].usedRemarks ?? ""
////        if self.syncStatusListingArray[indexPath.row].isSelected ?? 0 == 1 {
////            cell.checkMarkButton.setImage(UIImage(named: "check-box-empty-4"), for: .normal)
////        } else {
////            cell.checkMarkButton.setImage(UIImage(named: "check-box-empty"), for: .normal)
////        }
//        if self.syncStatusListingArray[indexPath.row].usedRemarks ?? "" == "Valid Code" {
//            cell.statusImageView.image = UIImage(named: "ic_status_success")
//            cell.statusLabel.textColor = UIColor(red: 54/255, green: 158/255, blue: 58/255, alpha: 1.0)
//        } else if self.syncStatusListingArray[indexPath.row].usedRemarks ?? "" == "In-Valid Code" {
//            cell.statusImageView.image = UIImage(named: "ic_status_reject")
//            cell.statusLabel.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
////        } else if self.syncStatusListingArray[indexPath.row].usedRemarks ?? "" == "Code already used" {
////            cell.statusImageView.image = UIImage(named: "")
////            cell.statusLabel.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
//        } else if self.syncStatusListingArray[indexPath.row].usedRemarks ?? "" == "Code is busy" {
//            cell.statusImageView.image = UIImage(named: "ic_status_code_is_busy")
//            cell.statusLabel.textColor = UIColor(red: 35/255, green: 133/255, blue: 235/255, alpha: 1.0)
//        } else if self.syncStatusListingArray[indexPath.row].usedRemarks ?? "" == "Success and points credited" {
//            cell.statusImageView.image = UIImage(named: "success_and_point_credited")
//            cell.statusLabel.textColor = UIColor(red: 54/255, green: 158/255, blue: 58/255, alpha: 1.0)
//        } else if self.syncStatusListingArray[indexPath.row].usedRemarks ?? "" == "Technical issue" {
//            cell.statusImageView.image = UIImage(named: "ic_status_technical_issue")
//            cell.statusLabel.textColor = UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 1.0)
//        } else if self.syncStatusListingArray[indexPath.row].usedRemarks ?? "" == "Invalid length" {
//            cell.statusImageView.image = UIImage(named: "invalid_length")
//            cell.statusLabel.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
//        } else if self.syncStatusListingArray[indexPath.row].usedRemarks ?? "" == "Invalid member" {
//            cell.statusImageView.image = UIImage(named: "invalid_member")
//            cell.statusLabel.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
//        } else if self.syncStatusListingArray[indexPath.row].usedRemarks ?? "" == "Success but points not credited" {
//            cell.statusImageView.image = UIImage(named: "ic_status_success_but_points_not_credited")
//            cell.statusLabel.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
//        } else if self.syncStatusListingArray[indexPath.row].usedRemarks ?? "" == "Code Generated" {
//            cell.statusImageView.image = UIImage(named: "ic_status_code_generated")
//            cell.statusLabel.textColor = UIColor(red: 35/255, green: 133/255, blue: 235/255, alpha: 1.0)
//        } else if self.syncStatusListingArray[indexPath.row].usedRemarks ?? "" == "Code Mapped" {
//            cell.statusImageView.image = UIImage(named: "ic_status_code_mapped")
//            cell.statusLabel.textColor = UIColor(red: 35/255, green: 133/255, blue: 235/255, alpha: 1.0)
//        }
////        else if self.syncStatusListingArray[indexPath.row].usedRemarks ?? "" == "Auto Banking Success" {
////            cell.statusImageView.image = UIImage(named: "auto_banking_success")
////            cell.statusLabel.textColor = UIColor(red: 54/255, green: 158/255, blue: 58/255, alpha: 1.0)
////        } else if self.syncStatusListingArray[indexPath.row].usedRemarks ?? "" == "Auto Banking Failed" {
////            cell.statusImageView.image = UIImage(named: "auto_banking_failed")
////            cell.statusLabel.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
////        }
//        else if self.syncStatusListingArray[indexPath.row].usedRemarks ?? "" == "QR Code is not available for your location" {
//            cell.statusImageView.image = UIImage(named: "ic_status_qr_code_is_not_available_for_your_location")
//            cell.statusLabel.textColor = UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 1.0)
//        } else if self.syncStatusListingArray[indexPath.row].usedRemarks ?? "" == "Code Already Banked by You" {
//            cell.statusImageView.image = UIImage(named: "code_already_banked_by_you")
//            cell.statusLabel.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
//        } else if self.syncStatusListingArray[indexPath.row].usedRemarks ?? "" == "Code Already Used by Others" {
//            cell.statusImageView.image = UIImage(named: "code_already_banked_by_others")
//            cell.statusLabel.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
//        } else if self.syncStatusListingArray[indexPath.row].usedRemarks ?? "" == "Pending" {
//            cell.statusImageView.image = UIImage(named: "Pending")
//            cell.statusLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
