//
//  HYT_DropDownVC.swift
//  Hoya Thailand
//
//  Created by syed on 21/02/23.
//

import UIKit

protocol DropdownDelegate{
    
    func didTappedGenderBtn(item: EBC_DropDownVC)
    func didtappedStateListBtn(item: EBC_DropDownVC)
}

//protocol FilterStatusDelegate{
//    func didTappedFilterStatus(item: HYT_DropDownVC)
//}

class EBC_DropDownVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
    @IBOutlet weak var dropdownTableView: UITableView!
    var delegate: DropdownDelegate?
//    var delegate1: FilterStatusDelegate?
    var rowNumber = 0
    var flags = ""
    var genderList = ["Male","Female"]
    var statusName: String = ""
    var statusId:Int = 0
    var stateName = ""
    var stateId = 0
    var VM = HYT_DropdownVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            
        default:
            print("invalid flags")
        }
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
        default:
            print("invalid code")
        }
        return cell
    }
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch flags{
        case "gender":
            statusName = genderList[indexPath.row]
            delegate?.didTappedGenderBtn(item: self)
        case "state":
            statusName = self.VM.stateListArray[indexPath.row].stateName ?? ""
            statusId = self.VM.stateListArray[indexPath.row].stateId ?? 0
            delegate?.didtappedStateListBtn(item: self)
        case "city":
            statusName = self.VM.cityListArray[indexPath.row].cityName ?? ""
            statusId = self.VM.cityListArray[indexPath.row].cityId ?? 0
            delegate?.didtappedStateListBtn(item: self)
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
