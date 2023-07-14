//
//  CodeSubmissionPopUp.swift
//  CenturyPly_JSON
//
//  Created by ADMIN on 28/04/2022.
//

import UIKit
import CoreData

class CodeSubmissionPopUp: BaseViewController{

    @IBOutlet weak var popUpMsg: UILabel!
    @IBOutlet weak var codeStatusBTN: GradientButton!
    @IBOutlet weak var uploadagain: GradientButton!
    @IBOutlet weak var raiseTicketsBTN: GradientButton!
    var scannedCodesArray = [String]()
    var storyboard1 = UIStoryboard(name: "Main", bundle: nil)
    var itsFrom = 0
    var sendScannedCodes:Array = [SendUploadedCodes]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(navigateIntoNextVc), name: Notification.Name.goToParticularVc, object: nil)
        
        languagelocalization()
    }
    @objc func navigateIntoNextVc(){
//        NotificationCenter.default.post(name: .deactivatedAcc, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.popUpMsg.text = "QR code is Submitted Successfully. Check the status of the code in  status report."
            self.codeStatusBTN.setTitle("Code Status", for: .normal)
            self.uploadagain.setTitle("Scan Again", for: .normal)
            self.raiseTicketsBTN.setTitle("Raise Ticket", for: .normal)
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.popUpMsg.text = "क्यूआर कोड सफलतापूर्वक सबमिट किया गया है। स्थिति रिपोर्ट में कोड की स्थिति की जाँच करें।"
            self.codeStatusBTN.setTitle("कोड स्थिति", for: .normal)
            self.uploadagain.setTitle("फिर से अपलोड करें", for: .normal)
            self.raiseTicketsBTN.setTitle("टिकट बढ़ाएं", for: .normal)
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.popUpMsg.text = "QR কোড সফলভাবে জমা দেওয়া হয়েছে। স্ট্যাটাস রিপোর্টে কোডের স্থিতি পরীক্ষা করুন।"
            self.codeStatusBTN.setTitle("কোড স্ট্যাটাস", for: .normal)
            self.uploadagain.setTitle("আবার আপলোড", for: .normal)
            self.raiseTicketsBTN.setTitle("টিকিট বাড়ান", for: .normal)
        }else{
            self.popUpMsg.text = "QR code is Submitted Successfully. Check the status of the code in  status report."
            self.codeStatusBTN.setTitle("Code Status", for: .normal)
            self.uploadagain.setTitle("Scan Again", for: .normal)
            self.raiseTicketsBTN.setTitle("Raise Ticket", for: .normal)
        }
    }
    

    @IBAction func closeBTN(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func codeSyncBTN(_ sender: Any) {
        self.clearTable2()
        self.itsFrom = 1
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CodeStatusListVC") as! CodeStatusListVC
        vc.itsFrom = 1
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
     
        self.present(vc, animated: true, completion: nil)
        
    }
    
    

    @IBAction func raiseTicketBTN(_ sender: Any) {
        
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("Check Internet Connection !!!", duration: 2.0, position: .bottom)
            }
        }else{
            self.itsFrom = 2
            let vc = self.storyboard1.instantiateViewController(withIdentifier: "EBC_CreatenewQueryVC") as! EBC_CreatenewQueryVC
            vc.isFrom = 2
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    @IBAction func uploadAgainBTN(_ sender: Any) {
        self.itsFrom = 3
        self.clearTable2()
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanOrUpload_VC") as! ScanOrUpload_VC
        NotificationCenter.default.post(name: .uploadAgain, object: nil)
        vc.itsFrom = "ScanCode"
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
            
        
    }
    func clearTable2(){
            
            let context = persistanceservice.persistentContainer.viewContext
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SendUploadedCodes")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print ("There was an error")
            }
        }
}
