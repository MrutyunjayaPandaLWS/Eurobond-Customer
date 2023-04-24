//
//  CodeStatusListVC.swift
//  CenturyPly_JSON
//
//  Created by ADMIN on 28/04/2022.
//

import UIKit
import CoreData
import Firebase

class CodeStatusListVC: BaseViewController, CheckBoxSelectionDelegate, FilterDelegate {
   
     
    @IBOutlet weak var headerText: UILabel!
    @IBOutlet weak var syncStatusView: UIStackView!
    @IBOutlet weak var headerCheckBox: UIButton!
    @IBOutlet weak var headerFilter: UIButton!
    @IBOutlet weak var headerQuestionMark: UIButton!
    @IBOutlet weak var headerNotes: UIButton!
    @IBOutlet weak var codeStatusBTN: UIButton!
    @IBOutlet weak var syncStatusBTN: UIButton!
    @IBOutlet weak var codeStatusListTableView: UITableView!
    @IBOutlet weak var nodatafound: UILabel!
    @IBOutlet weak var back: UIButton!
    
    var selectedDataArray = [SelectedCodeModels]()
    var codeLIST:Array = [ScanCodeSTORE]()
    var uploadedCodes:Array = [UploadedCodes]()
    var codesCollectionsArray = [SelectedCodeModels]()
    var VM = SyncStatusViewModel()
    var selectedFromDate = ""
    var selectedToDate = ""
    var enableToNavigate = 0
    var selectedAllProduct = 1
    var isSelected = 0
    var itsFrom = 0
    var querySummary = [String]()
    var fromSideMenu = ""
    var receivedStatus = ""
    var receivedStatusId = 0
    var statusListingArray = ["All Status","Valid Code","In-Valid Code","Code is busy","Success and points credited","Technical issue","Invalid length","Invalid member","Success but points not credited","Code Generated","Code Mapped","QR Code is not available for your location","Code Already scanned by you","Code Already used by others","You are not entitled for this product to bank"]
    var statusIDListingArray = [-1,1,2,4,5,6,7,8,9,10,11,14,18,19,20]
    var statusImageListingArray = ["sand_clock","ic_status_success","ic_status_reject","ic_status_code_is_busy","success_and_point_credited","ic_status_technical_issue","invalid_length","invalid_member","ic_status_success_but_points_not_credited","ic_status_code_generated","ic_status_code_mapped","ic_status_qr_code_is_not_available_for_your_location","code_already_banked_by_you","code_already_banked_by_others"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
   
        codeStatusListTableView.delegate = self
        codeStatusListTableView.dataSource = self
//        NotificationCenter.default.addObserver(self, selector: #selector(fromQuerySubmission), name: Notification.Name.comeBackStatus, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.codesCollectionsArray.removeAll()
        self.nodatafound.isHidden = true
//        self.codeStatusBTN.backgroundColor =  UIColor(red: 192/255, green: 7/255, blue: 34/255, alpha: 1.0)
//        self.syncStatusBTN.backgroundColor =  UIColor(red: 92/255, green: 92/255, blue: 109/255, alpha: 1.0)
        self.isSelected = 1
        self.syncStatusView.isHidden = true
        fetchDetails()
        languagelocalization()
        self.querySummary.removeAll()
        self.headerCheckBox.setImage(UIImage(named: "rectangle-2"), for: .normal)
        
        self.codeStatusBTN.backgroundColor =  #colorLiteral(red: 0, green: 0.431829989, blue: 0.7325050235, alpha: 1)
        self.codeStatusBTN.setImage(UIImage(named: "qr 1"), for: .normal)
        self.codeStatusBTN.setTitleColor(.white, for: .normal)
        
        self.syncStatusBTN.backgroundColor =  #colorLiteral(red: 0.9064666033, green: 0.9463894963, blue: 0.9929038882, alpha: 1)
        self.syncStatusBTN.setImage(UIImage(named: "sync 1"), for: .normal)
        self.syncStatusBTN.setTitleColor(#colorLiteral(red: 0.02352941176, green: 0.2274509804, blue: 0.5333333333, alpha: 1), for: .normal)
        self.isSelected = 1
        self.syncStatusView.isHidden = true
        fetchDetails()
        

          
    }
    
    @objc func fromQuerySubmission(){
        self.codesCollectionsArray.removeAll()
//        self.codeStatusBTN.backgroundColor =  UIColor(red: 192/255, green: 7/255, blue: 34/255, alpha: 1.0)
//
//        self.syncStatusBTN.backgroundColor =  UIColor(red: 92/255, green: 92/255, blue: 109/255, alpha: 1.0)
        self.codeStatusBTN.backgroundColor =  #colorLiteral(red: 0, green: 0.431829989, blue: 0.7325050235, alpha: 1)
        self.codeStatusBTN.setImage(UIImage(named: "qr 1"), for: .normal)
        self.codeStatusBTN.setTitleColor(.white, for: .normal)
        
        self.syncStatusBTN.backgroundColor =  #colorLiteral(red: 0.9064666033, green: 0.9463894963, blue: 0.9929038882, alpha: 1)
        self.syncStatusBTN.setImage(UIImage(named: "sync 1"), for: .normal)
        self.syncStatusBTN.setTitleColor(#colorLiteral(red: 0.02352941176, green: 0.2274509804, blue: 0.5333333333, alpha: 1), for: .normal)
        self.isSelected = 1
        self.syncStatusView.isHidden = true
        fetchDetails()
    }
   
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.headerText.text = "Code Status"
            self.codeStatusBTN.setTitle(" Code Status", for: .normal)
            self.syncStatusBTN.setTitle(" Sync Status", for: .normal)
            self.nodatafound.text = "No Data Found !!"
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.headerText.text = "कोड स्थिति"
            self.codeStatusBTN.setTitle(" कोड स्थिति", for: .normal)
            self.syncStatusBTN.setTitle(" सिंक स्थिति", for: .normal)
            self.nodatafound.text = "डेटा नहीं मिला !!"
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.headerText.text = "কোড স্ট্যাটাস"
            self.codeStatusBTN.setTitle(" কোড স্ট্যাটাস", for: .normal)
            self.syncStatusBTN.setTitle(" সিঙ্ক স্থিতি", for: .normal)
            self.nodatafound.text = "কোন তথ্য পাওয়া যায়নি!!"
            
        }else{
            self.headerText.text = "Code Status"
            self.codeStatusBTN.setTitle(" Code Status", for: .normal)
            self.syncStatusBTN.setTitle(" Sync Status", for: .normal)
            self.nodatafound.text = "No Data Found !!"
            
        }
    }
    
    @IBAction func headerCheckBoxBTN(_ sender: Any) {
        
        if self.headerCheckBox.currentImage == UIImage(named: "check-box") {
            self.codesCollectionsArray.removeAll()
            self.querySummary.removeAll()
            for data in self.selectedDataArray{
                data.isSelected = 0
                self.enableToNavigate = 0
                self.selectedAllProduct = 1
                self.headerQuestionMark.isHidden = true
                self.headerNotes.isHidden = true
                self.codesCollectionsArray.append(SelectedCodeModels(uplodedCode: data.uploadedCode, codeStatus: data.codeStatus, codeUploadedDate: data.codeUploadedDate, isSelected: data.isSelected))
            }
            self.headerCheckBox.setImage(UIImage(named: "rectangle-2"), for: .normal)
        } else {
            self.codesCollectionsArray.removeAll()
            self.querySummary.removeAll()
            for data in self.selectedDataArray{
                data.isSelected = 1
                self.selectedAllProduct = 1
                self.enableToNavigate = 1
                self.headerQuestionMark.isHidden = false
                self.headerNotes.isHidden = false
                self.codesCollectionsArray.append(SelectedCodeModels(uplodedCode: data.uploadedCode, codeStatus: data.codeStatus, codeUploadedDate: data.codeUploadedDate, isSelected: data.isSelected))
                print(self.codesCollectionsArray.count, "Codes CollectionV")
                
                
              
            }
            for data in self.codesCollectionsArray{
                self.querySummary.append(data.uploadedCode)
            }
            print(self.querySummary.count, "Query Summary")
        
            self.headerCheckBox.setImage(UIImage(named: "check-box"), for: .normal)
        }
        self.codeStatusListTableView.reloadData()
    }
    @IBAction func headerFilterBTN(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FilterPopUpViewController") as! FilterPopUpViewController
        vc.delegate = self
        vc.itsFrom = "FilterByStatus"
        vc.selectedStatusName = self.receivedStatus
        vc.selectedStatusId = self.receivedStatusId
        vc.selectedFromDate = self.selectedFromDate
        vc.selectedToDate = self.selectedToDate
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    @IBAction func headerQuestionMarkBTN(_ sender: Any) {

            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_CreatenewQueryVC") as! EBC_CreatenewQueryVC
            vc.selectedCodesArray.removeAll()
            vc.selectedCodesArray = self.querySummary
            vc.isFrom = 21
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)

        
    }
    @IBAction func headerNotesBTN(_ sender: Any) {
        if itsFrom == 1{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CodeSummary_VC") as! CodeSummary_VC
                vc.itsFrom = 1
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)

            
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CodeSummary_VC") as! CodeSummary_VC
            vc.itsFrom = 2
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    @IBAction func backBTN(_ sender: Any) {
        if itsFrom == 1{
            self.dismiss(animated: true)
                NotificationCenter.default.post(name: .goToParticularVc, object: nil)
            
        }else{
            if self.fromSideMenu == "SideMenu"{
                NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
                self.navigationController?.popViewController(animated: true)
            }else{
                self.navigationController?.popViewController(animated: true)
                  }
        }
        
    }

    @IBAction func codeStatusListBTN(_ sender: Any) {
        self.codesCollectionsArray.removeAll()
        
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.headerText.text = "Code Status"
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.headerText.text = "कोड स्थिति"
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.headerText.text = "কোড স্ট্যাটাস"
            
        }else{
            self.headerText.text = "Code Status"
            
        }
        self.codeStatusBTN.backgroundColor =  #colorLiteral(red: 0, green: 0.431829989, blue: 0.7325050235, alpha: 1)
        self.codeStatusBTN.setImage(UIImage(named: "qr 1"), for: .normal)
        self.codeStatusBTN.setTitleColor(.white, for: .normal)
        
        self.syncStatusBTN.backgroundColor =  #colorLiteral(red: 0.9064666033, green: 0.9463894963, blue: 0.9929038882, alpha: 1)
        self.syncStatusBTN.setImage(UIImage(named: "sync 1"), for: .normal)
        self.syncStatusBTN.setTitleColor(#colorLiteral(red: 0.02352941176, green: 0.2274509804, blue: 0.5333333333, alpha: 1), for: .normal)
        self.isSelected = 1
        self.syncStatusView.isHidden = true
        fetchDetails()
    
    }
    @IBAction func syncStatusListBTN(_ sender: Any) {
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.headerText.text = "Syc Status"
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.headerText.text = "सिंक स्थिति"
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.headerText.text = "সিঙ্ক স্থিতি"
            
        }else{
            self.headerText.text = "Syc Status"
            
        }
        self.codeStatusBTN.backgroundColor =  #colorLiteral(red: 0.9064666033, green: 0.9463894963, blue: 0.9929038882, alpha: 1)
        
        self.codeStatusBTN.setImage(UIImage(named: "qr"), for: .normal)
        self.codeStatusBTN.setTitleColor(#colorLiteral(red: 0.02352941176, green: 0.2274509804, blue: 0.5333333333, alpha: 1), for: .normal)
        
        self.syncStatusBTN.backgroundColor =  #colorLiteral(red: 0, green: 0.431829989, blue: 0.7325050235, alpha: 1)
        self.syncStatusBTN.setImage(UIImage(named: "sync"), for: .normal)
        self.syncStatusBTN.setTitleColor(.white, for: .normal)
        
        
//        self.syncStatusBTN.backgroundColor =  UIColor(red: 192/255, green: 7/255, blue: 34/255, alpha: 1.0)
//        self.codeStatusBTN.backgroundColor =  UIColor(red: 92/255, green: 92/255, blue: 109/255, alpha: 1.0)
        syncCodeLists()
        self.isSelected = 2
//        let filterArray = self.selectedDataArray.filter{ $0.isSelected == 1}
//        if filterArray.count > 1{
//            self.headerCheckBox.setImage(UIImage(named: "tickBox"), for: .normal)
//        }else{
            self.headerCheckBox.setImage(UIImage(named: "rectangle-2"), for: .normal)
//        }
        self.syncStatusView.isHidden = false
        self.headerQuestionMark.isHidden = true
        self.headerNotes.isHidden = true
        fetchDetails()
        
    }
    
    //Delegate:-
    
    func selectedDateRange(_ vc: FilterPopUpViewController) {
        self.receivedStatus = vc.selectedStatusName
        self.receivedStatusId = vc.selectedStatusId
        self.selectedFromDate = vc.selectedFromDate
        self.selectedToDate = vc.selectedToDate
        let parameters = ["ActionType":210,"MemberID":"\(loyaltyId)","QrCodeStatusID":vc.selectedStatusId,"FromDate":"\(vc.selectedFromDate)","ToDate":"\(vc.selectedToDate)"] as [String : Any]
        print(parameters)
      //  self.VM.syncCodeArray.removeAll()
        self.selectedDataArray.removeAll()
        self.codesCollectionsArray.removeAll()
        self.VM.syncStatusListingAPI(parameters: parameters)
    }
    
    func checkBoxSelection(_ cell: CodeStatusTVC) {
        guard let tappedIndexPath = codeStatusListTableView.indexPath(for: cell) else{return}
        if cell.checkBoxBTN.tag == tappedIndexPath.row{
            if cell.checkBoxBTN.currentImage == UIImage(named: "tickBox"){
                self.codesCollectionsArray[tappedIndexPath.row].isSelected = 0
                cell.checkBoxBTN.setImage(UIImage(named: "unchecked-2"), for: .normal)
                let filterArray = self.codesCollectionsArray.filter{$0.isSelected == 1}
                if let index = self.querySummary.firstIndex(of: self.codesCollectionsArray[tappedIndexPath.row].uploadedCode ?? ""){
                    self.querySummary.remove(at: index)
                }
                if filterArray.count > 0{
                    self.headerQuestionMark.isHidden = false
                    self.headerNotes.isHidden = false
                }else{
                    self.headerQuestionMark.isHidden = true
                    self.headerNotes.isHidden = true
                }
                self.headerCheckBox.setImage(UIImage(named: "rectangle-2"), for: .normal)
                print("After Remove Selected Query", self.querySummary.count)
            }else{
                cell.checkBoxBTN.setImage(UIImage(named: "tickBox"), for: .normal)
                self.codesCollectionsArray[tappedIndexPath.row].isSelected = 1
                let filterArray = self.codesCollectionsArray.filter{$0.isSelected == 0}
                self.querySummary.append(self.codesCollectionsArray[tappedIndexPath.row].uploadedCode ?? "")
                print("Selected Query", self.querySummary.count)
                if filterArray.count > 0{
                    self.headerQuestionMark.isHidden = false
                    self.headerNotes.isHidden = false
                    self.headerCheckBox.setImage(UIImage(named: "rectangle-2"), for: .normal)
                    
                }else{
                    self.headerQuestionMark.isHidden = false
                    self.headerNotes.isHidden = false
                    self.headerCheckBox.setImage(UIImage(named: "tickBox"), for: .normal)
                    
                }
               
            }
        }
        self.codeStatusListTableView.reloadData()
    }
    
    //Api:-
    
    func syncCodeLists(){
        let parameters = [
            "ActionType": 210,
               "MemberID": "\(loyaltyId)",
               "QrCodeStatusID": -1
        ] as [String: Any]
        print(parameters)
        self.VM.syncStatusListingAPI(parameters: parameters)
    }
    
    func fetchDetails(){
        let fetchRequest:NSFetchRequest<UploadedCodes> = UploadedCodes.fetchRequest()
        do{
            self.uploadedCodes = try persistanceservice.context.fetch(fetchRequest)
            print(self.uploadedCodes.count, "Count")

            if self.uploadedCodes.count != 0{
                
                
                self.codeStatusListTableView.isHidden = false
                self.nodatafound.isHidden = true
                self.codeStatusListTableView.reloadData()
                
            }else{
                self.nodatafound.isHidden = false
                self.codeStatusListTableView.isHidden = true
                
            }

        }catch{
            print("error while fetching data")
        }
    }
    
    
}
extension CodeStatusListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSelected == 1{
            return self.uploadedCodes.count
        }else{
            return self.codesCollectionsArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CodeStatusTVC") as? CodeStatusTVC
        cell?.selectionStyle = .none
        
        if self.isSelected == 1{
            cell?.viewTrailingSpaceConstrant.constant = 8
            cell?.checkBoxBTN.isHidden = true
            cell?.uploadCode.text = self.uploadedCodes[indexPath.row].code ?? ""

            cell?.uploadedDate.text = self.uploadedCodes[indexPath.row].date ?? ""
            if uploadedCodes[indexPath.row].codeStatus ?? "" == "1"{
                cell?.codeStatusMsg.text = "Valid code"
                cell?.codeStatusImage.image = UIImage(named: "ic_status_success")
                cell?.codeStatusMsg.textColor = UIColor(red: 54/255, green: 158/255, blue: 58/255, alpha: 1.0)
            }else if uploadedCodes[indexPath.row].codeStatus ?? "" == "0"{
                cell?.codeStatusMsg.text = "Pending"
                cell?.codeStatusImage.image = UIImage(named: "Pending")
                cell?.codeStatusMsg.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
            }else if uploadedCodes[indexPath.row].codeStatus ?? "" == "2"{
                cell?.codeStatusMsg.text = "In-Valid Code"
                cell?.codeStatusImage.image = UIImage(named: "ic_status_reject")
                cell?.codeStatusMsg.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
            }else if uploadedCodes[indexPath.row].codeStatus ?? "" == "3"{
                cell?.codeStatusMsg.text = "Code already used"
            }else if uploadedCodes[indexPath.row].codeStatus ?? "" == "4"{
                cell?.codeStatusMsg.text = "Code is busy"
                cell?.codeStatusImage.image = UIImage(named: "ic_status_code_is_busy")
                cell?.codeStatusMsg.textColor = UIColor(red: 35/255, green: 133/255, blue: 235/255, alpha: 1.0)
            }else if uploadedCodes[indexPath.row].codeStatus ?? "" == "5"{
                cell?.codeStatusMsg.text = "Success and points credited"
                cell?.codeStatusImage.image = UIImage(named: "success_and_point_credited")
                cell?.codeStatusMsg.textColor = UIColor(red: 54/255, green: 158/255, blue: 58/255, alpha: 1.0)
            }else if uploadedCodes[indexPath.row].codeStatus ?? "" == "6"{
                cell?.codeStatusMsg.text = "Technical issue"
                cell?.codeStatusImage.image = UIImage(named: "ic_status_technical_issue")
                cell?.codeStatusMsg.textColor = UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 1.0)
            }else if uploadedCodes[indexPath.row].codeStatus ?? "" == "7"{
                cell?.codeStatusMsg.text = "Invalid length"
                cell?.codeStatusImage.image = UIImage(named: "invalid_length")
                cell?.codeStatusMsg.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
            }else if uploadedCodes[indexPath.row].codeStatus ?? "" == "8"{
                cell?.codeStatusMsg.text = "Invalid member"
                cell?.codeStatusImage.image = UIImage(named: "invalid_member")
                cell?.codeStatusMsg.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
            }else if uploadedCodes[indexPath.row].codeStatus ?? "" == "9"{
                cell?.codeStatusMsg.text = "Success but points not credited"
                cell?.codeStatusImage.image = UIImage(named: "ic_status_success_but_points_not_credited")
                cell?.codeStatusMsg.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
            }else if uploadedCodes[indexPath.row].codeStatus ?? "" == "18"{
                cell?.codeStatusMsg.text = "Code Already Banked by You"
                cell?.codeStatusImage.image = UIImage(named: "code_already_banked_by_you")
                cell?.codeStatusMsg.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
            }else if uploadedCodes[indexPath.row].codeStatus ?? "" == "19"{
                cell?.codeStatusMsg.text = "Code Already Used by Others"
                cell?.codeStatusImage.image = UIImage(named: "code_already_banked_by_others")
                cell?.codeStatusMsg.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
            }else if uploadedCodes[indexPath.row].codeStatus ?? "" == "14" {
                cell?.codeStatusMsg.text = "You are not entitled for this product to bank"
                cell?.codeStatusImage.image = UIImage(named: "pending")
                cell?.codeStatusMsg.textColor = UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 1.0)
            }else{
                cell?.codeStatusMsg.text = "-"
            }
            
           
            
           
        }else{
            cell?.delegate = self
            cell?.viewTrailingSpaceConstrant.constant = 46
            cell?.checkBoxBTN.isHidden = false
            cell?.uploadCode.text = self.codesCollectionsArray[indexPath.row].uploadedCode ?? ""
            cell?.codeStatusMsg.text = self.codesCollectionsArray[indexPath.row].codeStatus ?? ""
            cell?.uploadedDate.text = self.codesCollectionsArray[indexPath.row].codeUploadedDate ?? ""
            cell?.checkBoxBTN.tag = indexPath.row
            if self.codesCollectionsArray[indexPath.row].isSelected ?? 0 == 1 {
                cell?.checkBoxBTN.setImage(UIImage(named: "tickBox"), for: .normal)
            } else {
                cell?.checkBoxBTN.setImage(UIImage(named: "unchecked-2"), for: .normal)
            }
            if self.codesCollectionsArray[indexPath.row].codeStatus ?? "" == "Valid Code" {
                cell?.codeStatusImage.image = UIImage(named: "ic_status_success")
                cell?.codeStatusMsg.textColor = UIColor(red: 54/255, green: 158/255, blue: 58/255, alpha: 1.0)
            } else if self.codesCollectionsArray[indexPath.row].codeStatus ?? "" == "In-Valid Code" {
                cell?.codeStatusImage.image = UIImage(named: "ic_status_reject")
                cell?.codeStatusMsg.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
            } else if self.codesCollectionsArray[indexPath.row].codeStatus ?? "" == "Code is busy" {
                cell?.codeStatusImage.image = UIImage(named: "ic_status_code_is_busy")
                cell?.codeStatusMsg.textColor = UIColor(red: 35/255, green: 133/255, blue: 235/255, alpha: 1.0)
            } else if self.codesCollectionsArray[indexPath.row].codeStatus ?? "" == "Success and points credited" {
                cell?.codeStatusImage.image = UIImage(named: "success_and_point_credited")
                cell?.codeStatusMsg.textColor = UIColor(red: 54/255, green: 158/255, blue: 58/255, alpha: 1.0)
            } else if self.codesCollectionsArray[indexPath.row].codeStatus ?? "" == "Technical issue" {
                cell?.codeStatusImage.image = UIImage(named: "ic_status_technical_issue")
                cell?.codeStatusMsg.textColor = UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 1.0)
            } else if self.codesCollectionsArray[indexPath.row].codeStatus ?? "" == "Invalid length" {
                cell?.codeStatusImage.image = UIImage(named: "invalid_length")
                cell?.codeStatusMsg.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
            } else if self.codesCollectionsArray[indexPath.row].codeStatus ?? "" == "Invalid member" {
                cell?.codeStatusImage.image = UIImage(named: "invalid_member")
                cell?.codeStatusMsg.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
            } else if self.codesCollectionsArray[indexPath.row].codeStatus ?? "" == "Success but points not credited" {
                cell?.codeStatusImage.image = UIImage(named: "ic_status_success_but_points_not_credited")
                cell?.codeStatusMsg.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
            } else if self.codesCollectionsArray[indexPath.row].codeStatus ?? "" == "Code Generated" {
                cell?.codeStatusImage.image = UIImage(named: "ic_status_code_generated")
                cell?.codeStatusMsg.textColor = UIColor(red: 35/255, green: 133/255, blue: 235/255, alpha: 1.0)
            } else if self.codesCollectionsArray[indexPath.row].codeStatus ?? "" == "Code Mapped" {
                cell?.codeStatusImage.image = UIImage(named: "ic_status_code_mapped")
                cell?.codeStatusMsg.textColor = UIColor(red: 35/255, green: 133/255, blue: 235/255, alpha: 1.0)
            }
//            else if self.codesCollectionsArray[indexPath.row].codeStatus ?? "" == "Auto Banking Success" {
//                cell?.codeStatusImage.image = UIImage(named: "auto_banking_success")
//                cell?.codeStatusMsg.textColor = UIColor(red: 54/255, green: 158/255, blue: 58/255, alpha: 1.0)
//            } else if self.codesCollectionsArray[indexPath.row].codeStatus ?? "" == "Auto Banking Failed" {
//                cell?.codeStatusImage.image = UIImage(named: "auto_banking_failed")
//                cell?.codeStatusMsg.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
//            }
            else if self.codesCollectionsArray[indexPath.row].codeStatus ?? "" == "QR Code is not available for your location" {
                cell?.codeStatusImage.image = UIImage(named: "ic_status_qr_code_is_not_available_for_your_location")
                cell?.codeStatusMsg.textColor = UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 1.0)
            } else if self.codesCollectionsArray[indexPath.row].codeStatus ?? "" == "Code Already Banked by You" {
                cell?.codeStatusImage.image = UIImage(named: "code_already_banked_by_you")
                cell?.codeStatusMsg.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
            } else if self.codesCollectionsArray[indexPath.row].codeStatus ?? "" == "Code Already Used by Others" {
                cell?.codeStatusImage.image = UIImage(named: "code_already_banked_by_others")
                cell?.codeStatusMsg.textColor = UIColor(red: 251/255, green: 41/255, blue: 26/255, alpha: 1.0)
            } else if self.codesCollectionsArray[indexPath.row].codeStatus ?? "" == "Pending" {
                cell?.codeStatusImage.image = UIImage(named: "pending")
                cell?.codeStatusMsg.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
            }else if self.codesCollectionsArray[indexPath.row].codeStatus ?? "" == "You are not entitled for this product to bank" {
                cell?.codeStatusImage.image = UIImage(named: "pending")
                cell?.codeStatusMsg.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
            }
        }
        
       
        
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}

class SelectedCodeModels{
    
    var uploadedCode: String!
    var codeStatus: String!
    var codeUploadedDate: String!
    var isSelected: Int!
    init(uplodedCode: String!, codeStatus: String!, codeUploadedDate: String!, isSelected: Int!){
        self.uploadedCode = uplodedCode
        self.codeStatus = codeStatus
        self.codeUploadedDate = codeUploadedDate
        self.isSelected = isSelected
    }
    
}
