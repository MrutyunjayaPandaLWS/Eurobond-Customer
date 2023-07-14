//
//  LINC_Raffles_VC.swift
//  LINC
//
//  Created by Arokia-M3 on 05/07/21.
//

import UIKit
import SDWebImage
import LanguageManager_iOS

class Raffles_VC: BaseViewController, RaffleDelegate {
  
    @IBOutlet var rafflesHeadingLbl: UILabel!
    
    @IBOutlet var raffleCollectionView: UICollectionView!
    @IBOutlet var segmentedControll: UISegmentedControl!
    @IBOutlet weak var noDataFoundLabel: UILabel!
    
    
    var VM = Raffles_VM()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    //var userID = UserDefaults.standard.integer(forKey: "UD_UserID")
    var isComeFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.raffleCollectionView.delegate = self
        self.raffleCollectionView.dataSource = self
        self.segmentedControll.setTitle("Ongoing Raffles".localiz(), forSegmentAt: 0)
        self.segmentedControll.setTitle("My Raffles".localiz(), forSegmentAt: 1)
        noDataFoundLabel.text = "No Data Found".localiz()
        noDataFoundLabel.isHidden = true
        self.localization()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if self.isComeFrom == "OnGoingRaffle" || self.isComeFrom == "OnGoingRaffles"{
            self.segmentedControll.selectedSegmentIndex = 0
            let parameterJSON = [
                "ActionType":2,
                "ActorId":userID
            ] as? [String:Any]
            print(parameterJSON, "Raffles List")
            
            self.VM.currentRafflelisting(parameters: parameterJSON!)
        }else if self.isComeFrom == "MyRaffles"{
            self.segmentedControll.selectedSegmentIndex = 1
            let parameterJSON = [
                "ActionType":3,
                "ActorId":userID
            ] as? [String:Any]
            print(parameterJSON, "MyRaffles")
            self.VM.Rafflelisting(parameters: parameterJSON!)
        }
        
    }
    
    func localization(){
        self.noDataFoundLabel.text = "No Data Found".localiz()
        self.rafflesHeadingLbl.text = "Raffles".localiz()
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLayoutSubviews() {
        let collectionViewFLowLayout = UICollectionViewFlowLayout()
        collectionViewFLowLayout.itemSize = CGSize(width: CGFloat(((self.view.bounds.width - 5) - (self.raffleCollectionView.contentInset.left + self.raffleCollectionView.contentInset.right)) / 2), height: 220)
        collectionViewFLowLayout.minimumLineSpacing = 2.5
        collectionViewFLowLayout.minimumInteritemSpacing = 2.5
        self.raffleCollectionView.collectionViewLayout = collectionViewFLowLayout
    }
    
    
    @IBAction func segmentedcontroll(_ sender: Any) {
        if segmentedControll.selectedSegmentIndex == 0{
            let parameterJSON = [
                "ActionType":2,
                "ActorId":userID
            ] as? [String:Any]
            print("Ongoing Raffels", parameterJSON)
            self.VM.currentRafflelisting(parameters: parameterJSON!)
        }else{
            let parameterJSON = [
                "ActionType":3,
                "ActorId":userID
            ] as? [String:Any]
            print(parameterJSON, "MyRaffles")
            self.VM.Rafflelisting(parameters: parameterJSON!)
        }
    }
    //Delegate:
    func raffleBtn(_ cell: LINC_Raffle_CVC) {
        guard let tappedIndexPath = raffleCollectionView.indexPath(for: cell) else { return }
        if segmentedControll.selectedSegmentIndex == 0{
        DispatchQueue.main.async{
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LINC_CurrentraffleDetails_VC") as? LINC_CurrentraffleDetails_VC
            vc!.raffleDetails.append(self.VM.currentRafflesArray[tappedIndexPath.item])
            vc!.quantityCount = Int(self.VM.currentRafflesArray[tappedIndexPath.item].quantity ?? "") ?? 0
            vc!.itsFrom = "OnGoingRaffles"
        self.navigationController?.pushViewController(vc!, animated: true)
        }
            
        }else{
            DispatchQueue.main.async{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RafflesDetails_VC") as? RafflesDetails_VC
                vc?.raffleDetails.append(self.VM.myRafflesArray[tappedIndexPath.item])
//                vc?.totalTicketBuyed = Int(self.VM.currentRafflesArray[tappedIndexPath.item].quantity ?? "") ?? 0
//                vc?.totalAmountOftickets = Int(self.VM.currentRafflesArray[tappedIndexPath.item].pointsPerTicket ?? 0)
            self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
    }
    

    
    
}
extension Raffles_VC : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedControll.selectedSegmentIndex == 0{
            return self.VM.currentRafflesArray.count
        }else{
            return self.VM.myRafflesArray.count
            
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LINC_Raffle_CVC", for: indexPath) as? LINC_Raffle_CVC
        if segmentedControll.selectedSegmentIndex == 0{
            cell?.delegate = self
            cell?.raffleName.text = self.VM.currentRafflesArray[indexPath.item].raffelCampaignName ?? ""
            let transformer = SDImageResizingTransformer(size: CGSize(width: (self.raffleCollectionView.frame.width / 2) - 10, height: 250), scaleMode: .fill)
            var imageURl = self.VM.currentRafflesArray[indexPath.item].bannerUrl ?? ""
            print(imageURl)
            cell?.raffleButton.setTitle("View & Buy".localiz(), for: .normal)
            if imageURl != ""{
                let filteredURLArray = imageURl.split(separator: "~")
                let urltoUse = String(rafflesURL + filteredURLArray[0]).replacingOccurrences(of: " ", with: "%20")
                
                let urlt = URL(string: "\(urltoUse)")
                print(urlt)
                cell?.raffleImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"), context: [.imageTransformer: transformer])
            }else{

                cell?.raffleImage.image = UIImage(named: "ic_default_img")
            }
        }else{
            cell?.delegate = self
//            cell?.raffleName.text = "Status: \(self.VM.myRafflesArray[indexPath.item].status ?? "")"
            if self.VM.myRafflesArray[indexPath.item].status ?? "" == "Completed"{
                let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.gray]

                    let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2870332599, green: 0.6492142677, blue: 0, alpha: 1)]

                    let attributedString1 = NSMutableAttributedString(string:"Status: ", attributes:attrs1)

                    let attributedString2 = NSMutableAttributedString(string:"\(self.VM.myRafflesArray[indexPath.item].status ?? "")", attributes:attrs2)

                    attributedString1.append(attributedString2)
                    cell?.raffleName.attributedText = attributedString1
            }else if self.VM.myRafflesArray[indexPath.item].status ?? "" == "Active"{
                let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.gray]

                    let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)]

                    let attributedString1 = NSMutableAttributedString(string:"Status: ", attributes:attrs1)

                    let attributedString2 = NSMutableAttributedString(string:"\(self.VM.myRafflesArray[indexPath.item].status ?? "")", attributes:attrs2)

                    attributedString1.append(attributedString2)
                    cell?.raffleName.attributedText = attributedString1
            }else{
                let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.gray]

                    let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)]

                    let attributedString1 = NSMutableAttributedString(string:"Status: ", attributes:attrs1)

                    let attributedString2 = NSMutableAttributedString(string:"\(self.VM.myRafflesArray[indexPath.item].status ?? "")", attributes:attrs2)

                    attributedString1.append(attributedString2)
                    cell?.raffleName.attributedText = attributedString1
            }
            let transformer = SDImageResizingTransformer(size: CGSize(width: (self.raffleCollectionView.frame.width / 2) - 10, height: 250), scaleMode: .fill)
            var imageURl = self.VM.myRafflesArray[indexPath.item].bannerUrl ?? ""
            print(imageURl)
            cell?.raffleButton.setTitle("View".localiz(), for: .normal)
            if imageURl != ""{
                let filteredURLArray = imageURl.split(separator: "~")
                let urltoUse = String(rafflesURL + filteredURLArray[0]).replacingOccurrences(of: " ", with: "%20")
                
                let urlt = URL(string: "\(urltoUse)")
                print(urlt)
                cell?.raffleImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"), context: [.imageTransformer: transformer])
            }else{
                cell?.raffleImage.image = UIImage(named: "ic_default_img")
            }
        }
        
        return cell!
    }
}
