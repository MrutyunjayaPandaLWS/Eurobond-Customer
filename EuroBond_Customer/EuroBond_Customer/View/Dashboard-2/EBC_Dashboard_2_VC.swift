//
//  EBC_Dashboard_2_VC.swift
//  EuroBond_Customer
//
//  Created by syed on 18/03/23.
//

import UIKit
import ImageSlideshow
import SlideMenuControllerSwift
import Lottie
import Alamofire

class EBC_Dashboard_2_VC: BaseViewController {

    @IBOutlet weak var defaultImage: UIImageView!
    @IBOutlet weak var termCondLbl: UILabel!
    @IBOutlet weak var helpLineLbl: UILabel!
    @IBOutlet weak var needHelpLbl: UILabel!
    @IBOutlet weak var codeSummeryLbl: UILabel!
    @IBOutlet weak var syncStatusLbl: UILabel!
    @IBOutlet weak var codeStatusLbl: UILabel!
    @IBOutlet weak var memberSinceLbl: UILabel!
    @IBOutlet weak var memberSinceTitleLbl: UILabel!
    @IBOutlet weak var membershipIDLbl: UILabel!
    @IBOutlet weak var membershipIDTitleLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    @IBOutlet weak var notificationBadgesLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var subView: GradientView!
    var status = 1
    var sourceArray = [AlamofireSource]()
    var offerimgArray = [ObjImageGalleryList]()
    var VM = EBC_FabricatedDashBoardVM()
    var dashBoardId = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.defaultImage.isHidden = true

        subView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        subView.layer.cornerRadius = 20
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        bottomView.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.slideMenuController()?.closeLeft()
        self.tokendata()
    }
    
    @IBAction func selectLogoutBtn(_ sender: UIButton) {
        UserDefaults.standard.set(-1, forKey: "IsloggedIn?")
        if #available(iOS 13.0, *) {
            DispatchQueue.main.async {
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.setInitialLoginVC()
            }
        } else {
            DispatchQueue.main.async {
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                if #available(iOS 13.0, *) {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.setInitialLoginVC()
                }
            }
        }
    }
    
    @IBAction func selectNotificationBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HistoryNotificationsViewController") as?  HistoryNotificationsViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func selectCodeStatusBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "CodeStatusListVC") as? CodeStatusListVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectSyncStatusBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "SyncStatus_VC") as? SyncStatus_VC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectCodeSummeryBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "CodeSummary_VC") as? CodeSummary_VC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectUploadCodeBtn(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanOrUpload_VC") as! ScanOrUpload_VC
        vc.itsFrom = "UploadCode"
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func selectScanCodeBtn(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanOrUpload_VC") as! ScanOrUpload_VC
        vc.itsFrom = "ScanCode"
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func selectHelpLineBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "EBC_HelpLineVC") as? EBC_HelpLineVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectTermCondBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "EBC_TermsAndConditionsVC") as? EBC_TermsAndConditionsVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func ImageSetups(){
        self.sourceArray.removeAll()
        if self.offerimgArray.count > 0 {
            for image in self.offerimgArray {
                print("\(PROMO_IMG1)\(image.imageGalleryUrl ?? ""), sdafasf")
                let imageURL = image.imageGalleryUrl ?? ""
                let filteredURLArray = imageURL.dropFirst(1)
                let replaceString = "\(PROMO_IMG1)\(filteredURLArray)".replacingOccurrences(of: " ", with: "%20")
                print(replaceString)
                self.sourceArray.append(AlamofireSource(urlString: "\(replaceString)", placeholder: UIImage(named: "ic_default_img"))!)
            }
            imageSlideShow.setImageInputs(self.sourceArray)
            imageSlideShow.slideshowInterval = 3.0
            imageSlideShow.zoomEnabled = true
            imageSlideShow.contentScaleMode = .scaleToFill
//            bannerImage.pageControl.currentPageIndicatorTintColor = UIColor(red: 230/255, green: 27/255, blue: 34/255, alpha: 1)
//            bannerImage.pageControl.pageIndicatorTintColor = UIColor.lightGray
        }else{
            self.defaultImage.isHidden = false
//            imageSlideShow.setImageInputs([
//                ImageSource(image: UIImage(named: "dashboardIMG222")!)
//            ])
        }
    }
    @objc func didTap() {
        if self.offerimgArray.count > 0 {
            imageSlideShow.presentFullScreenController(from: self)
        }
    }
//
    func tokendata(){
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
        }else{
            let parameters : Data = "username=\(username)&password=\(password)&grant_type=password".data(using: .utf8)!

        let url = URL(string: tokenURL)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = parameters
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
       
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do{
                let parseddata = try JSONDecoder().decode(TokenModels.self, from: data)
                    print(parseddata.access_token ?? "")
                    UserDefaults.standard.setValue(parseddata.access_token ?? "", forKey: "TOKEN")
                self.dashBoardApi()
                if self.dashBoardId == -1{
                    self.dashBoardBannerApi()
                    self.dashBoardId = 1
                }
                 }catch let parsingError {
                print("Error", parsingError)
            }
        })
        task.resume()
    }
    }
    func dashBoardApi(){
        let parameter = [
            "ActorId":"\(self.userId)"
        ] as [String: Any]
        print(parameter)
        self.VM.dashboardApi(parameter: parameter)
    }
    
    func dashBoardBannerApi(){
        let parameter = [
            "ObjImageGallery": [
                    "AlbumCategoryID": "1"
                ]
        ] as [String: Any]
        print(parameter)
        self.VM.dashboardBannerApi(parameter: parameter)
    }
}
