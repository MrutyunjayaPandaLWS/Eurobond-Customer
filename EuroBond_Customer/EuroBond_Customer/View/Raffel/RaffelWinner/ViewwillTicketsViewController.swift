//
//  ViewwillTicketsViewController.swift
//  LINC
//
//  Created by admin on 13/05/22.
//

import UIKit

class ViewwillTicketsViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    

    @IBOutlet var viewYourTicketsHeadingLbl: UILabel!
    @IBOutlet weak var viewYrTicketsCollectionView: UICollectionView!
    
    var VM = ViewwillTickets_VM()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var raffleDetails = [LstRaffleDetails4]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewYrTicketsCollectionView.register(UINib(nibName: "LINC_ViewYrTickets_CVC", bundle: nil), forCellWithReuseIdentifier: "LINC_ViewYrTickets_CVC")
        
        self.VM.VC = self
        self.viewYrTicketsCollectionView.delegate = self
        self.viewYrTicketsCollectionView.dataSource = self
        
        let parameterJSON = [
            "ActionType": 7,
            "ActorId": self.userID,
            "RaffelCampaignId": self.raffleDetails[0].raffelCampaignId ?? -1
        ] as? [String:Any]
        print(parameterJSON)
        self.VM.raffleTicketsList(parameters: parameterJSON!)
        
        self.viewYourTicketsHeadingLbl.text = "View Your Tickets".localiz()
    }
    
    override func viewDidLayoutSubviews() {
        let layout1: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout1.scrollDirection = .vertical
        layout1.itemSize = CGSize(width: (self.viewYrTicketsCollectionView.frame.width - 10)/2, height: 120)
        layout1.minimumInteritemSpacing = 0
        layout1.minimumLineSpacing = 0
        self.viewYrTicketsCollectionView!.collectionViewLayout = layout1
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.VM.raffleListTicketsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LINC_ViewYrTickets_CVC", for: indexPath) as? LINC_ViewYrTickets_CVC
        if indexPath.item % 2 == 0{
            cell!.groupImage.image = UIImage(named: "Group 5294")
        }else{
            cell!.groupImage.image = UIImage(named: "Group 5296")
        }
        cell!.pointTicketlabel.text = String(self.VM.raffleListTicketsArray[indexPath.item].pointsPerTicket ?? 0)
        
        cell!.ticketnameLabel.text = self.VM.raffleListTicketsArray[indexPath.item].raffelCampaignName ?? ""
        
        cell!.ticketnumber.text = String(self.VM.raffleListTicketsArray[indexPath.item].ticketNumber ?? 0)
        
        cell!.topPrizelabel.text = String(self.VM.raffleListTicketsArray[indexPath.item].winningPoints ?? 0)

        return cell!
    }
}
