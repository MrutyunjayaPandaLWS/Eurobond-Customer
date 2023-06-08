//
//  LINC_ProductSummary_TVC.swift
//  LINC
//
//  Created by Arokia-M3 on 06/07/21.
//

import UIKit
protocol ordersummaryDelegate : class {
    func ordersummaryremoveDidTap(_ cell: LINC_ProductSummary_TVC)
    func ordersummaryupdateDidTap(_ cell: LINC_ProductSummary_TVC)
    func ordersummaryCountDidTap(_ cell: LINC_ProductSummary_TVC)

}
class LINC_ProductSummary_TVC: UITableViewCell {

    @IBOutlet var removeButton: UIButton!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var minusProductButton: UIButton!
    @IBOutlet var addProductButton: UIButton!
    @IBOutlet var productCountTF: UITextField!
    @IBOutlet var ordervalueLabel: UILabel!
    @IBOutlet var uomLabel: UILabel!
    @IBOutlet var colorLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var mrpLabel: UILabel!
    @IBOutlet var productDescriptionLabel: UILabel!
    @IBOutlet var productTitleLabel: UILabel!
    var delegate:ordersummaryDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func minusProductButton(_ sender: Any) {
        if self.productCountTF.text! > "\(Int(1))"{
            self.productCountTF.text = "\(Int(self.productCountTF.text ?? "0")! - 1)"
            self.delegate?.ordersummaryupdateDidTap(self)
        }else{
            self.productCountTF.text = "\(Int(1))"
        }
        
    }
    @IBAction func addProductButton(_ sender: Any) {
        self.productCountTF.text = "\(Int(self.productCountTF.text ?? "0")! + 1)"
        self.delegate?.ordersummaryupdateDidTap(self)
    }
    @IBAction func removeButton(_ sender: Any) {
        self.delegate?.ordersummaryremoveDidTap(self)

    }
    @IBAction func countDidEnd(_ sender: Any) {
        self.delegate?.ordersummaryCountDidTap(self)
    }
    
    
}
