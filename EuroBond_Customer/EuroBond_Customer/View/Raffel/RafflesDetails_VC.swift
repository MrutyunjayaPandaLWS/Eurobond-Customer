//
//  LINC_RafflesDetails_VC.swift
//  LINC
//
//  Created by Arokia-M3 on 05/07/21.
//

import UIKit
import SDWebImage

class RafflesDetails_VC: UIViewController{

    @IBOutlet var descriptionlabel: UILabel!
    @IBOutlet var pointsperTicketLabel: UILabel!
    @IBOutlet var noOfTicketpurchaselabel: UILabel!
    @IBOutlet var ticketPointslabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var validUntilLabel: UILabel!
    @IBOutlet var rafflenameLabel: UILabel!
    @IBOutlet var raffleImage: UIImageView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet weak var viewYrTicketsView: UIView!
    @IBOutlet weak var winnersView: UIView!
    @IBOutlet weak var emptyView: UIView!
    
    
    @IBOutlet var rafflesHeadingLbl: UILabel!
    @IBOutlet var raffleNameLbl: UILabel!
    @IBOutlet var validTillHeadingLbl: UILabel!
    @IBOutlet var ticketPointsHeadingLBl: UILabel!
    @IBOutlet var statusHeadingLbl: UILabel!
    @IBOutlet var noOfTicketsPurchaseHeaingLbl: UILabel!
    @IBOutlet var pointsPerTicketsHeadingLbl: UILabel!
    @IBOutlet var raffleDescriptionHeaingLbl: UILabel!
    
    
    var raffleDetails = [LstRaffleDetails4]()
    var isCurrent = true
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    //var userID = UserDefaults.standard.integer(forKey: "UD_UserID")
    var quantity = 0
    var totalPoints = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.VM.VC = self
        self.descriptionlabel.text = self.raffleDetails[0].raffelCampaignDescription ?? ""
        self.ticketPointslabel.text = "\(self.raffleDetails[0].pointsPerTicket ?? 0)"
        let x = (self.raffleDetails[0].validityTo ?? "").split(separator: " ")
        self.validUntilLabel.text = "\(x[0])"
        self.statusLabel.text = self.raffleDetails[0].status ?? ""
        self.noOfTicketpurchaselabel.text = "\(self.raffleDetails[0].quantity ?? "0")"
        let calcValue = Int(self.raffleDetails[0].pointsPerTicket ?? 0) / Int(self.raffleDetails[0].quantity ?? "0")!
        self.pointsperTicketLabel.text = "\(calcValue)"
        
        self.rafflenameLabel.text = self.raffleDetails[0].raffelCampaignName ?? ""
        
        if self.raffleDetails[0].status ?? "" == "Completed" {
            self.winnersView.isHidden = false
            self.emptyView.isHidden = true
        } else {
            self.winnersView.isHidden = true
            self.emptyView.isHidden = false
        }
    
        if self.raffleDetails[0].bannerUrl ?? "" != ""{
            let imageURl = self.raffleDetails[0].bannerUrl ?? ""
            let filteredURLArray = imageURl.split(separator: "~")
            let urltoUse = String(rafflesURL + filteredURLArray[0]).replacingOccurrences(of: " ", with: "%20")
            
            let urlt = URL(string: "\(urltoUse)")
            print(urlt)
            let transformer = SDImageResizingTransformer(size: CGSize(width: self.view.frame.width, height: 200), scaleMode: .fill)
            raffleImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"), context: [.imageTransformer: transformer])
        }else {
            self.raffleImage.image = UIImage(named: "ic_default_img")
        }
        print("URLs",self.raffleDetails[0].bannerUrl ?? "")
    }
    
    
    
    
    
    func localization(){
        self.rafflesHeadingLbl.text = "Raffles".localiz()
        self.raffleNameLbl.text = "Raffle name".localiz()
        self.validTillHeadingLbl.text = "Valid till".localiz()
        self.ticketPointsHeadingLBl.text = "Ticket points".localiz()
        self.statusHeadingLbl.text = "Status".localiz()
        self.noOfTicketsPurchaseHeaingLbl.text = "No of ticket purchase".localiz()
        self.pointsPerTicketsHeadingLbl.text = "Point per ticket".localiz()
        self.raffleDescriptionHeaingLbl.text = "Raffle Description".localiz()
    }
    
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }


   func convertDateFormater(_ date: String) -> String {
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss a"
               let date = dateFormatter.date(from: date)
               dateFormatter.dateFormat = "dd/MM/yyyy"
               return  dateFormatter.string(from: date!)
           }
    
    @IBAction func winnersTickets(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyWinnersViewController") as? MyWinnersViewController
        vc!.raffleDetails = self.raffleDetails
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func viewyrTickets(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewwillTicketsViewController") as? ViewwillTicketsViewController
        vc!.raffleDetails = self.raffleDetails
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

