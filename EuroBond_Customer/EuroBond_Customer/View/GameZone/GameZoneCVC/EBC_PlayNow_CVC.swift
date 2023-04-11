//
//  LINC_PlayNow_CVC.swift
//  LINC
//
//  Created by Arokia-M3 on 16/07/21.
//

import UIKit
protocol playNowDelegate : class {
    func startNowButtonTap(_ cell: EBC_PlayNow_CVC)
}

class EBC_PlayNow_CVC: UICollectionViewCell {

    @IBOutlet var colorview: UIView!
    @IBOutlet var playStartButton: UIButton!
    @IBOutlet var playName: UILabel!
    @IBOutlet var playImage: UIImageView!
    var delegate:playNowDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBAction func playStartButton(_ sender: Any) {
        self.delegate?.startNowButtonTap(self)
    }
    
}
