//
//  DreamGiftTableViewCell.swift
//  CenturyPly_JSON
//
//  Created by admin on 14/03/22.
//

import UIKit

protocol AddOrRemoveGiftDelegate{
    func redeemGift(_ cell: DreamGiftTableViewCell)
    func removeGift(_ cell: DreamGiftTableViewCell)
}

class DreamGiftTableViewCell: UITableViewCell {

    @IBOutlet weak var tdsvalue: UILabel!
    @IBOutlet weak var dreamGiftTitle: UILabel!
    @IBOutlet weak var giftName: UILabel!
    @IBOutlet weak var giftCreatedDate: UILabel!
    @IBOutlet weak var desiredDate: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var pointsRequired: UILabel!
    @IBOutlet weak var redeemButton: UIButton!
    @IBOutlet weak var removeGiftBTN: UIButton!
    @IBOutlet weak var progressViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var percentageValue: UILabel!
//    @IBOutlet weak var percentageLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var expiredDate: UILabel!
    @IBOutlet weak var ptsRequired: UILabel!
    @IBOutlet var progressPercentageLogoView: NSLayoutConstraint!
    
    
    var delegate: AddOrRemoveGiftDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.dreamGiftTitle.roundCorners(corners: [.bottomRight], radius: 20)
        progressView.layer.cornerRadius = 3.0
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.createdDate.text = "Created Date"
            self.expiredDate.text = "Desired Date"
            self.ptsRequired.text = "Points Required"
            self.redeemButton.setTitle("Redeem", for: .normal)
            
         }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
             self.createdDate.text = "सृजित दिनांक"
             self.expiredDate.text = "वांछित तारीख"
             self.ptsRequired.text = "अंक आवश्यक"
             self.redeemButton.setTitle("भुनाना", for: .normal)
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.createdDate.text = "তৈরির তারিখ"
            self.expiredDate.text = "কাঙ্খিত তারিখ"
            self.ptsRequired.text = "পয়েন্ট প্রয়োজন"
            self.redeemButton.setTitle("রিডিম", for: .normal)
        }else{
            self.createdDate.text = "Created Date"
            self.expiredDate.text = "Desired Date"
            self.ptsRequired.text = "Points Required"
            self.redeemButton.setTitle("Redeem", for: .normal)
          }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func redeemBTN(_ sender: Any) {
        self.delegate.redeemGift(self)
    }
    @IBAction func removeGift(_ sender: Any) {
        self.delegate.removeGift(self)
    }
    
}
