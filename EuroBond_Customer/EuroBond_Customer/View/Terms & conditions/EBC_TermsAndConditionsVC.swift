//
//  EBC_TermsAndConditionsVC.swift
//  EuroBond_Customer
//
//  Created by admin on 04/04/23.
//

import UIKit
import WebKit

class EBC_TermsAndConditionsVC: BaseViewController, popUpAlertDelegate {
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    

    @IBOutlet weak var webView: WKWebView!
    var requestAPIs = RestAPI_Requests()
    var tcListingArray = [LstTermsAndCondition]()
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.webView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "eurobond-t&c", ofType: "html")!) as URL) as URLRequest)
        self.dashboardTCApi()
        
    }
    
    
    
    @IBAction func selectBackBtn(_ sender: Any) {
        NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
        self.navigationController?.popViewController(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    func dashboardTCApi(){
        DispatchQueue.main.async {
        self.startLoading()
        }
        let parameters = [
            "ActionType": 1,
             "ActorId": 2
        ] as [String: Any]
        print(parameters)
        self.requestAPIs.TCDetails(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.stopLoading()
                        self.tcListingArray = result?.lstTermsAndCondition ?? []
                        if self.tcListingArray.count == 0{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.descriptionInfo = "No terms and Conditions Found"
                                vc!.modalPresentationStyle = .overCurrentContext
                                vc!.modalTransitionStyle = .crossDissolve
                                self.present(vc!, animated: true, completion: nil)
                            }
                        }else{
                            
                                for item in self.tcListingArray{
                                    if item.language == "English"{
                                        
                                        self.loadHTMLStringImage(htmlString: item.html ?? "")
                                        return
                                    }
                                }
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.stopLoading()
                }
            }
        }
    }

    func loadHTMLStringImage(htmlString:String) -> Void {
           let htmlString = "\(htmlString)"
        webView.loadHTMLString(htmlString, baseURL: nil)
       }
    
    

}
