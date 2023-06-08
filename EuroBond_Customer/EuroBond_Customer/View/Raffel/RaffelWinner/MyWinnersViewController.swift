//
//  MyWinnersViewController.swift
//  LINC
//
//  Created by admin on 13/05/22.
//

import UIKit

class MyWinnersViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var viewYrTicketsTableView: UITableView!
    var VM = WinnersList_VM()
    var userID = UserDefaults.standard.integer(forKey: "UD_UserID")
    var raffleDetails = [LstRaffleDetails4]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        viewYrTicketsTableView.register(UINib(nibName: "WinnersListTableViewCell", bundle: nil), forCellReuseIdentifier: "WinnersListTableViewCell")
        self.viewYrTicketsTableView.delegate = self
        self.viewYrTicketsTableView.dataSource = self
                let parameterJSON = [
                    "ActionType":4,
                    "ActorId":userID,
                    "RaffelCampaignId":self.raffleDetails[0].raffelCampaignId ?? -1
                ]
            print(parameterJSON, "Raffle Details APi")
                self.VM.RaffleWinnerlisting(parameters: parameterJSON)
  
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myRafflesWinnersArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WinnersListTableViewCell", for: indexPath) as? WinnersListTableViewCell
        if indexPath.row % 2 == 0{
            cell!.groupImage.image = UIImage(named: "Group 5297")
        }else{
            cell!.groupImage.image = UIImage(named: "Group 5295")
        }
        cell!.rewardpointslabel.text = String(self.VM.myRafflesWinnersArray[indexPath.row].WinningPoints ?? 0)
        cell!.ticketNumber.text = String(self.VM.myRafflesWinnersArray[indexPath.row].TicketNumber ?? 0)
        cell!.ticketnamelabel.text = String(self.VM.myRafflesWinnersArray[indexPath.row].raffelCampaignName ?? "0")
        cell!.winnerCity.text = String(self.VM.myRafflesWinnersArray[indexPath.row].winnerCity ?? "0")
        cell!.winnerLoyaltID.text = String(self.VM.myRafflesWinnersArray[indexPath.row].winnerMembershipId ?? "0")
        cell!.winnersname.text = String(self.VM.myRafflesWinnersArray[indexPath.row].winnerName ?? "")

        return cell!
    }
}
