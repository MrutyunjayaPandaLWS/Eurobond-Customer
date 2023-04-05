//
//  EBC_RedeemNowVC.swift
//  EuroBond_Customer
//
//  Created by syed on 21/03/23.
//

import UIKit

class EBC_RedeemNowVC: UIViewController {

    @IBOutlet weak var cartValue: UILabel!
    @IBOutlet weak var eurosLbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var titleVC: UILabel!
    @IBOutlet weak var segmentController: UISegmentedControl!
    var container: ContainerViewController!
    var flags = "1"
    override func viewDidLoad() {
        super.viewDidLoad()

        segmentController.selectedSegmentIndex = 0
        let font = UIFont.systemFont(ofSize: 13)
        segmentController.setTitleTextAttributes([NSAttributedString.Key.font: font],
                                                for: .normal)
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentController.setTitleTextAttributes(titleTextAttributes1, for: .selected)
        segmentController.setTitleTextAttributes(titleTextAttributes, for: .normal)
        
        self.container.segueIdentifierReceivedFromParent("first")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"{
            self.container = segue.destination as? ContainerViewController
        }
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        if flags == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectSegmentController(_ sender: UISegmentedControl) {
        if segmentController.selectedSegmentIndex == 0{
            container.segueIdentifierReceivedFromParent("first")
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentController.setTitleTextAttributes(titleTextAttributes, for: .selected)
        }else if segmentController.selectedSegmentIndex == 1{
            container.segueIdentifierReceivedFromParent("second")
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentController.setTitleTextAttributes(titleTextAttributes, for: .selected)
        }else{
            container.segueIdentifierReceivedFromParent("third")
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentController.setTitleTextAttributes(titleTextAttributes, for: .selected)
        }
        
    }
    
}


extension UISegmentedControl{
    func selectedSegmentTintColor(_ color: UIColor) {
        self.setTitleTextAttributes([.foregroundColor: color], for: .selected)
    }
    func unselectedSegmentTintColor(_ color: UIColor) {
        self.setTitleTextAttributes([.foregroundColor: color], for: .normal)
    }
}
