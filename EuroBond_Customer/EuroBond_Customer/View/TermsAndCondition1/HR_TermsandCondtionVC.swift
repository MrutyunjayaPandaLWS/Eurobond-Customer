//
//  HR_TermsandCondtionVC.swift
//  HR_Johnson
//
//  Created by ADMIN on 14/05/2022.
//

import UIKit
import LanguageManager_iOS
import WebKit
protocol CheckBoxSelectDelegate{
    func accept(_ vc: HR_TermsandCondtionVC)
    func decline(_ vc: HR_TermsandCondtionVC)
}

class HR_TermsandCondtionVC: BaseViewController{


    @IBOutlet weak var webview1: WKWebView!
    @IBOutlet weak var decline: UIButton!
    @IBOutlet weak var accept: UIButton!


    var delegate: CheckBoxSelectDelegate!
    var requestAPIs = RestAPI_Requests()
    var tcListingArray = [LstTermsAndCondition]()
    var language = ""
    override func viewDidLoad() {
        super.viewDidLoad()
//        termsandCondtions.text = "TermsandConditions"
//        decline.setTitle("decline", for: .normal)
//        accept.setTitle("accept", for: .normal)
        //dashboardTCApi()
//        self.webview1.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "eurobond-t&c", ofType: "html")!) as URL) as URLRequest)
        langLocaliz()
    }
    
    
    func langLocaliz(){
        self.decline.setTitle("decline".localiz(), for: .normal)
        self.accept.setTitle("accept".localiz(), for: .normal)
        if decline.currentTitle == "Decline" {
            self.webview1.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "eurobond-t&c-eng", ofType: "html")!) as URL) as URLRequest)
        }else{
            self.webview1.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "eurobond-t&c-hin", ofType: "html")!) as URL) as URLRequest)
        }
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
//                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
//                                vc!.delegate = self
//                                vc!.titleInfo = ""
//                                vc!.descriptionInfo = "No terms and Conditions Found"
//                                vc!.modalPresentationStyle = .overCurrentContext
//                                vc!.modalTransitionStyle = .crossDissolve
//                                self.present(vc!, animated: true, completion: nil)
                            }
                        }else{
//                            if "TermsandConditions" == "Terms and Conditions"{
                                for item in self.tcListingArray{
                                    if item.language == "English"{

                                        self.loadHTMLStringImage(htmlString: item.html ?? "")
                                        return
                                    }
                                }
//                            }else{
//                                for item in self.tcListingArray{
//                                    if item.language == "Hindi"{
//
//                                        self.loadHTMLStringImage(htmlString: item.html ?? "")
//                                        return
//                                    }
//                                }
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
        webview1.loadHTMLString(htmlString, baseURL: nil)
       }
    @IBAction func declineBTN(_ sender: Any) {
        self.delegate.decline(self)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func acceptBTN(_ sender: Any) {

        self.delegate.accept(self)
        self.dismiss(animated: true, completion: nil)
    }
}
