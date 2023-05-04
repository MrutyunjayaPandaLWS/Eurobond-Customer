//
//  EBC_DashboardVC.swift
//  EuroBond_Customer
//
//  Created by syed on 18/03/23.
//

import UIKit
import ImageSlideshow
import SlideMenuControllerSwift
import Lottie
import Alamofire
import AVFoundation
import AVKit
import LanguageManager_iOS
import Lottie

class EBC_DashboardVC: BaseViewController {

    @IBOutlet weak var defaultImage: UIImageView!
    @IBOutlet weak var myEarningsLbl: UILabel!
    @IBOutlet weak var myredemptionLbl: UILabel!
    @IBOutlet weak var codeStatusLbl: UILabel!
    @IBOutlet weak var bottomView1: UIView!
    @IBOutlet weak var helplineLbl: UILabel!
    @IBOutlet weak var eurobondsLbl: UILabel!
    @IBOutlet weak var referAndEarnLbl: UILabel!
    @IBOutlet weak var shemesAndOffersLbl: UILabel!
    @IBOutlet weak var gameZoneLbl: UILabel!
    @IBOutlet weak var redeemNowLbl: UILabel!
    @IBOutlet weak var totalBalanceLbl: UILabel!
    @IBOutlet weak var totalEurosTitleLbl: UILabel!
    @IBOutlet weak var memberTypeLbl: UILabel!
    @IBOutlet weak var memberTypeTitleLbl: UILabel!
    @IBOutlet weak var membershipIDLbl: UILabel!
    @IBOutlet weak var membershipIdTitleLbl: UILabel!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    @IBOutlet weak var notificationBadges: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var userDetailsView: UIView!
    
    @IBOutlet weak var maintenanceView: UIView!
    @IBOutlet weak var underMaintenance: LottieAnimationView!
    
    
    var status = 1
    var sourceArray = [AlamofireSource]()
    var offerimgArray = [ObjImageGalleryList]()
    var VM = EBC_DashBoardVM()
    var dashBoardId = -1
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.maintenanceView.isHidden = true
        self.dashBoardId = -1
        self.defaultImage.isHidden = true
        self.notificationBadges.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(codeStatus), name: Notification.Name.optionView, object: nil)
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.slideMenuController()?.closeLeft()
        self.tokendata()
        self.localizSetup()
        self.maintenanceAPI()
        self.isUpdateAvailable()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bottomView1.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        bottomView1.layer.cornerRadius = 30
        
        userDetailsView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        userDetailsView.layer.cornerRadius = 20
        
        slideMenuController()?.changeLeftViewWidth(self.view.frame.size.width * 0.89)
        SlideMenuOptions.contentViewScale = 1
    }
    
    
    func localizSetup(){
        membershipIdTitleLbl.text = "Membership ID".localiz()
        welcomeLbl.text = "Welcome".localiz()
        memberTypeTitleLbl.text = "Member Type".localiz()
        totalEurosTitleLbl.text = "Total Euros".localiz()
        redeemNowLbl.text = "Redeem Now".localiz()
        gameZoneLbl.text = "Game Zone".localiz()
        shemesAndOffersLbl.text = "Schemes".localiz()
        referAndEarnLbl.text = "Refer & Earn".localiz()
        eurobondsLbl.text = "EurobondProfile".localiz()
        helplineLbl.text = "Helpline".localiz()
        codeStatusLbl.text = "Code Status".localiz()
        myredemptionLbl.text = "My Redemption".localiz()
        myEarningsLbl.text = "My Earnings".localiz()
    }
    
    
    
    
    
    
    @IBAction func selectMenuBtn(_ sender: UIButton) {
        openLeft()
//        let numbers = [0]
//             let _ = numbers[1]
    }
    
    @IBAction func selectNotificationBtn(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HistoryNotificationsViewController") as?  HistoryNotificationsViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectRedeemNowBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RedeemNowVC") as?  EBC_RedeemNowVC
        navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func selectGameZoneBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_ComingSoonVC") as?  EBC_ComingSoonVC //EBC_GameZoneVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectOffersBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_SchemesAndOffersVC") as?  EBC_SchemesAndOffersVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func selectReferAndEarnBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_RefferAndEarnVC") as?  EBC_RefferAndEarnVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectEurobondsBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_EurobondsVC") as?  EBC_EurobondsVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectHelpLineBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_HelpLineVC") as?  EBC_HelpLineVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func selectScanCodeBtn(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanOrUpload_VC") as! ScanOrUpload_VC
        vc.itsFrom = "ScanCode"
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func selectUploadCodeBtn(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanOrUpload_VC") as! ScanOrUpload_VC
        vc.itsFrom = "UploadCode"
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func selectCodeStatusBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CodeStatusListVC") as? CodeStatusListVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectMyredeemptionBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_MyRedemptionVC") as? EBC_MyRedemptionVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectMyEarningsBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_MyEarningsVC") as? EBC_MyEarningsVC
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
            imageSlideShow.zoomEnabled = false
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
        //if self.offerimgArray.count > 0 {
            //imageSlideShow.presentFullScreenController(from: self)
       // }
    }
    
    @objc func codeStatus(notification: Notification){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CodeSubmissionPopUp") as! CodeSubmissionPopUp
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext

        self.present(vc, animated: true, completion: nil)
        
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
    
    func maintenanceAPI(){
        guard let url = URL(string: "http://appupdate.arokiait.com/updates/serviceget?pid=com.loyaltyWorks.EuroBond-Customer") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                  error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                                                                        dataResponse, options: [])
                print(jsonResponse)
                let isMaintenanceValue = ((jsonResponse as AnyObject).value(forKeyPath: "Result.is_maintenance") as? String)!
                let forceupdatevalue = ((jsonResponse as AnyObject).value(forKeyPath: "Result.version_number") as? String)!
                print(forceupdatevalue)
                if isMaintenanceValue == "1"{
                    print(isMaintenanceValue)
                    DispatchQueue.main.async {
                        self.maintenanceView.isHidden = false
                        self.playAnimation()

                    }
                }else if isMaintenanceValue == "0"{
                    self.tokendata()
                    self.animationView?.stop()
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    func playAnimation(){
        animationView = .init(name: "27592-maintenance")
        animationView!.frame = underMaintenance.bounds
          // 3. Set animation content mode
        animationView!.contentMode = .scaleAspectFit
          // 4. Set animation loop mode
        animationView!.loopMode = .loop
          // 5. Adjust animation speed
        animationView!.animationSpeed = 1
        underMaintenance.addSubview(animationView!)
          // 6. Play animation
        animationView!.play()

    }
    
    
    func isUpdateAvailable() {
        let bundleId = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
        print(bundleId)
        Alamofire.request("https://itunes.apple.com/in/lookup?bundleId=\(bundleId)").responseJSON { response in
            if let json = response.result.value as? NSDictionary, let results = json["results"] as? NSArray, let entry = results.firstObject as? NSDictionary, let appStoreVersion = entry["version"] as? String,let appstoreid = entry["trackId"], let trackUrl = entry["trackViewUrl"], let installedVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                let installed = Int(installedVersion.replacingOccurrences(of: ".", with: "")) ?? 0
                print(installed)
                let appStore = Int(appStoreVersion.replacingOccurrences(of: ".", with: "")) ?? 0
                print(appStore)
                print(appstoreid)
                if appStore>installed {
                        let alertController = UIAlertController(title: "New update Available!", message: "Update is available to download. Downloading the latest update you will get the latest features, improvements and bug fixes of Eurobond App", preferredStyle: .alert)

                        // Create the actions
                        let okAction = UIAlertAction(title: "Update Now", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            UIApplication.shared.openURL(NSURL(string: "\(trackUrl)")! as URL)

                        }
                        //                     Add the actions
                        alertController.addAction(okAction)
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)

                }else{
                    print("no updates")

                }
            }
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
