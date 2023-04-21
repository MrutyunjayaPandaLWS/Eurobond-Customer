//
//  SyncStatus_TVC.swift
//  centuryDemo
//
//  Created by Arokia-M3 on 16/03/22.
//

import UIKit
protocol checkMarkDelegate: AnyObject {
    func checkMarkDidTap(_ vc: SyncStatus_TVC)
}

class SyncStatus_TVC: UITableViewCell {

    @IBOutlet var statusImageView: UIImageView!
    @IBOutlet var CodeLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var checkMarkButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    var delegate: checkMarkDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func checkMarkButton(_ sender: Any) {
        (self.delegate.checkMarkDidTap)(self)
    }
}
