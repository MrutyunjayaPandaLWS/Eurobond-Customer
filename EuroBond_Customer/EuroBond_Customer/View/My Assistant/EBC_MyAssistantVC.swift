//
//  EBC_MyAssistantVC.swift
//  EuroBond_Customer
//
//  Created by admin on 31/03/23.
//

import UIKit

class EBC_MyAssistantVC: UIViewController, UITableViewDelegate, UITableViewDataSource, RegisterAssistantDelegate, MyAssistantTVCDelegate, UpdatePasswordVCDelegate, PopupMessageVCDelegate{

    
    func didTappedOkBtn(item: EBC_PopupMessageVC) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_SuccessMessageVC1") as? EBC_SuccessMessageVC1
        vc?.message = "Account Deactivated !"
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!, animated: true)
    }
    
    func didTappedCancelBtn(item: EBC_PopupMessageVC) {
        dismiss(animated: true)
    }
    
    func showSusccesMessage(item: EBC_UpdatePasswordVC) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_SuccessMessageVC1") as? EBC_SuccessMessageVC1
        vc?.message = "Password Updated!"
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!, animated: true)
    }
    
    func didTappedResetPassword(item: EBC_MyAssistantTVC) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_UpdatePasswordVC") as? EBC_UpdatePasswordVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.delegate = self
        present(vc!, animated: true)
    }
    
    func didTappedDeactiveAccount(item: EBC_MyAssistantTVC) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_PopupMessageVC") as? EBC_PopupMessageVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.titleMessage = "Are you Sure ?"
        vc?.message = "You want to deactivate your Fabricator Assistant account."
        vc?.delegate = self
        present(vc!, animated: true)
    }
    
    func successMessage(itme: EBC_RegisterAssistantVC) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_SuccessMessageVC1") as? EBC_SuccessMessageVC1
        vc?.messageTitle = "Congratulations"
        vc?.message = "Your assistant account has been created successfully."
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!, animated: true)
    }
    
  
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var myAssistantTV: UITableView!
    @IBOutlet weak var titleVC: UILabel!
    
    var flags = "1"
    override func viewDidLoad() {
        super.viewDidLoad()
        myAssistantTV.delegate = self
        myAssistantTV.dataSource = self
        noDataFoundView.isHidden = true
    }
    

    @IBAction func selectBackBtn(_ sender: UIButton) {
        if flags == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectFilterBtnn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_FilterVC") as? EBC_FilterVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!, animated: true)
        
    }
    
    @IBAction func selectAddBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RegisterAssistantVC") as? EBC_RegisterAssistantVC
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        vc?.delegate = self
        present(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_MyAssistantTVC", for: indexPath) as! EBC_MyAssistantTVC
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    
}
