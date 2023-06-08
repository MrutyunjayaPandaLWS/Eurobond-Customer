//
//  LINC_AlertOK_VC.swift
//  LINC
//
//  Created by Arokia-M3 on 05/07/21.
//

import UIKit
import CoreData
class LINC_AlertOK_VC: UIViewController {

    @IBOutlet var yesButton: UIButton!
    @IBOutlet var alertmessageLabel: UILabel!
    var productsLIST:Array = [AddToCART]()
    var titleInfo = ""
    var descriptionInfo = ""
    var isComeFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alertmessageLabel.text = descriptionInfo
        self.yesButton.setTitle(titleInfo, for: .normal)
    }
    
    @IBAction func yesButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        if isComeFrom == "Submit"{
            NotificationCenter.default.post(name: .navigateToPrevious, object: nil)
        }else if isComeFrom == "AccountDeactivate"{
            if UserDefaults.standard.integer(forKey: "UD_CustomerTypeID") == 1{
                UserDefaults.standard.setValue(false, forKey: "IsloggedIn?")
                print("Distributor Logout")
                if #available(iOS 13.0, *) {
                    DispatchQueue.main.async {
//                        let pushID = UserDefaults.standard.string(forKey: "UD_DEVICE_TOKEN") ?? ""
//                        let domain = Bundle.main.bundleIdentifier!
//                        UserDefaults.standard.removePersistentDomain(forName: domain)
//                        UserDefaults.standard.synchronize()
//                        UserDefaults.standard.setValue(pushID, forKey: "UD_DEVICE_TOKEN")
                        let sceneDelegate = self.view.window!.windowScene!.delegate as! SceneDelegate
                        sceneDelegate.setInitialViewAsRootViewController()
                    }
                }else{
                    DispatchQueue.main.async {
//                        let pushID = UserDefaults.standard.string(forKey: "UD_DEVICE_TOKEN") ?? ""
//                        let domain = Bundle.main.bundleIdentifier!
//                        UserDefaults.standard.removePersistentDomain(forName: domain)
//                        UserDefaults.standard.synchronize()
//                        UserDefaults.standard.setValue(pushID, forKey: "UD_DEVICE_TOKEN")
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.setInitialViewAsRootViewController()
                    }
                }
            }else{
                UserDefaults.standard.setValue(false, forKey: "IsloggedIn?")
                print("Retailer Logout")
                if #available(iOS 13.0, *) {
                    let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                    sceneDelegate.setInitialViewAsRootViewController()
                    clearTable()
                } else {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.setInitialViewAsRootViewController()
                    clearTable()
                }
            }
      
    }

    }
    
    func clearTable(){
        let context = persistanceservice.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "AddToCART")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }

}
