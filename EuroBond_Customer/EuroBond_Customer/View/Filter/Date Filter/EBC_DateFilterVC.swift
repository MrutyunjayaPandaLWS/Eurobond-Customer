//
//  EBC_DateFilterVC.swift
//  EuroBond_Customer
//
//  Created by admin on 31/03/23.
//

import UIKit
protocol DateSelectedDelegate {
    func acceptDate(_ vc: EBC_DateFilterVC)
    func declineDate(_ vc: EBC_DateFilterVC)
}
class EBC_DateFilterVC: UIViewController {

    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var cancelbtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectDateTitleLbl: UILabel!
    
    let date = Date()
    let nameFormatter = DateFormatter()
    var selectedDate = ""
    var isComeFrom = ""
    var receivedDate = ""
    var delegate: DateSelectedDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.maximumDate = date
    }
    
    override func touchesBegan(_ touchscreen: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touchscreen.first
        if touch?.view != self.presentingViewController
        {
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    @IBAction func selectCancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func selectConfirmBtn(_ sender: UIButton) {
        let today = Date() //Jun 21, 2017, 7:18 PM
        let sevenDaysBeforeToday = Calendar.current.date(byAdding: .year, value: -18, to: today)!
        print(sevenDaysBeforeToday)
        if isComeFrom == "DOB"{
            if datePicker.date > sevenDaysBeforeToday{
                let alert = UIAlertController(title: "", message: "It seems you are less than 18 years of age. You can apply for EuroBond Membership only if you are 18 years and above", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                selectedDate = formatter.string(from: datePicker.date)
                self.delegate.acceptDate(self)
                self.dismiss(animated: true, completion: nil)
            }
        }else if isComeFrom == "ANNIVERSARY"{
            if datePicker.date > sevenDaysBeforeToday{
                let alert = UIAlertController(title: "", message: "It seems you are less than 18 years of age.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                selectedDate = formatter.string(from: datePicker.date)
                self.delegate.acceptDate(self)
                self.dismiss(animated: true, completion: nil)
            }
        }else if isComeFrom == "1"{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            selectedDate = formatter.string(from: datePicker.date)
            self.delegate.acceptDate(self)
            self.dismiss(animated: true, completion: nil)
        }else if isComeFrom == "2"{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            selectedDate = formatter.string(from: datePicker.date)
            self.delegate.acceptDate(self)
            self.dismiss(animated: true, completion: nil)
        }else{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            selectedDate = formatter.string(from: datePicker.date)
            self.delegate.acceptDate(self)
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    
    
}
