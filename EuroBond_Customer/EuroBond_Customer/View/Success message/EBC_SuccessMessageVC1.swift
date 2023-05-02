//
//  EBC_SuccessMessageVC.swift
//  EuroBond_Customer
//
//  Created by admin on 31/03/23.
//

import UIKit

class EBC_SuccessMessageVC1: BaseViewController {

    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var messageTitleLbl: UILabel!
    @IBOutlet weak var successImage: UIImageView!
    var message: String = ""
    var messageTitle: String = ""
    var sucessImage = ""
    override func viewDidLoad() {
        super.viewDidLoad()

//        if messageTitle.count == 0{
//            messageTitleLbl.isHidden = true
//        }else{
//            messageTitleLbl.text = messageTitle
//        }
//        messageLbl.text = message
//        if sucessImage.count != 0{
//            successImage.image = UIImage(named: sucessImage)
//        }
        localizsetup()
    }
    
    
    func localizsetup(){
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(closePopMessage), userInfo: nil, repeats: false)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view{
            //        dismiss(animated: true)
        }
    }
    
    
    @objc func closePopMessage(){
        
        self.dismiss(animated: true){
            NotificationCenter.default.post(name: .moveToPrevious, object: nil)
        }
    }
    
}
