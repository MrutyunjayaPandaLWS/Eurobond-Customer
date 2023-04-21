//
//  CodeStatus_VC.swift
//  centuryDemo
//
//  Created by Arokia-M3 on 15/03/22.
//

import UIKit

class CodeStatus_VC: BaseViewController {

    @IBOutlet var codeStatusTitleLabel: UILabel!
    @IBOutlet var codeStatusCount: UILabel!
    @IBOutlet var codeSyncButton: UIButton!
    @IBOutlet var codeStatusTableView: UITableView!
    
//    var vm = CodeStatusViewModel()
    var statusID = -1
    var selectedFromDate = ""
    var selectedToDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.vm.VC = self
        self.codeStatusTableView.delegate = self
        self.codeStatusTableView.dataSource = self
        languagelocalization()
    }
    
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            
        }else{
        
        }
    }
    
    @IBAction func codeSyncButton(_ sender: Any) {
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.navigationController?.popViewController(animated: true)
    }
    
}

extension CodeStatus_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CodeStatus_TVC") as! CodeStatus_TVC
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
