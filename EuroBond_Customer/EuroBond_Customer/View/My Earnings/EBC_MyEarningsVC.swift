//
//  EBC_MyEarningsVC.swift
//  EuroBond_Customer
//
//  Created by syed on 20/03/23.
//

import UIKit
import LanguageManager_iOS

class EBC_MyEarningsVC: BaseViewController, DateSelectedDelegate{
    func acceptDate(_ vc: EBC_DateFilterVC) {
        if vc.isComeFrom == "1"{
            self.selectedFromDate = vc.selectedDate
            self.fromDate.setTitle("\(vc.selectedDate)", for: .normal)
            self.fromDate.setTitleColor(.darkGray, for: .normal)
        }else{
            self.selectedToDate = vc.selectedDate
            print(vc.selectedDate)
            if self.selectedFromDate > self.selectedToDate{
                self.view.makeToast("To Date should be greater than From Date".localiz(), duration: 2.0, position: .center)
            }else{
                self.toDate.setTitle("\(vc.selectedDate)", for: .normal)
                self.toDate.setTitleColor(.darkGray, for: .normal)
            }
        }
    }
    
    func declineDate(_ vc: EBC_DateFilterVC) {}
    
   
    @IBOutlet weak var filterButton: GradientButton!
    @IBOutlet weak var noDataFound: UILabel!
    @IBOutlet weak var toDate: UIButton!
    @IBOutlet weak var fromDate: UIButton!
    @IBOutlet weak var filterByCategoryHeight: NSLayoutConstraint!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var myEarningTV: UITableView!
    @IBOutlet weak var supportBtn: UIButton!
    @IBOutlet weak var myEarningInfoLbl: UILabel!
    @IBOutlet weak var titleVCLBL: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    var flags: String = "1"
    
    var selectedFromDate = ""
    var selectedToDate = ""
    var behaviourId = 0
    var itsComeFrom = ""
    var noofelements = 0
    var startIndex = 1
    var VM = EBC_MyEarningsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.VM.VC = self
        self.selectedFromDate = ""
        self.selectedToDate = ""
        behaviourId = 0
        myEarningTV.delegate = self
        myEarningTV.dataSource = self
        localizSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.VM.myEarningListArray.removeAll()
        self.filterView.isHidden = true
        self.filterByCategoryHeight.constant = 0
        self.VM.myEarningListApi(startIndex: 1, fromDate: "", toDate: "")
        self.filterButton.setTitle("Filter", for: .normal)
    }
    
    func localizSetup(){
        self.titleVCLBL.text = "My Earnings".localiz()
        self.myEarningInfoLbl.text = "National euros cannot be redeemed".localiz()
        self.supportBtn.setTitle("Click here for support".localiz(), for: .normal)
        //self.filterButton.setTitle("rest".localiz(), for: .normal)
        //self.filterButton.setTitle("rest".localiz(), for: .normal)
        
        self.fromDate.setTitle("From Date".localiz(), for: .normal)
        self.toDate.setTitle("To Date".localiz(), for: .normal)
        self.filterButton.setTitle("Filter".localiz(), for: .normal)
    }
    
    
    
    @IBAction func fromDateBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DateFilterVC") as! EBC_DateFilterVC
        vc.isComeFrom = "1"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    @IBAction func toDateBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DateFilterVC") as! EBC_DateFilterVC
        vc.isComeFrom = "2"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    @IBAction func filterViewButton(_ sender: Any) {
        if self.filterView.isHidden == true{
            self.filterView.isHidden = false
            self.filterByCategoryHeight.constant = 60
        }else{
            self.filterView.isHidden = true
            self.filterByCategoryHeight.constant = 0
        }
        
    }
    @IBAction func okBtn(_ sender: Any) {
//        self.filterButton.setTitle("Filter", for: .normal)
        if self.filterButton.currentTitle == "Filter"{
           
            if self.selectedFromDate == "" && self.selectedToDate == ""{
                self.view.makeToast("Select date range".localiz(), duration: 2.0, position: .center)
            }else if self.selectedFromDate == ""{
                self.view.makeToast("Select From Date".localiz(), duration: 2.0, position: .center)
            }else if self.selectedToDate == ""{
                self.view.makeToast("Select To Date".localiz(), duration: 2.0, position: .center)
            }else if self.selectedFromDate > self.selectedToDate{
                self.view.makeToast("To Date should be greater than From Date".localiz(), duration: 2.0, position: .center)
            }else{
                self.filterButton.setTitle("Reset".localiz(), for: .normal)
                self.VM.myEarningListArray.removeAll()
                self.startIndex = 1
                self.VM.myEarningListApi(startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
            }
        }else{
            self.filterButton.setTitle("Filter".localiz(), for: .normal)
            self.fromDate.setTitle("From Date".localiz(), for: .normal)
            self.toDate.setTitle("To Date".localiz(), for: .normal)
                self.VM.myEarningListArray.removeAll()
                self.startIndex = 1
                self.selectedFromDate = ""
                self.selectedToDate = ""
                self.VM.myEarningListApi(startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
        }
       
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func selectSupportBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_HelpLineVC") as? EBC_HelpLineVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
extension EBC_MyEarningsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myEarningListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_MyEarningTVC", for: indexPath) as! EBC_MyEarningTVC
        cell.selectionStyle = .none
        cell.pointsLbl.text = "\(Int(self.VM.myEarningListArray[indexPath.row].rewardPoints ?? 0))"
        //cell.statusLbl.text = "\(self.VM.myEarningListArray[indexPath.row].status ?? "-")"
        
        let ststusData = self.VM.myEarningListArray[indexPath.row].isNotionalId ?? 0
        if ststusData == 1 {
            cell.statusLbl.text = "Notional"
        }else{
            cell.statusLbl.text = "Redeemable"
        }
        
        
//        if self.VM.myEarningListArray[indexPath.row].behaviorId ?? 0 == 39{
//            cell.idNumberLbl.text = self.VM.myEarningListArray[indexPath.row].invoiceNo ?? ""
//        }else{
//            cell.idNumberLbl.text = self.VM.myEarningListArray[indexPath.row].remarks ?? ""
//        }
        
        
        
        if self.VM.myEarningListArray[indexPath.row].transactionType ?? "" == "BONUS"{
            cell.idNumberLbl.text = self.VM.myEarningListArray[indexPath.row].bonusName ?? ""
        }else{
            if self.VM.myEarningListArray[indexPath.row].transactionType ?? "" == "Referral"{
                cell.idNumberLbl.text = "Referral Complimentary".localiz()
            }else{
                if self.VM.myEarningListArray[indexPath.row].invoiceNo ?? "" == "--"{
                    //cell.idNumberLbl.text = "Reward Adjusted".localiz()
                    cell.idNumberLbl.text = self.VM.myEarningListArray[indexPath.row].remarks ?? ""
                    cell.idNumberLbl.textColor = .black
                }else{
                    cell.idNumberLbl.text = self.VM.myEarningListArray[indexPath.row].invoiceNo ?? ""
                    cell.idNumberLbl.textColor = .black
                }

            }
        }
   
        let transactionDate = String(self.VM.myEarningListArray[indexPath.row].jTranDate ?? "").split(separator: " ")
        cell.dateLbl.text = "\(transactionDate[0])"
        
        if self.VM.myEarningListArray[indexPath.row].behaviourName != " " {
            cell.programLbl.text = self.VM.myEarningListArray[indexPath.row].behaviourName ?? ""
        }else{
            cell.programLbl.text = "Bonus point"
        }
 
        return cell
    }
    
    
    
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
    
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == self.VM.myEarningListArray.count - 1{
//            if self.noofelements == 10{
//                self.startIndex = self.startIndex + 1
//                self.VM.myEarningListApi(startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
//            }else if self.noofelements > 10{
//                self.startIndex = self.startIndex + 1
//                self.VM.myEarningListApi(startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
//            }else if self.noofelements < 10{
//                print("no need to hit API")
//                return
//            }else{
//                print("n0 more elements")
//                return
//            }
//        }
//    }
}
