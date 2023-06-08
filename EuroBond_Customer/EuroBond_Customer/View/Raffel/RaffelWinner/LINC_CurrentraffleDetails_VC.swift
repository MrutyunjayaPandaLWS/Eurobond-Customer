//
//  LINC_CurrentraffleDetails_VC.swift
//  LINC
//
//  Created by Arokia-M3 on 14/07/21.
//

import UIKit
import SDWebImage
import Toast_Swift
import LanguageManager_iOS

class LINC_CurrentraffleDetails_VC: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, popuprafflesDelegate {
    func YesOrderSummaryDidTap(_ vc: LINC_AlertPopUp_Raffles_VC) {
        self.itsFrom = "OnGoingRaffles"
//        self.raffleListTicketsArray.removeAll()
//        self.raffleListTicketsArray = vc.VM2.raffleListTicketsArray
//        print(self.raffleListTicketsArray.count)
//
//        self.viewYrTicketsCollectionView.reloadData()
        self.count = 1
        self.countlabel.text = String(self.count)
        self.ticketCountLabel.text = "Ticket Count : \(self.count)"
        let values = (self.count ?? 0) * Int(self.pointsValue ?? "0")!
        self.pointsperTicketLabel.text = "Total Points \(values)"
//        let parameter2JSON = [
//            "ActionType":"32","ActorId":"\(self.userID)","IsActive":"true"
//        ] as [String:Any]
//        print(parameter2JSON)
//        self.VM.customerDashboard(parameters: parameter2JSON)
        self.onGoingRafflesApi()
        let parameterJSON = [
            "RaffelCampaignId": raffelCampaignId,
            "ActionType": 7,
            "ActorId": userID
        ] as? [String:Any]
        print("Get Bought Ticket Lists", parameterJSON!)
        self.VM.raffleSubmit3(parameters: parameterJSON!)
        self.getTicketsTotalApi()
    }
    
    func NoOrderSummaryDidTap(_ vc: LINC_AlertPopUp_Raffles_VC) {
        
    }
    

    @IBOutlet weak var ticketCountLabel: UILabel!
    @IBOutlet var countlabel: UILabel!
    @IBOutlet var backbutton: UIButton!
    @IBOutlet var descriptionlabel: UILabel!
    @IBOutlet var pointsperTicketLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var validUntilLabel: UILabel!
    @IBOutlet var rafflenameLabel: UILabel!
    @IBOutlet var raffleImage: UIImageView!
    @IBOutlet weak var yourPointsBalance: UILabel!
    @IBOutlet weak var buyTicketView: UIView!
    @IBOutlet weak var raffleQuantityStackView: UIStackView!
    @IBOutlet weak var ticketCounterView: UIView!
    @IBOutlet weak var buyTicketButton: UIButton!
    @IBOutlet weak var viewYrTicketsCollectionView: UICollectionView!
    @IBOutlet weak var totalTicketsPurchaseLbl: UILabel!
    @IBOutlet weak var totalPointsRedeemedLbl: UILabel!
    
    
    @IBOutlet var rafflesHeadingLbl: UILabel!
    
    @IBOutlet var raffleNameheadingLbl: UILabel!
    
    @IBOutlet var validTillHeadingLbl: UILabel!
    
    @IBOutlet var yourPointBalanceHeadingLbl: UILabel!
    
    @IBOutlet var ststusHeadingLbl: UILabel!
    
    @IBOutlet var descriptionHeaingLbl: UILabel!
    
    
    @IBOutlet var totalTicketHeaingLbl: UILabel!
    
    @IBOutlet var totalPointsRedeemHeadingLbl: UILabel!
    
    
    @IBOutlet var raffleQuantityHeaingLbl: UILabel!
    
    
    
    
    var raffleListTicketsArray = [LstRaffleDetails]()
    var raffleListTicketsArray1 = [LstRaffleDetails1]()
    var raffleListTicketsArray2 = [LstRaffleDetails2]()

    var VM = LINC_CurrentRafflesDetails_VM()
    var raffleDetails = [LstRaffleDetails5394]()
    var count = 1
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    //var userID = UserDefaults.standard.integer(forKey: "UD_UserID")
   // var points = UserDefaults.standard.integer(forKey: "UD_redeemablePointsBalance") ?? 0
    var points = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    var pointsValue = ""
    var raffelCampaignId = 0
    var itsFrom = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userID)
        self.VM.VC = self
//        let parameter2JSON = [
//            "ActionType":"32","ActorId":"\(self.userID)","IsActive":"true"
//        ] as [String:Any]
//        print(parameter2JSON)
//        self.VM.customerDashboard(parameters: parameter2JSON)
        self.onGoingRafflesApi()
        self.yourPointsBalance.text = points
        
        viewYrTicketsCollectionView.register(UINib(nibName: "CurrentraffleDetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CurrentraffleDetailsCollectionViewCell")
        self.raffelCampaignId = self.raffleDetails[0].raffelCampaignId ?? 0
        print(self.raffelCampaignId, " - raffelCampaignId ")
        self.totalTicketsPurchaseLbl.text = "\(self.raffleDetails[0].noofTicketPurchase ?? 0)"
        self.totalPointsRedeemedLbl.text = "\(self.raffleDetails[0].ticketPoints ?? 0)"
        self.viewYrTicketsCollectionView.delegate = self
        self.viewYrTicketsCollectionView.dataSource = self
        self.countlabel.text = String(count)
        self.descriptionlabel.text = self.raffleDetails[0].raffelCampaignDescription ?? ""
        
        let x = (self.raffleDetails[0].validityTo ?? "").split(separator: " ")
        self.validUntilLabel.text = "\(x[0])"
        self.statusLabel.text = self.raffleDetails[0].status ?? ""
        self.pointsperTicketLabel.text = "Total Points \(self.raffleDetails[0].pointsPerTicket ?? 0)"
        self.pointsValue = "\(self.raffleDetails[0].pointsPerTicket ?? 0)"
        self.ticketCountLabel.text = "Ticket Count : 1"
        print("Points Values is", self.pointsValue )
        print(self.pointsperTicketLabel.text!, "Total Points")
        self.rafflenameLabel.text = self.raffleDetails[0].raffelCampaignName ?? ""
        let quantityValue = self.raffleDetails[0].quantity ?? ""
        print(quantityValue)
        if quantityValue == "0"{
//            self.pointsperTicketLabel.text = UIColor.lightGray.cgColor as? String
            self.raffleQuantityStackView.isUserInteractionEnabled = false
            self.ticketCounterView.backgroundColor = UIColor.lightGray
            self.buyTicketView.backgroundColor = UIColor.lightGray
            self.buyTicketButton.isEnabled = false
        } else {
//            self.pointsperTicketLabel.text = UIColor.lightGray.cgColor as? String
            self.raffleQuantityStackView.isUserInteractionEnabled = true
            self.ticketCounterView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.buyTicketView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            self.buyTicketButton.isEnabled = true
        }
        
        if self.raffleDetails[0].bannerUrl ?? "" != ""{
            let imageURl = self.raffleDetails[0].bannerUrl ?? ""
            let filteredURLArray = imageURl.split(separator: "~")
            let urltoUse = String(PROMO_IMG1 + filteredURLArray[0]).replacingOccurrences(of: " ", with: "%20")
            
            let urlt = URL(string: "\(urltoUse)")
            print(urlt)
            let transformer = SDImageResizingTransformer(size: CGSize(width: self.view.frame.width, height: 200), scaleMode: .fill)
            raffleImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"), context: [.imageTransformer: transformer])
        }else{
            self.raffleImage.image = UIImage(named: "ic_default_img")
        }
        self.boughtTicketsListApi()
        self.getTicketsTotalApi()
        NotificationCenter.default.addObserver(self, selector: #selector(savedRaffelsDetails), name: .savedRaffels, object: nil)
        let layout1: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout1.scrollDirection = .vertical
        layout1.itemSize = CGSize(width: (self.viewYrTicketsCollectionView.frame.width - 10)/2, height: 120)
        layout1.minimumInteritemSpacing = 0
        layout1.minimumLineSpacing = 0
        self.viewYrTicketsCollectionView!.collectionViewLayout = layout1
        self.localization()
    }

    
    
    
    func localization(){
        self.rafflesHeadingLbl.text = "Raffles".localiz()
        self.raffleNameheadingLbl.text = "Raffle name".localiz()
        self.validTillHeadingLbl.text = "Valid till".localiz()
        self.yourPointBalanceHeadingLbl.text = "Your point balance".localiz()
        self.ststusHeadingLbl.text = "Status".localiz()
        self.descriptionHeaingLbl.text = "Description".localiz()
        self.totalTicketHeaingLbl.text = "Total Ticket Purchased".localiz()
        self.totalPointsRedeemHeadingLbl.text = "Total Points Redeemed".localiz()
        self.raffleQuantityHeaingLbl.text = "Raffle Qty".localiz()
        self.buyTicketButton.setTitle("Buy Ticket".localiz(), for: .normal)
    }
    
    
   
    @IBAction func plusButton(_ sender: Any) {
//        print(self.raffleListTicketsArray1[0].quantity ?? "0", "Quantity")
//        print(count, "Count")
//        if count < Int(self.raffleListTicketsArray2[0].quantity ?? "0") ?? 0{
            count += 1
            self.countlabel.text = String(count)
            self.ticketCountLabel.text = "Ticket Count : \(self.count)"
            let values = Int(count) * Int(self.pointsValue)!
            self.pointsperTicketLabel.text = "Total Points \(values)"
//        }
    }
    
    @IBAction func backbutton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func buyTicket(_ sender: Any) {
        print(points)
        print(Int(count) * Int(self.pointsValue)!, "sadfasdfasdfadsfds")
        if Int(points) ?? 0 >= Int(count) * Int(self.pointsValue)! {
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LINC_AlertPopUp_Raffles_VC") as? LINC_AlertPopUp_Raffles_VC
            vc?.isComeFrom = "CurrentRaffleDetails"
            vc?.delegate = self
            vc?.raffelConfId = self.raffleDetails[0].raffelCampaignId ?? -1
            vc?.count = self.count
            vc?.modalPresentationStyle = .overCurrentContext
            vc?.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
            self.raffelCampaignId = self.raffleDetails[0].raffelCampaignId ?? -1
            
        } else {
            self.view.makeToast("Insufficient point balance", duration: 3.0, position: .bottom)
        }
    }
    @IBAction func minusButton(_ sender: Any) {
        if count != 1 && count > 1{
            count -= 1
            self.countlabel.text = String(count)
            print(self.pointsValue, "before decrement")
            let values = Int(count) * Int(self.pointsValue)!
            self.ticketCountLabel.text = "Ticket Count : \(self.count)"
            self.pointsperTicketLabel.text = "Total Points \(values)"
        }
    }
    
    @objc func savedRaffelsDetails(){
        self.navigationController?.popToRootViewController(animated: true)
    }

    func onGoingRafflesApi(){
        let parameterJSON = [
            "ActionType":2,
            "ActorId":userID
        ] as? [String:Any]
        print("Ongoing Raffels", parameterJSON)
      
        self.VM.currentRafflelisting(parameters: parameterJSON!)
    }
    
    func boughtTicketsListApi(){
        let parameterJSON = [
            "RaffelCampaignId": raffelCampaignId,
            "ActionType": 7,
            "ActorId": userID
        ] as? [String:Any]
        print("BoughTicketList", parameterJSON!)
        self.VM.raffleSubmit3(parameters: parameterJSON!)
    }
    func getTicketsTotalApi(){
        let parameterJSON = [
            "ActionType": 7,
            //"ActionType": 8,
            "ActorId": userID,
            "RaffelCampaignId": raffelCampaignId
        ] as? [String:Any]
        print("TotalTicketCount", parameterJSON!)
        self.VM.raffleTotalTicketsCount(parameters: parameterJSON!)
    }
    
//   func convertDateFormater(_ date: String) -> String
//           {
//               let dateFormatter = DateFormatter()
//               dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss a"
//               let date = dateFormatter.date(from: date)
//               dateFormatter.dateFormat = "dd/MM/yyyy"
//               return  dateFormatter.string(from: date!)
//
//           }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.itsFrom == "OnGoingRaffles"{
            return self.raffleListTicketsArray1.count
        }else{
            return self.raffleListTicketsArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentraffleDetailsCollectionViewCell", for: indexPath) as? CurrentraffleDetailsCollectionViewCell
        if self.itsFrom == "OnGoingRaffles"{
            if indexPath.item % 2 == 0{
                cell!.groupImage.image = UIImage(named: "Group 5294")
            }else{
                cell!.groupImage.image = UIImage(named: "Group 5296")
            }
            cell!.pointTicketlabel.text = String(self.raffleListTicketsArray1[indexPath.item].pointsPerTicket ?? 0)
            
            cell!.ticketnameLabel.text = self.raffleListTicketsArray1[indexPath.item].raffelCampaignName ?? ""
            
            cell!.ticketnumber.text = String(self.raffleListTicketsArray1[indexPath.item].ticketNumber ?? 0)
            
            cell!.topPrizelabel.text = String(self.raffleListTicketsArray1[indexPath.item].winningPoints ?? 0)
        }else{
            if indexPath.item % 2 == 0{
                cell!.groupImage.image = UIImage(named: "Group 5294")
            }else{
                cell!.groupImage.image = UIImage(named: "Group 5296")
            }
            cell!.pointTicketlabel.text = String(self.raffleListTicketsArray[indexPath.item].pointsPerTicket ?? 0)
            
            cell!.ticketnameLabel.text = self.raffleListTicketsArray[indexPath.item].raffelCampaignName ?? ""
            
            cell!.ticketnumber.text = String(self.raffleListTicketsArray[indexPath.item].ticketNumber ?? 0)
            
            cell!.topPrizelabel.text = String(self.raffleListTicketsArray[indexPath.item].winningPoints ?? 0)
        }
      
        return cell!
    }

}
