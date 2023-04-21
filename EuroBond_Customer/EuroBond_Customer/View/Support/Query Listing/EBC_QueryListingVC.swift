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
        if VM.queryListingArray[indexPath.section].ticketStatus ?? "" == "Pending"{
            cell.statusLbl.text = "Pending"
            cell.statusLbl.textColor = UIColor.black
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 0.9523764253, green: 0.9772849679, blue: 0.9983460307, alpha: 1)
        }else if VM.queryListingArray[indexPath.section].ticketStatus ?? "" == "Processed"{
            cell.statusLbl.text = "Processed"
            cell.statusLbl.textColor = UIColor.black
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        }else if VM.queryListingArray[indexPath.section].ticketStatus ?? "" == "Cancelled"{
            cell.statusLbl.text = "Cancelled"
            cell.statusLbl.textColor = UIColor.black
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        }else if VM.queryListingArray[indexPath.section].ticketStatus ?? "" == "Delivered"{
            cell.statusLbl.text = "Delivered"
            cell.statusLbl.textColor = UIColor.black
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }else if VM.queryListingArray[indexPath.section].ticketStatus ?? "" == "Poster For Approval"{
            cell.statusLbl.text = " Poster For Approval"
            cell.statusLbl.textColor = UIColor.black
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }else if VM.queryListingArray[indexPath.section].ticketStatus ?? "" == "Posted For Approval 2"{
            cell.statusLbl.text = "Posted For Approval 2"
            cell.statusLbl.textColor = UIColor.black
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
//        else if VM.queryListingArray[indexPath.section].ticketStatus ?? "" == "OnHold"{
//            cell?.statusLbl.text = "OnHold"
//            cell?.statusLbl.textColor = UIColor.black
//            cell?.statusView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            cell?.statusView.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
//        }else if self.VM.myRedemptionList[indexPath.row].status ?? 0 == 10 {
//            cell?.statusLbl.text = "Dispatched"
//            cell?.statusLbl.textColor = UIColor.black
//            cell?.statusView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            cell?.statusView.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//        }else if self.VM.myRedemptionList[indexPath.row].status ?? 0 == 11 {
//            cell?.statusLbl.text = "Out for Delivery"
//            cell?.statusView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            cell?.statusView.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//            cell?.statusLbl.textColor = UIColor.black
//        }else if self.VM.myRedemptionList[indexPath.row].status ?? 0 == 12 {
//            cell?.statusLbl.text = "Address Verified"
//            cell?.statusView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            cell?.statusLbl.textColor = UIColor.black
//            cell?.statusView.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
//        }
        else{
            cell.statusLbl.text = VM.queryListingArray[indexPath.section].ticketStatus ?? ""
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.statusLbl.textColor = UIColor.black
            cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }
        
        cell.queryRefNoLbl.text = VM.queryListingArray[indexPath.section].customerTicketRefNo ?? ""
        cell.messageDetailsLbl.text = "  \(VM.queryListingArray[indexPath.section].helpTopic ?? "")"
        let querydateAndTime = VM.queryListingArray[indexPath.section].jCreatedDate ?? ""
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
            print(VM.queryListingArray[indexPath.section].customerTicketID ?? 0)
            centerviewcontroller.CustomerTicketIDchatvc = VM.queryListingArray[indexPath.section].customerTicketID ?? 0
            centerviewcontroller.helptopicid = VM.queryListingArray[indexPath.section].helpTopicID ?? 0
            centerviewcontroller.querysummary = VM.queryListingArray[indexPath.section].querySummary ?? ""
            centerviewcontroller.helptopicdetails = VM.queryListingArray[indexPath.section].helpTopic ?? ""
            centerviewcontroller.querydetails = VM.queryListingArray[indexPath.section].queryDetails ?? ""
            self.navigationController?.pushViewController(centerviewcontroller, animated: true)
    }
    
    
    
    
    
}
