//
//  ScannedCode_TVC.swift
//  centuryDemo
//
//  Created by Arokia-M3 on 16/03/22.
//

import UIKit

protocol RemoveCodeDelegate{
func removeScannedCode(_ cell: ScannedCode_TVC)
}

class ScannedCode_TVC: UITableViewCell {


    @IBOutlet weak var codeLabel: UILabel!
    var delegate: RemoveCodeDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteButton(_ sender: Any) {
        self.delegate.removeScannedCode(self)
    }
    
}
