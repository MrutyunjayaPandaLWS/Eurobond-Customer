//
//  EBC_MyRedemptionVC.swift
//  EuroBond_Customer
//
//  Created by syed on 20/03/23.
//

import UIKit
import Toast_Swift
import LanguageManager_iOS
class EBC_MyRedemptionVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, DateSelectedDelegate, SelectedItemDelegate, popUpAlertDelegate{
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    func didSelectedItem(_ vc: HR_SelectionVC) {
        
        print(self.behaviourId, "adsfasdfasd")
        self.selectStatus.setTitle(vc.selectedTitle, for: .normal)
        self.selectStatus.setTitleColor(.black, for: .selected)
        
        
//
//        REDEMPTION_REQUEST_STATUS    0    Pending
//        REDEMPTION_REQUEST_STATUS    2    Processed
//        REDEMPTION_REQUEST_STATUS    4    Delivered
//        REDEMPTION_REQUEST_STATUS    3    Cancelled
//
//
//        REDEMPTION_REQUEST_STATUS    7    Returned
//        REDEMPTION_REQUEST_STATUS    8    Redispatched
//        REDEMPTION_REQUEST_STATUS    9    OnHold
//        REDEMPTION_REQUEST_STATUS    10    Dispatched
//        REDEMPTION_REQUEST_STATUS    11    Out for Delivery
//        REDEMPTION_REQUEST_STATUS    12    Address Verified
//        REDEMPTION_REQUEST_STATUS    13    Posted for approval
//        REDEMPTION_REQUEST_STATUS    14    Vendor Alloted
//        REDEMPTION_REQUEST_STATUS    15    Vendor Rejected
//        REDEMPTION_REQUEST_STATUS    16    Posted for approval 2
//        REDEMPTION_REQUEST_STATUS    17    Cancel Request
//        REDEMPTION_REQUEST_STATUS    18    Redemption Verified
//        REDEMPTION_REQUEST_STATUS    19    Delivery Confirmed
//        REDEMPTION_REQUEST_STATUS    20    Return Requested
//        REDEMPTION_REQUEST_STATUS    21    Return Pickup Schedule
//        REDEMPTION_REQUEST_STATUS    22    Picked Up
//        REDEMPTION_REQUEST_STATUS    23    Return Received
//        REDEMPTION_REQUEST_STATUS    24    In Transit
//        REDEMPTION_REQUEST_STATUS    1    Approved
//        REDEMPTION_REQUEST_STATUS    5    Rejected
//
//        REDEMPTION_REQUEST_STATUS    25    Recieved
        //["Pending","Processed","Delivered","Cancelled","Returned","Redispatched","OnHold","Dispatched","Out for Delivery","Address Verified","Posted for approval","Vendor Alloted","Vendor Rejected","Cancel Request","Redemption Verified","Delivery Confirmed","Return Requested","Return Pickup Schedule","Picked Up","Return Received","In Transit","Approved","Rejected"]
        
        if vc.selectedTitle == "Pending" {
            self.behaviourId = 0
        }else if vc.selectedTitle == "Processed"{
            self.behaviourId = 2
        }else if vc.selectedTitle == "Delivered"{
            self.behaviourId = 4
        }else if vc.selectedTitle == "Cancelled"{
            self.behaviourId = 3
        }else if vc.selectedTitle == "Returned"{
            self.behaviourId = 7
        }else if vc.selectedTitle == "Redispatched"{
            self.behaviourId = 8
        }else if vc.selectedTitle == "Dispatched"{
            self.behaviourId = 10
        }else if vc.selectedTitle == "Out for Delivery"{
            self.behaviourId = 11
        }else if vc.selectedTitle == "Address Verified"{
            self.behaviourId = 12
        }else if vc.selectedTitle == "Posted for approval"{
            self.behaviourId = 13
        }else if vc.selectedTitle == "Vendor Alloted"{
            self.behaviourId = 14
        }else if vc.selectedTitle == "Vendor Rejected"{
            self.behaviourId = 15
        }else if vc.selectedTitle == "Cancel Request"{
            self.behaviourId = 17
        }else if vc.selectedTitle == "Redemption Verified"{
            self.behaviourId = 18
        }else if vc.selectedTitle == "Delivery Confirmed"{
            self.behaviourId = 19
        }else if vc.selectedTitle == "Return Requested"{
            self.behaviourId = 20
        }else if vc.selectedTitle == "Return Pickup Schedule"{
            self.behaviourId = 21
        }else if vc.selectedTitle == "In Transit"{
            self.behaviourId = 24
        }else if vc.selectedTitle == "Approved"{
            self.behaviourId = 1
        }else if vc.selectedTitle == "Rejected"{
            self.behaviourId = 5
        }else if vc.selectedTitle == "Picked Up"{
            self.behaviourId = 22
        }else if vc.selectedTitle == "Return Received"{
            self.behaviourId = 23
        }else{
            self.behaviourId = 8
        }
        
    }
    
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

    
    
    @IBOutlet weak var myRedemptionTV: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var filterByCategoryHeight: NSLayoutConstraint!
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var filterByCategory: GradientButton!
    @IBOutlet weak var selectStatus: UIButton!
    @IBOutlet weak var fromDate: UIButton!
    @IBOutlet weak var toDate: UIButton!
    
    @IBOutlet weak var noDataFoundLbl: UILabel!
    var flags: String = "1"
    var selectedFromDate: String = ""
    var selectedToDate: String = ""
    var behaviourId = -1
    
    var VM = HR_MyRedemptionListVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        myRedemptionTV.delegate = self
        myRedemptionTV.dataSource = self
        self.noDataFoundLbl.isHidden = true
        self.noDataFoundLbl.text = "No Data Found".localiz()
        self.filterView.isHidden = true
        self.fromDate.setTitle("From Date".localiz(), for: .normal)
        self.toDate.setTitle("To Date".localiz(), for: .normal)
        self.filterByCategory.setTitle("Filter".localiz(), for: .normal)
        self.selectStatus.setTitle("Select Status".localiz(), for: .normal)
        localizlang()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "No Internet Connection".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            self.VM.cartCountApi()
            
            self.VM.getRedemptionListApi(customerId: self.userId)
            
        }
        
    }
    
    func localizlang(){
        self.titleLbl.text = "My Redemptions".localiz()
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        self.behaviourId = -1
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func filterBTN(_ sender: Any) {
        //self.behaviourId = -1
        if self.filterView.isHidden == true{
            self.filterView.isHidden = false
            self.filterByCategoryHeight.constant = 120
        }else{
            self.filterView.isHidden = true
            self.filterByCategoryHeight.constant = 0
        }
        
    }
    
    @IBAction func selectStatusBTN(_ sender: Any) {

        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_SelectionVC") as! HR_SelectionVC
        vc.isComeFrom = 6
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func filterByCateogryBTN(_ sender: Any) {
        
        if self.fromDate.currentTitle == "From Date".localiz() && self.toDate.currentTitle == "To Date".localiz() && self.selectStatus.currentTitle == "Select Status".localiz(){
            DispatchQueue.main.async{
               let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
               vc!.delegate = self
               vc!.titleInfo = ""
                vc!.descriptionInfo = "Select Date Range".localiz()
               vc!.modalPresentationStyle = .overCurrentContext
               vc!.modalTransitionStyle = .crossDissolve
               self.present(vc!, animated: true, completion: nil)
            }
        }else if self.fromDate.currentTitle == "From Date".localiz() && self.toDate.currentTitle == "To Date".localiz() && self.selectStatus.currentTitle != "Select Status".localiz(){
            
            self.VM.getRedemptionListApi(customerId: self.userId)
        }else if self.fromDate.currentTitle != "From Date".localiz() && self.toDate.currentTitle == "To Date".localiz() {
            DispatchQueue.main.async{
               let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
               vc!.delegate = self
               vc!.titleInfo = ""
                vc!.descriptionInfo = "Select To Date".localiz()
               vc!.modalPresentationStyle = .overCurrentContext
               vc!.modalTransitionStyle = .crossDissolve
               self.present(vc!, animated: true, completion: nil)
            }
        }else if self.fromDate.currentTitle == "From Date".localiz() && self.toDate.currentTitle != "To Date".localiz(){
            DispatchQueue.main.async{
               let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
               vc!.delegate = self
               vc!.titleInfo = ""
                vc!.descriptionInfo = "Select From Date".localiz()
               vc!.modalPresentationStyle = .overCurrentContext
               vc!.modalTransitionStyle = .crossDissolve
               self.present(vc!, animated: true, completion: nil)
            }
        }else if self.fromDate.currentTitle != "From Date".localiz() && self.toDate.currentTitle != "To Date".localiz() && self.selectStatus.currentTitle == "Select Status".localiz() || self.selectStatus.currentTitle != "Select Status".localiz(){
            if selectedToDate < selectedFromDate{
                DispatchQueue.main.async{
                   let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                   vc!.delegate = self
                   vc!.titleInfo = ""
                    vc!.descriptionInfo = "To Date should be greater than From Date".localiz()
                   vc!.modalPresentationStyle = .overCurrentContext
                   vc!.modalTransitionStyle = .crossDissolve
                   self.present(vc!, animated: true, completion: nil)
                }
            }else if self.fromDate.currentTitle == "From Date".localiz() && self.toDate.currentTitle == "To Date".localiz() && self.selectStatus.currentTitle != "Select Status".localiz(){
               
                self.VM.getRedemptionListApi(customerId: self.userId)
               
            }else{
                //Api
                self.VM.getRedemptionListApi(customerId: self.userId)
            }
        }
        
        
        
    }
    @IBAction func fromDateBTN(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DateFilterVC") as! EBC_DateFilterVC
        vc.isComeFrom = "1"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    @IBAction func toDateBTN(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DateFilterVC") as! EBC_DateFilterVC
        vc.isComeFrom = "2"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myredemptionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_MyRedemptionTVC", for: indexPath) as! EBC_MyRedemptionTVC
        cell.selectionStyle = .none
        cell.productNameLbl.text = self.VM.myredemptionArray[indexPath.row].productName ?? ""
        cell.refNoLbl.text = "\("RefNo".localiz())" + "\(" ")" + "\(self.VM.myredemptionArray[indexPath.row].redemptionRefno ?? "")"
        cell.productCategoryLbl.text = "Category".localiz() + "\(self.VM.myredemptionArray[indexPath.row].categoryName ?? "-")"
        cell.eurosUsedLbl.text = "\(Int(self.VM.myredemptionArray[indexPath.row].redemptionPoints ?? 0))"
        let redemptionDate = String(self.VM.myredemptionArray[indexPath.row].jRedemptionDate ?? "-").split(separator: " ")
        print(redemptionDate[0])
        cell.dateLbl.text = "\(redemptionDate[0])"
        cell.qtyLbl.text = "Qty \(self.VM.myredemptionArray[indexPath.row].quantity ?? 0)"
        if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 0{
            cell.statusLbl.text = "  Pending  "
            cell.statusLbl.textColor = UIColor.black
            cell.statusView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell.statusView.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 2 {
            cell.statusLbl.text = "  Processed  "
            cell.statusLbl.textColor = UIColor.black
            cell.statusView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell.statusView.borderColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 3 {
            cell.statusLbl.text = "  Cancelled  "
            cell.statusLbl.textColor = UIColor.white
            cell.statusView.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            cell.statusView.borderColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 4 {
            cell.statusLbl.text = "  Delivered  "
            cell.statusLbl.textColor = UIColor.white
            cell.statusView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.statusView.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 5 {
            cell.statusLbl.text = "  Rejected  "
            cell.statusLbl.textColor = UIColor.white
            cell.statusView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            cell.statusView.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 7 {
            cell.statusLbl.text = "  Returned  "
            cell.statusLbl.textColor = UIColor.white
            cell.statusView.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            cell.statusView.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 8 {
            cell.statusLbl.text = "  Redispatched  "
            cell.statusLbl.textColor = UIColor.white
            cell.statusView.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            cell.statusView.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 9 {
            cell.statusLbl.text = "  OnHold "
            cell.statusLbl.textColor = UIColor.black
            cell.statusView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell.statusView.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 10 {
            cell.statusLbl.text = "  Dispatched  "
            cell.statusLbl.textColor = UIColor.white
            cell.statusView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.statusView.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 11 {
            cell.statusLbl.text = "  Out for Delivery  "
            cell.statusView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.statusView.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell.statusLbl.textColor = UIColor.white
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 12 {
            cell.statusLbl.text = "  Address Verified  "
            cell.statusView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell.statusLbl.textColor = UIColor.black
            cell.statusView.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 13 {
            cell.statusLbl.text = "  Posted for approval  "
            cell.statusLbl.textColor = UIColor.white
            cell.statusView.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            cell.statusView.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 14 {
            cell.statusLbl.text = "  Vendor Alloted  "
            cell.statusView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell.statusLbl.textColor = UIColor.black
            cell.statusView.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 15 {
            cell.statusLbl.text = "  Vendor Rejected  "
            cell.statusLbl.textColor = UIColor.white
            cell.statusView.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            cell.statusView.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
//        else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 16 {
//            cell.statusLbl.text = "  Posted for approval 2  "
//            cell.statusLbl.textColor = UIColor.white
//            cell.statusView.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
//            cell.statusView.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
//        }
        else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 17 {
            cell.statusLbl.text = "  Cancel Request  "
            cell.statusView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell.statusLbl.textColor = UIColor.black
            cell.statusView.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 18 {
            cell.statusLbl.text = "  Redemption Verified  "
            cell.statusView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.statusView.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell.statusLbl.textColor = UIColor.white
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 19 {
            cell.statusLbl.text = "  Delivery Confirmed  "
            cell.statusView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.statusView.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell.statusLbl.textColor = UIColor.white
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 20 {
            cell.statusLbl.text = "  Return Requested  "
            cell.statusView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell.statusLbl.textColor = UIColor.black
            cell.statusView.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 21 {
            cell.statusLbl.text = "  Return Pick Up Schedule  "
            cell.statusView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell.statusLbl.textColor = UIColor.black
            cell.statusView.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 22 {
            cell.statusLbl.text = "  Picked Up "
            cell.statusView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell.statusLbl.textColor = UIColor.black
            cell.statusView.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 23 {
            cell.statusLbl.text = "  Return Received  "
            cell.statusView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.statusView.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell.statusLbl.textColor = UIColor.white
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 24 {
            cell.statusLbl.text = "  In Transit  "
            cell.statusView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.statusView.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell.statusLbl.textColor = UIColor.white
        }else{
            cell.statusLbl.text = "  -  "
            cell.statusView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.statusLbl.textColor = UIColor.white
            cell.statusView.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }
        let imageURL = self.VM.myredemptionArray[indexPath.row].productImage ?? ""
        print(imageURL)
        if imageURL != ""{
            let urltoUse = String(productCatalogueImgURL + imageURL).replacingOccurrences(of: " ", with: "%20")
            let urlt = URL(string: "\(urltoUse)")
            cell.redemptionImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "dashboardLogo"))
        }else{
            cell.redemptionImage.image = UIImage(named: "dashboardLogo")
        }
        return cell
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HRD_MyRedemptionDetailsVC") as! HRD_MyRedemptionDetailsVC
//        self.filterView.isHidden = true
//        vc.categoryName = self.VM.myredemptionArray[indexPath.item].categoryName ?? ""
//        vc.totalPoint = "\(self.VM.myredemptionArray[indexPath.item].pointsPerUnit ?? 0)"
//        vc.productName = self.VM.myredemptionArray[indexPath.item].productName ?? ""
//        vc.quantity = "\(self.VM.myredemptionArray[indexPath.item].quantity ?? 0)"
//        vc.productImage = self.VM.myredemptionArray[indexPath.item].productImage ?? ""
//        vc.redemptionRefNo = self.VM.myredemptionArray[indexPath.item].redemptionRefno ?? ""
//        vc.descDetails = self.VM.myredemptionArray[indexPath.item].productDesc ?? ""
//        vc.termsandContions = self.VM.myredemptionArray[indexPath.item].termsCondition ?? ""
//        vc.redemptionPoints = "\(self.VM.myredemptionArray[indexPath.item].redemptionPoints ?? 0)"
//        vc.status = "\(self.VM.myredemptionArray[indexPath.item].status ?? 0)"
//        let strDate = self.VM.myredemptionArray[indexPath.row].jRedemptionDate ?? "01/01/0001  00:00:00"
//        print(strDate)
//        let array = strDate.components(separatedBy: " ")
//        print(array[0])
//        //        let inputFormatter = DateFormatter()
//        //        inputFormatter.dateFormat = "MM/dd/yyyy"
//        //        let outputFormatter = DateFormatter()
//        //        outputFormatter.dateFormat = "dd/MM/yyyy"
//        //        let showDate = inputFormatter.date(from: array[0])!
//        //        let resultString = outputFormatter.string(from: showDate)
//        //vc.redemptionsDate = "\(resultString)"
//
//        vc.redemptionsDate = "\(array[0])"
//        vc.redemptionsstatus = String(self.VM.myredemptionArray[indexPath.row].status ?? 0) ?? ""
//
//       // vc.cartCounts = self.cartCount.text!
//        vc.redemptionId = "\(self.VM.myredemptionArray[indexPath.item].redemptionId ?? 0)"
//        self.navigationController?.pushViewController(vc, animated: true)
//    }

    
    
}
