//
//  EBC_CodeSummeryVC.swift
//  EuroBond_Customer
//
//  Created by admin on 30/03/23.
//

import UIKit

class EBC_CodeSummeryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var codeSummeryListTV: UITableView!
    @IBOutlet weak var titleVC: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        codeSummeryListTV.delegate = self
        codeSummeryListTV.dataSource = self
    }
    
    @IBAction func selectBAckBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_CodeSummeryTVC", for: indexPath) as! EBC_CodeSummeryTVC
        cell.selectionStyle = .none
        return cell
    }
    

}
