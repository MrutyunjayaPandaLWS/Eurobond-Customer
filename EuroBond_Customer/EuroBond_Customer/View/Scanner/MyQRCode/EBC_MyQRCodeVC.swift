//
//  EBC_MyQRCodeVC.swift
//  EuroBond_Customer
//
//  Created by admin on 04/04/23.
//

import UIKit


protocol MyQRCodeListDelegate{
    func didTappedCodeStatusBtn(item: EBC_MyQRCodeVC)
    func didTappedSubmitBtn(item: EBC_MyQRCodeVC)
}
class EBC_MyQRCodeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MyQrCodeTbleViewCellDelegate {
    func didTappedDeletBtn(item: EBC_MyQrCodeTVC) {
        print("code removed")
    }
    
  
    
    @IBOutlet weak var qrCodeListTV: UITableView!
    @IBOutlet weak var submitbtn: GradientButton!
    @IBOutlet weak var qrCodeNumber: UILabel!
    @IBOutlet weak var myQrCodesTitle: UILabel!
    var delegate: MyQRCodeListDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        qrCodeListTV.delegate = self
        qrCodeListTV.dataSource = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view{
            dismiss(animated: true)
        }
    }
    
    @IBAction func selectCodeStatusBtn(_ sender: Any) {
        dismiss(animated: true)
        delegate?.didTappedCodeStatusBtn(item: self)
    }
    
    @IBAction func selectSubmitBtn(_ sender: Any) {
        dismiss(animated: true)
        delegate?.didTappedSubmitBtn(item: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_MyQrCodeTVC", for: indexPath) as! EBC_MyQrCodeTVC
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
