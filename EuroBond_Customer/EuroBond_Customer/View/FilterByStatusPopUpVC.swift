//
//  FilterByStatusPopUpVC.swift
//  CenturyPly_JSON
//
//  Created by ADMIN on 07/06/2022.
//

import UIKit
protocol StatusDelegate{
    func selectStatus(_ vc: FilterByStatusPopUpVC)
}
class FilterByStatusPopUpVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var filterByStatusTableView: UITableView!
    var statusListingArray = ["All Status","Valid Code","In-Valid Code","Code is busy","Success and points credited","Technical issue","Invalid length","Invalid member","Success but points not credited","Code Generated","Code Mapped","You are not entitled for this product to bank","Code Already Banked by You","Code Already Used by Others","You are not entitled for this product to bank", "Pending", "Code already used"]
    var statusIDListingArray = [-1,1,2,4,5,6,7,8,9,10,11,14,18,19,20,0,3]
    var statusImageListingArray = ["sand_clock","ic_status_success","ic_status_reject","ic_status_code_is_busy","success_and_point_credited","ic_status_technical_issue","invalid_length","invalid_member","ic_status_success_but_points_not_credited","ic_status_code_generated","ic_status_code_mapped","ic_status_qr_code_is_not_available_for_your_location","code_already_banked_by_you","code_already_banked_by_others"]
    var statusName = ""
    var statusId = -1
    var delegate: StatusDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()

        filterByStatusTableView.delegate = self
        filterByStatusTableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = statusListingArray.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterByStatusTVC") as? FilterByStatusTVC

        if self.statusListingArray[indexPath.row] == "Valid Code" {
                   cell?.statusImage.image = UIImage(named: "ic_status_success")
                    cell?.statusType.text = "Valid Code"
            //       cell?.statusType.textColor = UIColor(red: 54/255, green: 158/255, blue: 58/255, alpha: 1.0)
            
               } else if self.statusListingArray[indexPath.row] == "In-Valid Code" {
                   cell?.statusType.text = "In-Valid Code"
                   cell?.statusImage.image = UIImage(named: "ic_status_reject")
             //      cell?.statusType.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
               } else if self.statusListingArray[indexPath.row] == "Code is busy" {
                   cell?.statusType.text = "Code is busy"
                   cell?.statusImage.image = UIImage(named: "ic_status_code_is_busy")
              //     cell?.statusType.textColor = UIColor(red: 35/255, green: 133/255, blue: 235/255, alpha: 1.0)
               } else if self.statusListingArray[indexPath.row] == "Success and points credited" {
                   cell?.statusType.text = "Success and points credited"
                   cell?.statusImage.image = UIImage(named: "success_and_point_credited")
               //    cell?.statusType.textColor = UIColor(red: 54/255, green: 158/255, blue: 58/255, alpha: 1.0)
               } else if self.statusListingArray[indexPath.row] == "Technical issue" {
                   cell?.statusType.text = "Technical issue"
                   cell?.statusImage.image = UIImage(named: "ic_status_technical_issue")
            //       cell?.statusType.textColor = UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 1.0)
               } else if self.statusListingArray[indexPath.row] == "Invalid length" {
                   cell?.statusType.text = "Invalid length"
                   cell?.statusImage.image = UIImage(named: "invalid_length")
             //      cell?.statusType.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
               } else if self.statusListingArray[indexPath.row] == "Invalid member" {
                   cell?.statusType.text = "Invalid member"
                   cell?.statusImage.image = UIImage(named: "invalid_member")
               //    cell?.statusType.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
               } else if self.statusListingArray[indexPath.row] == "Success but points not credited" {
                   cell?.statusType.text = "Success but points not credited"
                   cell?.statusImage.image = UIImage(named: "ic_status_success_but_points_not_credited")
                 //  cell?.statusType.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
               } else if self.statusListingArray[indexPath.row] == "Code Generated" {
                   cell?.statusType.text = "Code Generated"
                   cell?.statusImage.image = UIImage(named: "ic_status_code_generated")
               //    cell?.statusType.textColor = UIColor(red: 35/255, green: 133/255, blue: 235/255, alpha: 1.0)
               } else if self.statusListingArray[indexPath.row] == "Code Mapped" {
                   cell?.statusType.text = "Code Mapped"
                   cell?.statusImage.image = UIImage(named: "ic_status_code_mapped")
              //     cell?.statusType.textColor = UIColor(red: 35/255, green: 133/255, blue: 235/255, alpha: 1.0)
               }
//        else if self.statusListingArray[indexPath.row] == "Auto Banking Success" {
//                   cell?.statusType.text = "Auto Banking Success"
//                   cell?.statusImage.image = UIImage(named: "auto_banking_success")
//               //    cell?.statusType.textColor = UIColor(red: 54/255, green: 158/255, blue: 58/255, alpha: 1.0)
//               } else if self.statusListingArray[indexPath.row] == "Auto Banking Failed" {
//                   cell?.statusType.text = "Auto Banking Failed"
//                   cell?.statusImage.image = UIImage(named: "auto_banking_failed")
//                //   cell?.statusType.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
//                   
//               }
        else if self.statusListingArray[indexPath.row] == "You are not entitled for this product to bank" {
                   cell?.statusType.text = "QR Code is not available for your location"
                   cell?.statusImage.image = UIImage(named: "ic_status_qr_code_is_not_available_for_your_location")
                 //  cell?.statusType.textColor = UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 1.0)
               } else if self.statusListingArray[indexPath.row] == "Code Already Banked by You" {
                   cell?.statusType.text = "Code Already Banked by You"
                   cell?.statusImage.image = UIImage(named: "code_already_banked_by_you")
                //   cell?.statusType.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
               } else if self.statusListingArray[indexPath.row] == "Code Already Used by Others" {
                   cell?.statusType.text = "Code Already Used by Others"
                   cell?.statusImage.image = UIImage(named: "code_already_banked_by_others")
                 // cell?.statusType.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
               }//
        else if self.statusListingArray[indexPath.row] == "Code already used" {
            cell?.statusType.text = "Code already used"
            cell?.statusImage.image = UIImage(named: "code_already_banked_by_others")
          // cell?.statusType.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
        }
        else if self.statusListingArray[indexPath.row] == "Pending" {
                   cell?.statusType.text = "Pending"
                   cell?.statusImage.image = UIImage(named: "pending")
                 //  cell?.statusType.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
               }else if self.statusListingArray[indexPath.row] == "You are not entitled for this product to bank" {
                   cell?.statusType.text = "You are not entitled for this product to bank"
                   cell?.statusImage.image = UIImage(named: "pending")
                  // cell?.statusType.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
               }else if self.statusListingArray[indexPath.row] == "All Status" {
                   cell?.statusType.text = "All Status"
                   cell?.statusImage.image = UIImage(named: "sand_clock")
//                   cell?.statusType.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
                   
               }

        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.statusName = self.statusListingArray[indexPath.row]
        self.statusId = self.statusIDListingArray[indexPath.row]
        self.delegate.selectStatus(self)
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
  
    

}
