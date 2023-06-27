//
//  EBC_IOS_PlayAndWin.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 15/06/2023.
//

import UIKit
import LanguageManager_iOS

class EBC_IOS_PlayAndWin: UIViewController {

    @IBOutlet weak var raffelTextLbl: UILabel!
    @IBOutlet weak var raffelOutView: UIView!
    @IBOutlet weak var gameZoneOutView: UIView!
    @IBOutlet weak var gameZoneTextLbl: UILabel!
    @IBOutlet weak var playAndWinHeadingLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameZoneOutView.clipsToBounds = true
        gameZoneOutView.layer.cornerRadius = 15
        gameZoneOutView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        raffelOutView.clipsToBounds = true
        raffelOutView.layer.cornerRadius = 15
        raffelOutView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

    }
    
    func localize(){
        self.raffelTextLbl.text = "Raffles".localiz()
        self.gameZoneTextLbl.text = "Game Zone".localiz()
        self.playAndWinHeadingLbl.text = "playAndWin".localiz()
    }
    
    @IBAction func gameZoneActBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_GameCentre_VC") as?  EBC_GameCentre_VC //EBC_GameZoneVC//EBC_ComingSoonVC
        navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func raffelActBtn(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Raffles_VC") as? Raffles_VC
        vc?.isComeFrom = "OnGoingRaffles"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
}
