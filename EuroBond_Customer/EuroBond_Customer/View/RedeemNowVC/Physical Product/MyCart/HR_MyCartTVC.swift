//
//  HR_MyCartTVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/22/22.
//

import UIKit
protocol cartDetailsDelegate {
    func increaseProductQty(_ cell: HR_MyCartTVC)
    func decreaseProductQty(_ cell: HR_MyCartTVC)
    func removeProductsList(_ cell: HR_MyCartTVC)
}

class HR_MyCartTVC: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var minusBTN: UIButton!
    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet weak var addBTN: UIButton!
    @IBOutlet weak var productPoints: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var removeProductsBTN: UIButton!
    @IBOutlet weak var categoryName: UILabel!
    var delegate: cartDetailsDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func decreaseCount(_ sender: Any) {
        self.delegate.decreaseProductQty(self)
    }
    @IBAction func increaseCount(_ sender: Any) {
        self.delegate.increaseProductQty(self)
    }
    
    @IBAction func removeProductList(_ sender: Any) {
        self.delegate.removeProductsList(self)
    }
}
