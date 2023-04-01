//
//  EBC_CreatenewQueryVC.swift
//  EuroBond_Customer
//
//  Created by admin on 31/03/23.
//

import UIKit

class EBC_CreatenewQueryVC: UIViewController {

    @IBOutlet weak var browseImageBtn: GradientButton!
    @IBOutlet weak var queryImage: UIImageView!
    @IBOutlet weak var queryDetailsTF: UITextField!
    @IBOutlet weak var queryDetailsTitle: UILabel!
    @IBOutlet weak var summeryTF: UITextField!
    @IBOutlet weak var lodgeQueryTitleLbl: UILabel!
    @IBOutlet weak var selectTopicLbl: UILabel!
    @IBOutlet weak var selectTopicTitleLbl: UILabel!
    @IBOutlet weak var createQueryInfoLbl: UILabel!
    @IBOutlet weak var titleVC: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectTopicBtn(_ sender: Any) {
    }
    
    @IBAction func selectBrowseBtn(_ sender: Any) {
    }
    
    @IBAction func selectQueryBtn(_ sender: Any) {
    }
    
}
