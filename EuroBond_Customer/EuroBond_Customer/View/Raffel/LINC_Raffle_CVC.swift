//
//  LINC_Raffle_CVC.swift
//  LINC
//
//  Created by Arokia-M3 on 16/07/21.
//

import UIKit

protocol RaffleDelegate : class {
    func raffleBtn(_ cell: LINC_Raffle_CVC)
}

class LINC_Raffle_CVC: UICollectionViewCell {

    @IBOutlet var raffleButton: UIButton!
    @IBOutlet var raffleName: UILabel!
    @IBOutlet var raffleImage: UIImageView!
    
    var delegate:RaffleDelegate?
    
    @IBAction func raffleButton(_ sender: Any) {
        self.delegate?.raffleBtn(self)
    }
    
}
