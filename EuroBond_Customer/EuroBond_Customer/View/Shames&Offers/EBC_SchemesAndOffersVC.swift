//
//  EBC_SchemesAndOffersVC.swift
//  EuroBond_Customer
//
//  Created by syed on 21/03/23.
//

import UIKit
import LanguageManager_iOS

class EBC_SchemesAndOffersVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, SchemesAndOffersDelegate {
    
    func didTappedViewBtn(_ cell: EBC_SchemesAndOffersTVC) {
        guard let tappedIndexPath = shemesAndOffersTV.indexPath(for: cell) else {return}
        let  vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_OffersDetailsVC") as! EBC_OffersDetailsVC
        vc.selectedTitle = self.VM.offersandPromotionsArray[tappedIndexPath.row].promotionName ?? ""

        vc.selectedLongDesc = self.VM.offersandPromotionsArray[tappedIndexPath.row].proLongDesc ?? ""
        vc.selectedShortDesc = self.VM.offersandPromotionsArray[tappedIndexPath.row].proShortDesc ?? ""
        vc.selectedImage = self.VM.offersandPromotionsArray[tappedIndexPath.row].proImage ?? ""
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
 
    @IBOutlet var noDataFoundLbl: UILabel!
    @IBOutlet weak var shemesAndOffersTV: UITableView!
    @IBOutlet weak var titleVc: UILabel!
    var flags = "1"
    
    var VM = EBC_OffersandSchemeVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
            }
        }else{
            shemesAndOffersTV.delegate = self
            shemesAndOffersTV.dataSource = self
            self.offersandPromotionsApi(UserId: self.userId)
            self.shemesAndOffersTV.separatorStyle = .none
            languageLocaliz()
        }
    }
    
    func languageLocaliz(){
        titleVc.text = "Schemes and Offers".localiz()
    }
    
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func offersandPromotionsApi(UserId: String){
        let parameter = [
            "ActionType": "99",
            "ActorId": self.userId
        ] as [String: Any]
        print(parameter)
        self.VM.offersandPromotionsApi(parameters: parameter)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.offersandPromotionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_SchemesAndOffersTVC", for: indexPath) as! EBC_SchemesAndOffersTVC
        cell.selectionStyle = .none
        cell.delegate = self
        cell.offersNameLbl.text = self.VM.offersandPromotionsArray[indexPath.row].promotionName ?? ""
        let imageURL = VM.offersandPromotionsArray[indexPath.row].proImage ?? ""
        print(imageURL)
        if imageURL != ""{
            let filteredURLArray = imageURL.dropFirst(3)
            let urltoUse = String(PROMO_IMG1 + filteredURLArray).replacingOccurrences(of: " ", with: "%20")
            let urlt = URL(string: "\(urltoUse)")
            print(urlt)
            cell.offersImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230

    }
    
    
}
