//
//  LINC_GameCentre_VC.swift
//  LINC
//
//  Created by Arokia-M3 on 05/07/21.
//

import UIKit
import SDWebImage
import WebKit

class EBC_GameCentre_VC: BaseViewController, UIWebViewDelegate, playNowDelegate {

    @IBOutlet var webviewSpin: UIWebView!
    @IBOutlet var gameCentreCollectionView: UICollectionView!
    @IBOutlet var segmentedControll: UISegmentedControl!
    @IBOutlet var backButton: UIButton!
    var VM = EBC_GameCenter_VM()
    var flags = "1"
    let layaltyID = UserDefaults.standard.string(forKey: "UD_LoyaltyId") ?? ""

    
    override func viewDidLoad() {
        self.VM.VC = self
        self.webviewSpin.delegate = self
        gameCentreCollectionView.register(UINib(nibName: "EBC_PlayNow_CVC", bundle: nil), forCellWithReuseIdentifier: "EBC_PlayNow_CVC")
        gameCentreCollectionView.register(UINib(nibName: "EBC_MyAttempts_CVC", bundle: nil), forCellWithReuseIdentifier: "EBC_MyAttempts_CVC")

        self.gameCentreCollectionView.delegate = self
        self.gameCentreCollectionView.dataSource = self
        self.segmentedControll.layer.backgroundColor = UIColor.white.cgColor
    }
    @IBAction func segmentedcontroll(_ sender: Any) {
        self.VM.gameListArray.removeAll()
        if segmentedControll.selectedSegmentIndex == 0{
            let parameterJSON = [
                "ActionType":"1",
                "LoyaltyId":layaltyID
            ]
            self.VM.gameListDetails(parameters: parameterJSON)
        }else{
            let parameterJSON = [
                "ActionType":"2",
                "LoyaltyId":layaltyID
            ]
            print(parameterJSON,"MyAttempts")
            self.VM.gameListDetails(parameters: parameterJSON)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        if flags == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = gameCentreCollectionView.frame.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: (width - 10) / 2, height: 180)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        gameCentreCollectionView!.collectionViewLayout = layout

    }
    override func viewWillAppear(_ animated: Bool) {
      
        segmentedControll.selectedSegmentIndex = 0
        let parameterJSON = [
            "ActionType":"1",
            "LoyaltyId":layaltyID
        ]
        print(parameterJSON, "GameListApi")
        self.VM.gameListDetails(parameters: parameterJSON)
    }
    
    //Delegate
    
    func startNowButtonTap(_ cell: EBC_PlayNow_CVC) {
        
        guard let tappedIndexPath = gameCentreCollectionView.indexPath(for: cell) else { return }
        if self.VM.gameListArray[tappedIndexPath.item].gameId ?? 0 == 2{//scratch card
            DispatchQueue.main.async{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_ScratchCard_VC") as? EBC_ScratchCard_VC
                vc!.customerGamifyTransactionId = self.VM.gameListArray[tappedIndexPath.item].customerGamifyTransactionId ?? 0
                vc!.pointResult = self.VM.gameListArray[tappedIndexPath.item].pointResult ?? 0
                vc!.gamedetail.append(self.VM.gameListArray[tappedIndexPath.item])
            self.navigationController?.pushViewController(vc!, animated: true)
            }
        }else if self.VM.gameListArray[tappedIndexPath.item].gameId ?? 0 == 3{//magic box
            DispatchQueue.main.async{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_MagicBoxVC") as? EBC_MagicBoxVC
                vc!.customerGamifyTransactionId = self.VM.gameListArray[tappedIndexPath.item].customerGamifyTransactionId ?? 0
                vc!.pointResult = self.VM.gameListArray[tappedIndexPath.item].pointResult ?? 0
                vc!.date = "\(self.VM.gameListArray[tappedIndexPath.item].gamePlayedDate ?? "")"
                vc!.gamedetail.append(self.VM.gameListArray[tappedIndexPath.item])

            self.navigationController?.pushViewController(vc!, animated: true)
            }
        }else{
            let urltoChange = self.VM.gameListArray[tappedIndexPath.item].gameName ?? ""
            let splittedURL = urltoChange.split(separator: "~")
            if splittedURL.count > 1{
                guard let url = URL(string: "\(splittedURL[1])?r1=\(self.VM.gameListArray[tappedIndexPath.item].pointResult ?? 0)&s2=\(self.VM.gameListArray[tappedIndexPath.item].rangeValues ?? "")&g4=\(self.VM.gameListArray[tappedIndexPath.item].customerGamifyTransactionId ?? -1)&URL=http://demoserv2.arokiait.com/LCLP") else { return }
                print(url)
                webviewSpin.loadRequest(URLRequest(url: url))
                self.webviewSpin.isHidden = false
            }else{
                //invalid url
                self.view.makeToast("Invalid URL", duration: 5.0, position: .bottom)
            }
        }
    }
}
extension EBC_GameCentre_VC: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.VM.gameListArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if segmentedControll.selectedSegmentIndex == 0{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EBC_PlayNow_CVC", for: indexPath) as? EBC_PlayNow_CVC
            cell?.delegate = self
            let transformer = SDImageResizingTransformer(size: CGSize(width: (self.gameCentreCollectionView.frame.width / 2) - 10, height: 180), scaleMode: .fill)
            var imageURl = self.VM.gameListArray[indexPath.item].gameImage ?? ""
            print(imageURl)
            if imageURl != ""{
                let filteredURLArray = imageURl.split(separator: "~")
//                let urltoUse = String(WhatsNewURL + filteredURLArray[1]).replacingOccurrences(of: " ", with: "%20")
                
//                let urlt = URL(string: "\(urltoUse)")
//                print(urlt)
//                cell?.playImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"), context: [.imageTransformer: transformer])
            }
            if self.VM.gameListArray[indexPath.item].gameId ?? 0 == 3{
                cell?.colorview.backgroundColor = UIColor(red: 223/255, green: 181/255, blue: 76/255, alpha: 1.0)
                cell?.playName.text = "Magic Box"

            }else if self.VM.gameListArray[indexPath.item].gameId ?? 0 == 2{
                cell?.colorview.backgroundColor = UIColor(red: 39/255, green: 72/255, blue: 140/255, alpha: 1.0)
                cell?.playName.text = "Scratch Card"


            }else{
                cell?.colorview.backgroundColor = UIColor(red: 39/255, green: 72/255, blue: 140/255, alpha: 1.0)
                cell?.playName.text = "Spin Wheel"

            }
            return cell!
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EBC_MyAttempts_CVC", for: indexPath) as? EBC_MyAttempts_CVC
            
            cell?.dateLabel.text = self.VM.gameListArray[indexPath.item].gamePlayedDate ?? ""
            cell?.referenceID.text = self.VM.gameListArray[indexPath.item].referenceId ?? ""
            cell?.result.text = String(self.VM.gameListArray[indexPath.item].pointResult ?? 0)

            let transformer = SDImageResizingTransformer(size: CGSize(width: (self.gameCentreCollectionView.frame.width / 2) - 10, height: 180), scaleMode: .fill)
            var imageURl = self.VM.gameListArray[indexPath.item].gameImage ?? ""
            print(imageURl)
            if imageURl != ""{
                let filteredURLArray = imageURl.split(separator: "~")
//                let urltoUse = String(WhatsNewURL + filteredURLArray[1]).replacingOccurrences(of: " ", with: "%20")
                
//                let urlt = URL(string: "\(urltoUse)")
//                print(urlt)
//                cell?.playedImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"), context: [.imageTransformer: transformer])
            }
            if self.VM.gameListArray[indexPath.item].gameId ?? 0 == 3{
                cell?.colorview.backgroundColor = UIColor(red: 223/255, green: 181/255, blue: 76/255, alpha: 1.0)
                cell?.playedName.text = "Magic Box"

            }else if self.VM.gameListArray[indexPath.item].gameId ?? 0 == 2{
                cell?.colorview.backgroundColor = UIColor(red: 39/255, green: 72/255, blue: 140/255, alpha: 1.0)
                cell?.playedName.text = "Scratch Card"


            }else{
                cell?.colorview.backgroundColor = UIColor(red: 39/255, green: 72/255, blue: 140/255, alpha: 1.0)
                cell?.playedName.text = "Spin Wheel"
            }
            return cell!
        }
    }
}
