//
//  EBC_QueryListingVC.swift
//  EuroBond_Customer
//
//  Created by admin on 04/04/23.
//

import UIKit

class EBC_QueryListingVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var queryListingTV: UITableView!
    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var titleVC: UILabel!
    
    var flags: String = "1"
    var VM = EBC_QueryListVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        queryListingTV.delegate = self
        queryListingTV.dataSource = self
        self.emptyMessage.isHidden = true
        self.queryListingTV.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.queryListApi(UserId: self.userId)
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        if flags == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectNewQueryBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_CreatenewQueryVC") as? EBC_CreatenewQueryVC
        navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func queryListApi(UserId: String){
        let parameter = [
            "ActionType":"1",
            "ActorId":UserId
        ] as [String: Any]
        print(parameter)
        self.VM.queryListingApi(parameter: parameter)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.queryListingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_QueryListingTVC", for: indexPath) as! EBC_QueryListingTVC
        cell.selectionStyle = .none
//        cell.statusLbl.text = VM.queryListingArray[indexPath.section].ticketStatus ?? ""
        if VM.queryListingArray[indexPath.row].ticketStatus ?? "" == "Pending"{
            cell.statusLbl.text = "Pending"
            cell.statusLbl.textColor = UIColor.black
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 0.9523764253, green: 0.9772849679, blue: 0.9983460307, alpha: 1)
        }else if VM.queryListingArray[indexPath.row].ticketStatus ?? "" == "Re-Open"{
            cell.statusLbl.text = "Re-Open"
            cell.statusLbl.textColor = UIColor.black
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.04705882353, green: 0.4823529412, blue: 0.7450980392, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else if VM.queryListingArray[indexPath.row].ticketStatus ?? "" == "Resolved"{
            cell.statusLbl.text = "Resolved"
            cell.statusLbl.textColor = UIColor.black
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.04705882353, green: 0.4823529412, blue: 0.7450980392, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else if VM.queryListingArray[indexPath.row].ticketStatus ?? "" == "Resolved-Follow Up"{
            cell.statusLbl.text = " Resolved-Follow Up"
            cell.statusLbl.textColor = UIColor.black
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else if VM.queryListingArray[indexPath.row].ticketStatus ?? "" == "Closed"{
            cell.statusLbl.text = " Closed"
            cell.statusLbl.textColor = UIColor.black
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else if VM.queryListingArray[indexPath.row].ticketStatus ?? "" == "Posted For Approval"{
            cell.statusLbl.text = "Posted For Approval"
            cell.statusLbl.textColor = UIColor.black
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
        else{
            cell.statusLbl.text = VM.queryListingArray[indexPath.row].ticketStatus ?? ""
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.statusLbl.textColor = UIColor.black
            cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }
        
        cell.queryRefNoLbl.text = VM.queryListingArray[indexPath.row].customerTicketRefNo ?? ""
        cell.messageDetailsLbl.text = "  \(VM.queryListingArray[indexPath.row].helpTopic ?? "")"
        let querydateAndTime = VM.queryListingArray[indexPath.row].jCreatedDate ?? ""
        let querydateAndTimeArray = querydateAndTime.components(separatedBy: " ")
        cell.messageDateLbl.text = querydateAndTimeArray[0]
        cell.messageTimeLbl.text = querydateAndTimeArray[1]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 170
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let centerviewcontroller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_Chatvc2ViewController") as! HR_Chatvc2ViewController
            print(VM.queryListingArray[indexPath.row].customerTicketID ?? 0)
            centerviewcontroller.CustomerTicketIDchatvc = VM.queryListingArray[indexPath.row].customerTicketID ?? 0
            centerviewcontroller.helptopicid = VM.queryListingArray[indexPath.row].helpTopicID ?? 0
            centerviewcontroller.querysummary = VM.queryListingArray[indexPath.row].querySummary ?? ""
            centerviewcontroller.helptopicdetails = VM.queryListingArray[indexPath.row].helpTopic ?? ""
            centerviewcontroller.querydetails = VM.queryListingArray[indexPath.row].queryDetails ?? ""
            self.navigationController?.pushViewController(centerviewcontroller, animated: true)
    }
    
    
    
    
    
}
