//
//  CodeStatusTVC.swift
//  CenturyPly_JSON
//
//  Created by ADMIN on 28/04/2022.
//

import UIKit
protocol CheckBoxSelectionDelegate{
    func checkBoxSelection(_ cell: CodeStatusTVC)
}
class CodeStatusTVC: UITableViewCell {

    @IBOutlet weak var checkBoxBTN: UIButton!
    @IBOutlet weak var codeStatusImage: UIImageView!
    @IBOutlet weak var uploadCode: UILabel!
    @IBOutlet weak var codeStatusMsg: UILabel!
    @IBOutlet weak var uploadedDate: UILabel!
    @IBOutlet weak var viewTrailingSpaceConstrant: NSLayoutConstraint!
    var delegate: CheckBoxSelectionDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkBoxActionBTN(_ sender: Any) {
        self.delegate.checkBoxSelection(self)
    }
    
}
