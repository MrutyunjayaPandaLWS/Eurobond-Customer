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
    var status = 1
    var sourceArray = [AlamofireSource]()
    var offerimgArray = [ObjImageGalleryList]()
    var VM = EBC_DashBoardVM()
    var dashBoardId = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.dashBoardId = -1
        self.defaultImage.isHidden = true
        self.notificationBadges.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(codeStatus), name: Notification.Name.optionView, object: nil)
        
//        let button = UIButton(type: .roundedRect)
//            button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
//            button.setTitle("Test Crash", for: [])
//            button.addTarget(self, action: #selector(self.selectMenuBtn(_:)), for: .touchUpInside)
//            view.addSubview(button)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.slideMenuController()?.closeLeft()
        self.tokendata()
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
