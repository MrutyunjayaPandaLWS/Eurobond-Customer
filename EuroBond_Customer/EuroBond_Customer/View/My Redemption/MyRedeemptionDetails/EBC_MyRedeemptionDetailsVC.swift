//
//  EBC_MyRedeemptionDetailsVC.swift
//  EuroBond_Customer
//
//  Created by syed on 28/03/23.
//

import UIKit

class EBC_MyRedeemptionDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var orderStatusTV: UITableView!
    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var cartNumber: UILabel!
    @IBOutlet weak var eurosTitleLbl: UILabel!
    @IBOutlet weak var cartBalanceLbl: UILabel!
    @IBOutlet weak var cancelOrderBtn: UIButton!
    @IBOutlet weak var OrderStatusTitleLbl: UILabel!
    @IBOutlet weak var productBalLbl: UILabel!
    @IBOutlet weak var eurosTitle1: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var termAndConditionLbl: UILabel!
    @IBOutlet weak var termAndConditionTitle: UILabel!
    @IBOutlet weak var descriptionDetailsLbl: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var quantityTitle: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDate: UILabel!
    @IBOutlet weak var productCode: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var VCtitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        orderStatusTV.delegate = self
        orderStatusTV.dataSource = self
        cancelOrderBtn.isHidden = true
        emptyMessage.isHidden = true
        setupData()
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectMyCartBtn(_ sender: UIButton) {
    }
    
    @IBAction func selectOrderCancelBtn(_ sender: UIButton) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewHeight.constant = CGFloat(3*75)
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_MyRedeemptionDetailsTVC", for: indexPath) as! EBC_MyRedeemptionDetailsTVC
        if indexPath.row == 0{
            cell.topLine.isHidden = true
        }else{
            cell.topLine.isHidden = false
        }
        if indexPath.row == 2{
            cell.bottomLine.isHidden = true
        }
        cell.selectionStyle = .none
        
        cell.oderDate.text = "02/02/2023"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    func setupData(){
        
        productName.text = "Sony Xperia 1S | 12GB RAM 128GB | 5G Smart Phone"
        quantityLbl.text = "1"
        productCode.text = "RR-15698-3"
        productDate.text = "2/11/2021"
        descriptionDetailsLbl.text = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."
        termAndConditionLbl.text = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. Read more..."
        productBalLbl.text = "25000"
        cartBalanceLbl.text = "10000"
        productImage.image = UIImage(named: "demoImg-2")
        
        
    }

}
