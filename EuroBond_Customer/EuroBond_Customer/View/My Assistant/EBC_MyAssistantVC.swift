//
//  EBC_MyAssistantVC.swift
//  EuroBond_Customer
//
//  Created by admin on 31/03/23.
//

import UIKit

class EBC_MyAssistantVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, MyAssistantTVCDelegate, UpdatePasswordVCDelegate, DateSelectedDelegate{
    func acceptDate(_ vc: EBC_DateFilterVC) {
        if vc.isComeFrom == "1"{
            self.selectedFromDate = vc.selectedDate
            self.fromDateLbl.text = vc.selectedDate
            self.fromDateLbl.textColor = .darkGray
        }else{
            self.selectedToDate = vc.selectedDate
            print(vc.selectedDate)
            if self.selectedFromDate > self.selectedToDate{
                self.view.makeToast("To Date should be greater than From Date", duration: 2.0, position: .center)
            }else{
                self.toDateLbl.text = vc.selectedDate
                self.toDateLbl.textColor = .darkGray
            }
        }
    }
    
    func declineDate(_ vc: EBC_DateFilterVC) {}

    
    func showSusccesMessage(item: EBC_UpdatePasswordVC) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_SuccessMessageVC1") as? EBC_SuccessMessageVC1
        vc?.message = "Password Updated!"
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!, animated: true)
    }
    
    func didTappedResetPassword(_ cell: EBC_MyAssistantTVC) {
        guard let tappedIndexPath = myAssistantTV.indexPath(for: cell) else{return}
        if cell.updatePwdBtn.tag == tappedIndexPath.row{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_UpdatePasswordVC") as? EBC_UpdatePasswordVC
            vc?.mobile = self.VM.myAssistantArrayList[tappedIndexPath.row].mobile ?? ""
            vc?.userLoyaltyId = self.VM.myAssistantArrayList[tappedIndexPath.row].loyaltyID ?? ""
            vc?.name = self.VM.myAssistantArrayList[tappedIndexPath.row].firstName ?? ""
            vc?.modalTransitionStyle = .crossDissolve
            vc?.modalPresentationStyle = .overFullScreen
            present(vc!, animated: true)
        }
       
    }
    
    func didTappedDeactiveAccount(_ cell: EBC_MyAssistantTVC) {
        guard let tappedIndexPath = myAssistantTV.indexPath(for: cell) else{return}
        if cell.deactivateBtn.tag == tappedIndexPath.row{
                
                    if self.VM.myAssistantArrayList[tappedIndexPath.row].isActive ?? -1 == 1{
                        let alert = UIAlertController(title: "Are you sure ?", message: "You want to deactivate your Fabricator Assistant account.", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
                        let parameter = [
                            "ActionType": "5",
                            "userid": self.userId,//Currently Logged user id
                            "CustomerId": self.VM.myAssistantArrayList[tappedIndexPath.row].userID ?? -1,//Fabricator Helper user id
                            "IsActive": 1
                        ] as [String: Any]
                        print(parameter)
                        self.VM.deactivateExecutiveApi(parameter: parameter)
                        }))
                            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        let alert = UIAlertController(title: "Are you sure ?", message: "You want to activate your Fabricator Assistant account.", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
                        let parameter = [
                            "ActionType": "5",
                            "userid": self.userId,//Currently Logged user id
                            "CustomerId": self.VM.myAssistantArrayList[tappedIndexPath.row].userID ?? -1,//Fabricator Helper user id
                            "IsActive": "false"
                        ] as [String: Any]
                        print(parameter)
                        self.VM.deactivateExecutiveApi(parameter: parameter)
                        }))
                            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
            
        }
        
        
    }
  
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var noDataFoundLbl: UILabel!
    @IBOutlet weak var filterViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var myAssistantTV: UITableView!
    @IBOutlet weak var titleVC: UILabel!
    
    @IBOutlet weak var filterButton: GradientButton!
    
    @IBOutlet weak var accountStatus: UILabel!
    @IBOutlet weak var selectStatus: UILabel!
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var fromDateLbl: UILabel!
    var flags = "1"
    var VM = EBC_MyAssistantVM()
    var startIndex = 1
    var searchText = ""
    var selectedFromDate = ""
    var selectedToDate = ""
    var noofelements = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.popView.isHidden = true
        myAssistantTV.delegate = self
        myAssistantTV.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(apiCall), name: Notification.Name.moveToPrevious, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(popUpCall), name: Notification.Name.passwordUpdated, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noDataFoundView.isHidden = true
        self.myAssistantApi(StartIndex: 1, searchText: self.searchText, FromDate: self.selectedFromDate, ToDate: self.selectedToDate)
        self.filterViewHeightConstraint.constant = 0
        self.filterView.isHidden = true
    }
    
    @objc func apiCall(){
        self.myAssistantApi(StartIndex: 1, searchText: self.searchText, FromDate: self.selectedFromDate, ToDate: self.selectedToDate)
        self.filterViewHeightConstraint.constant = 0
        self.filterView.isHidden = true
    }
    
    @objc func popUpCall(){
        self.popView.isHidden = false
        self.accountStatus.text = "Password is updated"
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0, execute: {
            self.popView.isHidden = true
            self.VM.myAssistantArrayList.removeAll()
            self.startIndex = 1
            self.selectedFromDate = ""
            self.selectedToDate = ""
            self.myAssistantApi(StartIndex: 1, searchText: self.searchText, FromDate: self.selectedFromDate, ToDate: self.selectedToDate)
            self.filterViewHeightConstraint.constant = 0
            self.filterView.isHidden = true
        })
       
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func selectFilterBtnn(_ sender: Any) {
        if filterView.isHidden == false{
            self.filterViewHeightConstraint.constant = 0
            self.filterView.isHidden = true
        }else{
            self.filterViewHeightConstraint.constant = 110
            self.filterView.isHidden = false
        }
        
    }
    
    @IBAction func selectAddBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RegisterAssistantVC") as? EBC_RegisterAssistantVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!, animated: true)
    }
    @IBAction func filterButtonAction(_ sender: Any) {
        //        self.filterButton.setTitle("Filter", for: .normal)
                if self.filterButton.currentTitle == "Filter"{
                   
                    if self.selectedFromDate == "" && self.selectedToDate == ""{
                        self.view.makeToast("Select date range", duration: 2.0, position: .center)
                    }else if self.selectedFromDate == ""{
                        self.view.makeToast("Select From Date", duration: 2.0, position: .center)
                    }else if self.selectedToDate == ""{
                        self.view.makeToast("Select To Date", duration: 2.0, position: .center)
                    }else if self.selectedFromDate > self.selectedToDate{
                        self.view.makeToast("To Date should be greater than From Date", duration: 2.0, position: .center)
                    }else{
                        self.filterButton.setTitle("Reset", for: .normal)
                        self.VM.myAssistantArrayList.removeAll()
                        self.startIndex = 1
                        self.myAssistantApi(StartIndex: startIndex, searchText: "", FromDate: selectedFromDate, ToDate: selectedToDate)
                    }
                }else{
                        self.filterButton.setTitle("Filter", for: .normal)
                    self.fromDateLbl.text = "From Date"
                    self.toDateLbl.text = "To Date"
                        self.VM.myAssistantArrayList.removeAll()
                        self.startIndex = 1
                        self.selectedFromDate = ""
                        self.selectedToDate = ""
                    self.myAssistantApi(StartIndex: startIndex, searchText: "", FromDate: selectedFromDate, ToDate: selectedToDate)
                }
               
            }
    @IBAction func toDateButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DateFilterVC") as! EBC_DateFilterVC
        vc.isComeFrom = "2"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func fromDateButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DateFilterVC") as! EBC_DateFilterVC
        vc.isComeFrom = "1"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func selectStatusButton(_ sender: Any) {
    }
    
    
    func myAssistantApi(StartIndex: Int, searchText: String, FromDate: String, ToDate: String){
        
        let parameter = [
            "ActionType": 18,
            "ActorId": self.userId,
             "StartIndex": StartIndex,
             "PageSize": 10,
            "SearchText": searchText,
             "JDateFrom": FromDate,
             "JDateTo": ToDate
        ] as [String: Any]
        self.VM.myAssistantList(parameter: parameter)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.VM.myAssistantArrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_MyAssistantTVC", for: indexPath) as! EBC_MyAssistantTVC
        cell.selectionStyle = .none
        cell.delegate = self
        cell.mobileNumberLbl.text = self.VM.myAssistantArrayList[indexPath.row].mobile ?? ""
        cell.updatePwdBtn.tag = indexPath.row
        cell.deactivateBtn.tag = indexPath.row
        if self.VM.myAssistantArrayList[indexPath.row].isActive ?? -1 == 1{
            cell.statusLbl.text = "Active"
            cell.statusLbl.textColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        }else{
            cell.statusLbl.text = "In-Active"
            
            cell.statusLbl.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
        cell.enrollmentDateLbl.text = self.VM.myAssistantArrayList[indexPath.row].enrollmentDate ?? ""
        cell.supporterNameLbl.text = self.VM.myAssistantArrayList[indexPath.row].firstName ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.row == self.VM.myAssistantArrayList.count - 1{
                if self.noofelements == 10{
                    self.startIndex = self.startIndex + 1
                    self.myAssistantApi(StartIndex: self.startIndex, searchText: self.searchText, FromDate: self.selectedFromDate, ToDate: self.selectedToDate)
                }else if self.noofelements > 10{
                    
                    self.startIndex = self.startIndex + 1
                    self.myAssistantApi(StartIndex: self.startIndex, searchText: self.searchText, FromDate: self.selectedFromDate, ToDate: self.selectedToDate)
                }else if self.noofelements < 10{
                    print("no need to hit API")
                    return
                }else{
                    print("n0 more elements")
                    return
                }
            }
       }
    
}
