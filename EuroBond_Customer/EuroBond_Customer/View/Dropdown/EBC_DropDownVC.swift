//
//  HYT_DropDownVC.swift
//  Hoya Thailand
//
//  Created by syed on 21/02/23.
//

import UIKit

protocol DropdownDelegate{
    
    func didTappedGenderBtn(_ vc: EBC_DropDownVC)
    func didtappedStateListBtn(_ vc: EBC_DropDownVC)
    func didtappedCityListBtn(_ vc: EBC_DropDownVC)
    func didtappedLanguageListBtn(_ vc: EBC_DropDownVC)
    func didTappedQueryListBtn(_ vc: EBC_DropDownVC)
}


class EBC_DropDownVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var noDataFoundLbl: UILabel!
    
    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
    @IBOutlet weak var dropdownTableView: UITableView!
    var delegate: DropdownDelegate?
//    var delegate1: FilterStatusDelegate?
    var rowNumber = 0
    var flags = ""
    var genderList = ["Male","Female", "Don't want to show"]
    var statusName: String = ""
    var statusId:Int = 0
    var stateName = ""
    var stateId = 0
    
    var cityId = 0
    var cityName = ""
    var languageName = ""
    var languageId = 0
    
    var queryTopicId = 0
    var queryTopicName = ""
    
    var VM = HYT_DropdownVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noDataFoundLbl.isHidden = true
        self.VM.VC = self
        dropdownTableView.delegate = self
        dropdownTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch flags{
        case "gender":
            rowNumber = genderList.count
            heightOfTableView.constant = CGFloat(45 * rowNumber)
            dropdownTableView.reloadData()
        case "state":
            stateListApi()
        case "city":
            cityListApi()
        case "language":
            languageListApi()
        case "Query":
            helpTopicApi(ActorId: self.userId)
        default:
            print("invalid flags")
        }
    }
    
    func languageListApi(){
        let parameter = [
            "ActionType":"18"
        ] as [String : Any]
        self.VM.languageListApi(parameter: parameter)
        
    }
    
    func stateListApi(){
        let parameter : [String : Any] = [
            "ActionType":"2",
            "CountryID":15,
            "IsActive":"true",
            "SortColumn":"STATE_NAME",
            "SortOrder":"ASC",
            "StartIndex":"1"
        ]
        print(parameter)
        self.VM.stateListinApi(parameter: parameter)
    }
    
    func cityListApi(){
        let parameter : [String : Any] = [
                "ActionType":"2",
                "IsActive":"true",
                "SortColumn":stateName,
                "SortOrder":"ASC",
                "StartIndex":"1",
                "StateId":stateId
        ]
        self.VM.cityListinApi(parameter: parameter)
    }
    
    func helpTopicApi(ActorId: String){
        let parameter = [
            "ActorId": ActorId,
            "IsActive": "true",
            "ActionType": "4"
        ] as [String: Any]
        print(parameter)
        self.VM.helpTopicsQueryList(parameter: parameter)
    }
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_DropDownTVCell", for: indexPath) as! EBC_DropDownTVCell
        cell.selectionStyle = .none
        switch flags{
        case "gender":
            cell.nameLbl.text = genderList[indexPath.row]
        case "state":
            cell.nameLbl.text = self.VM.stateListArray[indexPath.row].stateName
        case "city":
            cell.nameLbl.text = self.VM.cityListArray[indexPath.row].cityName
        case "language":
            cell.nameLbl.text = self.VM.languageList[indexPath.row].attributeValue
        case "Query":
            cell.nameLbl.text = self.VM.queryTopicListArray[indexPath.row].helpTopicName ?? ""
        default:
            print("invalid code")
        }
        return cell
    }
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch flags{
        case "gender":
            statusName = genderList[indexPath.row]
            delegate?.didTappedGenderBtn(self)
        case "state":
            stateName = self.VM.stateListArray[indexPath.row].stateName ?? ""
            stateId = self.VM.stateListArray[indexPath.row].stateId ?? 0
            delegate?.didtappedStateListBtn(self)
        case "city":
            cityName = self.VM.cityListArray[indexPath.row].cityName ?? ""
            cityId = self.VM.cityListArray[indexPath.row].cityId ?? 0
            delegate?.didtappedCityListBtn(self)
        case "language":
            languageName = self.VM.languageList[indexPath.row].attributeValue ?? ""
            languageId = self.VM.languageList[indexPath.row].attributeId ?? -1
            delegate?.didtappedLanguageListBtn(self)
        case "Query":
            queryTopicName = self.VM.queryTopicListArray[indexPath.row].helpTopicName ?? ""
            queryTopicId = self.VM.queryTopicListArray[indexPath.row].helpTopicId ?? -1
            delegate?.didTappedQueryListBtn(self)
        default:
            print("invalid flags")
        }
        dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view{
                    dismiss(animated: true)
        }
    }

}

struct myredeemptionStatusModel{
    let statusName : String
    let statusID : Int
    
}
