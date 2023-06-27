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
import AVFoundation
import AVKit
import LanguageManager_iOS
import Photos
import QCropper

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
    @IBOutlet var fabricatorAssistantLbl: UILabel!
    
    @IBOutlet weak var maintenanceView: UIView!
    @IBOutlet weak var underMaintenance: LottieAnimationView!
    
    @IBOutlet var scanningImageView: UIImageView!
    
    
    @IBOutlet weak var uploadImnageProfileImage: UIButton!
    
    var status = 1
    var sourceArray = [AlamofireSource]()
    var offerimgArray = [ObjImageGalleryList]()
    var VM = EBC_FabricatedDashBoardVM()
    var dashBoardId = -1
    private var animationView: LottieAnimationView?
    let picker = UIImagePickerController()
    var strdata1 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.picker.delegate = self
        self.defaultImage.isHidden = true
        self.maintenanceView.isHidden = true
        subView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        subView.layer.cornerRadius = 20
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        bottomView.layer.cornerRadius = 20
        localizSetup()
        self.uploadImnageProfileImage.addTarget(self, action: #selector(uploadImageProfile), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(codeStatus), name: Notification.Name.optionView, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
            }
        }else{
            //        self.slideMenuController()?.closeLeft()
            self.tokendata()
        }
    }
    func localizSetup(){
        self.fabricatorAssistantLbl.text = "Fabricator Assistant".localiz()
        self.membershipIDLbl.text = "Membership ID".localiz()
        self.memberSinceLbl.text = "MemberSince".localiz()
        self.codeStatusLbl.text = "Code Status".localiz()
        self.syncStatusLbl.text = "SyncStatus".localiz()
        self.codeSummeryLbl.text = "CodeSummary".localiz()
        self.needHelpLbl.text = "NeedHelp".localiz()
        self.helpLineLbl.text = "Helpline".localiz()
        self.termCondLbl.text = "TermsAndConditions".localiz()
        
        
        if self.codeStatusLbl.text == "Code Status" {
            self.scanningImageView.image = UIImage(named: "Group 5909")
        }else{
            self.scanningImageView.image = UIImage(named: "Hindi-Dash")
        }
        
    }
    
    @objc func uploadImageProfile(){
        let alert = UIAlertController(title: "Choose any option".localiz(), message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera".localiz(), style: .default , handler:{ (UIAlertAction)in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery".localiz(), style: .default, handler:{ (UIAlertAction)in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction(title: "Dismiss".localiz(), style: .cancel, handler:{ (UIAlertAction)in
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    @objc func codeStatus(notification: Notification){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CodeSubmissionPopUp") as! CodeSubmissionPopUp
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext

        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func selectLogoutBtn(_ sender: UIButton) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
            }
        }else{
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
    }
    
    @IBAction func selectNotificationBtn(_ sender: UIButton) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
            }
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HistoryNotificationsViewController") as?  HistoryNotificationsViewController
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    
    @IBAction func selectCodeStatusBtn(_ sender: UIButton) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
            }
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "CodeStatusListVC") as? CodeStatusListVC
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    @IBAction func selectSyncStatusBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "CodeStatusListVC") as? CodeStatusListVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectCodeSummeryBtn(_ sender: UIButton) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
            }
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "CodeSummary_VC") as? CodeSummary_VC
            navigationController?.pushViewController(vc!, animated: true)
        }
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
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
            }
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "EBC_HelpLineVC") as? EBC_HelpLineVC
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    @IBAction func selectTermCondBtn(_ sender: UIButton) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
            }
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "EBC_TermsAndConditionsVC") as? EBC_TermsAndConditionsVC
            navigationController?.pushViewController(vc!, animated: true)
        }
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
//        if self.offerimgArray.count > 0 {
//            imageSlideShow.presentFullScreenController(from: self)
//        }
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



extension EBC_Dashboard_2_VC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func openGallery() {
        PHPhotoLibrary.requestAuthorization({
            (newStatus) in
            if newStatus ==  PHAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    DispatchQueue.main.async {
                    self.picker.allowsEditing = false
                    self.picker.sourceType = .photoLibrary
                    self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                    self.present(self.picker, animated: true, completion: nil)
                    }
                }
            }else{
                
                let alertVC = UIAlertController(title: "EuroBond Application need to Access the Gallery".localiz(), message: "Allow Gallery Access".localiz(), preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Allow".localiz(), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }
                let cancelAction = UIAlertAction(title: "DisAllow".localiz(), style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                        
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                
            }
        })
    }
    
    func openCamera(){
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                    if response {
                        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                            DispatchQueue.main.async {
                                self.picker.allowsEditing = false
                                self.picker.sourceType = UIImagePickerController.SourceType.camera
                                self.picker.cameraCaptureMode = .photo
                                self.present(self.picker,animated: true,completion: nil)
                            }
                        }
                        
                    }else {
                        
                        let alertVC = UIAlertController(title: "EuroBond Application need to Access the Camera".localiz(), message: "Allow Camera Access".localiz(), preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Allow".localiz(), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                        }
                        let cancelAction = UIAlertAction(title: "DisAllow".localiz(), style: UIAlertAction.Style.cancel) {
                            UIAlertAction in
                        }
                        alertVC.addAction(okAction)
                        alertVC.addAction(cancelAction)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                    
                    
                    
                }
                
            } else {
                self.noCamera()
            }
        }
    }
    func opencamera() {
        DispatchQueue.main.async {
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                self.picker.allowsEditing = false
                self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: self.picker.sourceType)!
                self.picker.sourceType = UIImagePickerController.SourceType.camera
                self.picker.cameraCaptureMode = .photo
                self.present(self.picker,animated: true,completion: nil)
                }
            }else{

                let alertVC = UIAlertController(title: "No Camera access".localiz(), message: "Allow Camera Access".localiz(), preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Allow".localiz(), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                let cancelAction = UIAlertAction(title: "DisAllow".localiz(), style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }
                
                
            }
    }
     func noCamera(){
         let alertVC = UIAlertController(title: "No Camera".localiz(), message: "Sorry, this device has no camera".localiz(), preferredStyle: .alert)
         let okAction = UIAlertAction(title: "ok".localiz(), style:.default, handler: nil)
             alertVC.addAction(okAction)
             present(alertVC, animated: true, completion: nil)

     }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
                
                if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    print(image)
                    
                    let imageData = image.resized(withPercentage: 0.1)
                    let imageData1: NSData = imageData!.pngData()! as NSData
                    self.profileImage.image = image
                    //self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
                    let cropper = CropperViewController(originalImage: image)
                    print(strdata1,"Image")
                    cropper.delegate = self
                    
                    picker.dismiss(animated: true) {
                    self.present(cropper, animated: true, completion: nil)
                      
                    }
                  
            }
                
                
            }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension EBC_Dashboard_2_VC: CropperViewControllerDelegate {

    func cropperDidConfirm(_ cropper: CropperViewController, state: CropperState?) {
    cropper.dismiss(animated: true, completion: nil)
 
    if let state = state,
        let image = cropper.originalImage.cropped(withCropperState: state) {
        print(image,"imageDD")
        let imageData = image.resized(withPercentage: 0.1)
        let imageData1: NSData = imageData!.pngData()! as NSData
        self.profileImage.image = image
        self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
        print(strdata1,"kdjgjhdsj")
        
        //{"ActionType":"159","ObjCustomerJson":{"DisplayImage":"",}}
        //{"ActorId":"240","ActionType":"159","ObjCustomerJson":{"DisplayImage":"","Domain":"EuroBond"}}
        //{"ActorId":"240","ActionType":"159","ObjCustomerJson":{"DisplayImage":"","Domain":"EuroBond"}}
        
        DispatchQueue.main.async {
            let parameters = [
                "ActionType":"159",
                "ActorId": "\(UserDefaults.standard.string(forKey: "UserID") ?? "")",
                "ObjCustomerJson": [
                    "DisplayImage": self.strdata1,
                    "Domain":"EuroBond"
                ]
            ]as [String : Any]
            print(parameters)
            self.VM.profileImageUpdate(parameter: parameters)
        }
        
    } else {
        print("Something went wrong")
    }
    self.dismiss(animated: true, completion: nil)
    }
}

