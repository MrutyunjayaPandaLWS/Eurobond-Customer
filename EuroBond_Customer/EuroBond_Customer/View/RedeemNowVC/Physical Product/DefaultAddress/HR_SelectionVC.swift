//
//  HR_SelectionVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/16/22.
//

import UIKit

protocol SelectedItemDelegate {
    func didSelectedItem(_ vc: HR_SelectionVC)
}

class HR_SelectionVC: BaseViewController, popUpAlertDelegate {
    func popupAlertDidTap(_ vc: HR_PopUpVC){}
    

    @IBOutlet weak var selectionTableView: UITableView!
    @IBOutlet weak var selectionTableHeightConstraint: NSLayoutConstraint!
    var delegate: SelectedItemDelegate!
    var selectedTitle = ""
    var selectedId = ""
    var selectThemeID = -1
    var selectThemeName = ""
    
    var statusArray = [String]()
    var codeStatusArray = [String]()
    var myearningArray = ["Program Name","Bonus Name","Customer Name","Pending","FeedBack"]
    var redemptionTypeNameArray = ["Pending","Processed","Delivered","Cancelled","Returned","Redispatched","OnHold","Dispatched","Out for Delivery","Address Verified","Posted for approval","Vendor Alloted","Vendor Rejected","Cancel Request","Redemption Verified","Delivery Confirmed","Return Requested","Return Pickup Schedule","Picked Up","Return Received","In Transit","Approved","Rejected","Picked Up", "Return Received"]
    var myAssistant = ["Active","InActive"]
    var myDisplaystatusArray: [String] = ["Rejected","Pending","Approved"]
    var redemptionTypeIdArray = [1]
    var isComeFrom = 0
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? "-1"
    var loyaltyID = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var VM = HR_SelectionVM()
    var selectedCountryId = 0
    var selectedStateId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.selectionTableHeightConstraint.constant = 0
        self.selectionTableView.delegate = self
        self.selectionTableView.dataSource = self
       }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            let touch = touches.first
            if touch?.view != self.selectionTableView
            {
                self.dismiss(animated: true, completion: nil) }
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "No Internet Connection"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            if isComeFrom == 1{
                countryListingAPI()
            }else if isComeFrom == 2{
                stateListingAPI()
            }else if isComeFrom == 3{
                cityListingAPI(stateID: self.selectedStateId)
            }else if isComeFrom == 4{
                districtListingAPI(stateID: self.selectedStateId)
            }else if isComeFrom == 5{
                getMyEarningListApi()
            }else if isComeFrom == 6{
                self.selectionTableHeightConstraint.constant = 400
                self.selectionTableView.reloadData()
            }else if isComeFrom == 7{
                self.myDisplayListingAPI()
            }else if isComeFrom == 8{
                self.myDisplayAPI()
            }else if isComeFrom == 9{
                self.selectionTableHeightConstraint.constant = 100
                self.selectionTableView.reloadData()
            }
        }
    }
    
    
    func myDisplayListingAPI(){
        let parameters = [
            "ActionType": 1,
            "LoyaltyID": "\(loyaltyID)"
        ] as [String : Any]
        print(parameters)
     //   self.VM.myDisplayStatusAPI(parameters: parameters)
    }
    func getMyEarningListApi(){
        let parameterJSON = [
            "ActionType":62
        ] as  [String:Any]
      //  self.VM.myEarningStatus(parameters: parameterJSON)
    }
    func countryListingAPI(){
        let parameterJSON = [
            "ActionType":3
        ] as  [String:Any]
    //    self.VM.countrylisting(parameters: parameterJSON)
        
    }
    func stateListingAPI(){
        let parameterJSON = [
            "ActionType": "2",
             "CountryID": "15",
             "IsActive": "true",
             "SortColumn": "STATE_NAME",
             "SortOrder": "ASC",
            "StartIndex": "1"
        ] as  [String:Any]
        self.VM.statelisting(parameters: parameterJSON)
    }
    func cityListingAPI(stateID: Int){
            let parameterJSON = [
                    "ActionType": "2",
                    "IsActive": "true",
                    "SortColumn": "CITY_NAME",
                    "SortOrder": "ASC",
                    "StartIndex": "1",
                    "StateId": "\(selectedStateId)"
            ] as  [String:Any]
            self.VM.citylisting(parameters: parameterJSON)
    }
    func districtListingAPI(stateID: Int){
            let parameterJSON = [
                "StateId":"\(selectedStateId)"
            ] as  [String:Any]
           // self.VM.districtlisting(parameters: parameterJSON)
        }
    func myDisplayAPI(){
        let parameters = [
            "ActionType":48
        ] as [String : Any]
        print(parameters)
       // self.VM.selectStatusAPI(parameters:parameters)
    }
}
extension HR_SelectionVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isComeFrom == 1{
            return 1
        }else if isComeFrom == 2{
            return self.VM.stateArray.count
        }else if isComeFrom == 3{
            return self.VM.cityArray.count
        }else if isComeFrom == 5{
            return 1
        }else if isComeFrom == 6{
            return self.redemptionTypeNameArray.count
        }else if isComeFrom == 7{
            return 1
        }else if isComeFrom == 8{
            return 1
           // return self.VM.myDispalyThemDropDown.count
        }else if isComeFrom == 9{
            return self.myAssistant.count
           // return self.VM.myDispalyThemDropDown.count
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HR_SelectionTVC", for: indexPath) as! HR_SelectionTVC
        cell.selectionStyle = .none
        if isComeFrom == 1{
//            cell.itemLbl.text = self.VM.countryArray[indexPath.row].countryName ?? ""
        }else if isComeFrom == 2{
            cell.itemLbl.text = self.VM.stateArray[indexPath.row].stateName ?? ""
        }else if isComeFrom == 3{
            cell.itemLbl.text = self.VM.cityArray[indexPath.row].cityName ?? ""
        }else if isComeFrom == 5{
//            cell.itemLbl.text = self.VM.myEarningStatusArray[indexPath.row].attributeType ?? ""
        }else if isComeFrom == 6{
            cell.itemLbl.text = self.redemptionTypeNameArray[indexPath.row]
        }else if isComeFrom == 7{
//            cell.itemLbl.text = self.myDisplaystatusArray[indexPath.row]
        }else if isComeFrom == 8{
//            cell.itemLbl.text = self.VM.myDispalyThemDropDown[indexPath.row].attributeValue ?? ""
        }else if isComeFrom == 9{
            cell.itemLbl.text = self.myAssistant[indexPath.row]
                    }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isComeFrom == 1{
//            self.selectedTitle = self.VM.countryArray[indexPath.row].countryName ?? ""
//            self.selectedId = "\(self.VM.countryArray[indexPath.row].countryId ?? 0)"

        }else if isComeFrom == 2{
            self.selectedTitle = self.VM.stateArray[indexPath.row].stateName ?? ""
            self.selectedId = "\(self.VM.stateArray[indexPath.row].stateId ?? 0)"
        }else if isComeFrom == 3{
            self.selectedTitle = self.VM.cityArray[indexPath.row].cityName ?? ""
            self.selectedId = "\(self.VM.cityArray[indexPath.row].cityId ?? 0)"
        }else if isComeFrom == 5{
//            self.selectedTitle = self.VM.myEarningStatusArray[indexPath.row].attributeType ?? ""
//            self.selectedId = "\(self.VM.myEarningStatusArray[indexPath.row].attributeId ?? 0)"
        }else if isComeFrom == 6{
            self.selectedTitle = self.redemptionTypeNameArray[indexPath.row]
        }else if isComeFrom == 7{
            //self.selectedTitle = self.myDisplaystatusArray[indexPath.row]
            //self.selectedId = "\(self.VM.myDisplayArray[indexPath.row].transactionType ?? "")"
        }else if isComeFrom == 8{
//            self.selectThemeName = self.VM.myDispalyThemDropDown[indexPath.row].attributeValue ?? ""
//            self.selectThemeID = self.VM.myDispalyThemDropDown[indexPath.row].attributeId ?? 0
            //self.selectedId = "\(self.VM.myDisplayArray[indexPath.row].transactionType ?? "")"
        }else if isComeFrom == 9{
            self.selectedTitle = self.myAssistant[indexPath.row]
                    }
        self.delegate.didSelectedItem(self)
        self.dismiss(animated: true, completion: nil)
       
    }
    
    
}
