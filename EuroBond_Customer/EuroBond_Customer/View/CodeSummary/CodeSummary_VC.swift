//
//  CodeSummary_VC.swift
//  centuryDemo
//
//  Created by Arokia-M3 on 16/03/22.
//

import UIKit
import Firebase
import LanguageManager_iOS
class CodeSummary_VC: BaseViewController, popUpAlertDelegate {
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    

    @IBOutlet var codeSummaryLabel: UILabel!
    @IBOutlet var codeSummaryTableView: UITableView!
//    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var vm = CodeSummaryViewModel()
 
    var codeTitleListingArray = ["","","",""]
    var itsFrom = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.VC = self
        self.codeSummaryTableView.delegate = self
        self.codeSummaryTableView.dataSource = self
        self.apiCalling()
        languagelocalization()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      

        
    }
    func languagelocalization(){
        self.codeSummaryLabel.text = "CodeSummary".localiz()
    }
    
    @IBAction func backButton(_ sender: Any) {
        if itsFrom == 1{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        }
        
    
    func apiCalling() {
        
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
            let parameters = ["ActionType":211,"MemberID":"\(loyaltyId)","QrCodeStatusID":-1] as [String : Any]
            self.vm.codeSummaryListingAPI(parameters: parameters)
        }
    }
    
}

extension CodeSummary_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.codeSummaryListingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CodeSummary_TVC") as! CodeSummary_TVC
        cell.codeCount.text = String(self.vm.codeSummaryListingArray[indexPath.row].codeStatusWiseCount ?? 0)
        cell.codesTitleName.text = self.vm.codeSummaryListingArray[indexPath.row].status ?? ""
        return cell
    }
}
