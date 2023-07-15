//
//  LINC_MyAttempts_CVC.swift
//  LINC
//
//  Created by Arokia-M3 on 16/07/21.
//

import UIKit
import LanguageManager_iOS

class EBC_MyAttempts_CVC: UICollectionViewCell {

    @IBOutlet weak var resultTitleLbl: UILabel!
    @IBOutlet weak var dateTitleLbl: UILabel!
    @IBOutlet weak var referenceIDTitleLbl: UILabel!
    @IBOutlet var colorview: UIView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var result: UILabel!
    @IBOutlet var referenceID: UILabel!
    @IBOutlet var playedName: UILabel!
    @IBOutlet var playedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        localization()
    }
    
    private func localization(){
        self.resultTitleLbl.text = "Result".localiz()
        self.dateTitleLbl.text = "Date".localiz()
        self.referenceIDTitleLbl.text = "Reference ID".localiz()
    }

}
