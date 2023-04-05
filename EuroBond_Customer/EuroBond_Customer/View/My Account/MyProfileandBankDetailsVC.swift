//
//  MyProfileandBankDetailsVC.swift
//  GogrejLocksMobileApplication
//
//  Created by ADMIN on 01/07/2022.
//  Copyright © 2022 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit
import SDWebImage
import AVFoundation
import Photos
class MyProfileandBankDetailsVC: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var giveMissedCallLbl: UILabel!
    @IBOutlet weak var facingIssueLbl: UILabel!
    @IBOutlet weak var myprofile1: UILabel!
    @IBOutlet weak var myProfileImg: UIImageView!
    @IBOutlet weak var membershipIDLabel: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var personalDetailsLbl: UILabel!
    @IBOutlet weak var personalDetailsLblColor: UILabel!
    @IBOutlet weak var bankDetailsLbl: UILabel!
    @IBOutlet weak var bankDetailsColor: UILabel!
    @IBOutlet weak var editBTN: UIButton!
    @IBOutlet weak var countLbl: UILabel!
    
    var container: ContainerViewController!
    let mobilenumber = UserDefaults.standard.string(forKey: "CUSTOMERMOBILE") ?? ""
    let custEmail = UserDefaults.standard.string(forKey: "CUSTOMEReMAIL") ?? ""
    let loyaltyID = UserDefaults.standard.string(forKey: "LOYALTYiD") ?? ""
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let picker = UIImagePickerController()
    var strdata1 = ""
    var reachability = Reach()
    var bankDetails = ""
    var accountStatus = ""
    var isComeFrom = "None"
    var allowToEditProfile = "1"
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.languageLocalization()
//        picker.delegate = self
//        DashBoardCustomerDetailsAPI(usedID: userID)
//        self.ApicallingMethod()
//    NotificationCenter.default.addObserver(self, selector: #selector(handlepopuprefreshclose), name: Notification.Name.refreshDashboard, object: nil)
        print("Its Come From",self.isComeFrom)
//        if self.isComeFrom == "Catalogue"{
//            self.allowToEditProfile = "0"
//            self.isComeFrom = "Catalogue"
//            self.bankDetailsLbl.textColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
//            self.bankDetailsColor.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
//            self.personalDetailsLbl.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            self.personalDetailsLblColor.backgroundColor = #colorLiteral(red: 0.7709710002, green: 0.8818235993, blue: 0.944216311, alpha: 1)
//            self.editBTN.isHidden = true
//            container.segueIdentifierReceivedFromParent("myProfileBankDetails")
//            NotificationCenter.default.post(name: .switchToEditBankDetails, object: self)
//            NotificationCenter.default.post(name: Notification.Name("SHOWDATA24"), object: self)
//        }else if self.isComeFrom == "None"{
            self.personalDetailsLbl.textColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
            self.personalDetailsLblColor.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
            self.bankDetailsLbl.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.bankDetailsColor.backgroundColor = #colorLiteral(red: 0.7709710002, green: 0.8818235993, blue: 0.944216311, alpha: 1)
            container.segueIdentifierReceivedFromParent("myProfileDetails")
//        }
    }
      
    override func viewWillAppear(_ animated: Bool) {
//        if self.reachability.connectionStatus() == .offline {
//            if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "1"{
//            let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "en"), preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Ok".localizableString(loc: "en"), style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            }else  if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "2"{
//            let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "hi"), preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Ok".localizableString(loc: "hi"), style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            }else  if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "3"{
//                let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "kn-IN"), preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Ok".localizableString(loc: "kn-IN"), style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }else  if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "4"{
//                let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "ta-IN"), preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Ok".localizableString(loc: "ta-IN"), style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }else  if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "5"{
//                let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "te-IN"), preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Ok".localizableString(loc: "te-IN"), style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }else  if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "6"{
//                let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "hi"), preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                }
//        }
//        languageLocalization()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "myProfile"{
            self.container = segue.destination as? ContainerViewController
        }
    }
    
    @IBAction func selectGiveMissedCallBtn(_ sender: Any) {
    }
    @IBAction func selectProfileImageEditBtn(_ sender: Any) {
    }
    
    
    
    @objc func handlepopuprefreshclose(notification: Notification){
//        languageLocalization()
    }

   
    @IBAction func backBTn(_ sender: Any) {
//        print(self.isComeFrom, "BankButton")
//        if self.isComeFrom == "BankDetails"{
//            self.isComeFrom = "none"
//            self.allowToEditProfile = "1"
//            self.personalDetailsLbl.textColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
//            self.personalDetailsLblColor.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
//            self.bankDetailsLbl.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            self.bankDetailsColor.backgroundColor = #colorLiteral(red: 0.7709710002, green: 0.8818235993, blue: 0.944216311, alpha: 1)
////            self.editBTN.isHidden = false
//            container.segueIdentifierReceivedFromParent("myProfileDetails")
//
//        }else if self.isComeFrom == "bank" || self.isComeFrom == "Catalogue" || self.isComeFrom == "None1"{
//            self.isComeFrom = "none"
//            self.allowToEditProfile = "1"
//            self.personalDetailsLbl.textColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
//            self.personalDetailsLblColor.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
//            self.bankDetailsLbl.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            self.bankDetailsColor.backgroundColor = #colorLiteral(red: 0.7709710002, green: 0.8818235993, blue: 0.944216311, alpha: 1)
////            self.editBTN.isHidden = false
//            container.segueIdentifierReceivedFromParent("myProfileDetails")
//        }else{
////           self.ApicallingMethod()
//           self.allowToEditProfile = "1"
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
           self.navigationController?.popViewController(animated: true)
//       }
    }
  
    
    @IBAction func personalDetailsBTN(_ sender: Any) {
//        if self.isComeFrom == "None"{
            self.allowToEditProfile = "1"
            self.personalDetailsLbl.textColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
            self.personalDetailsLblColor.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
            self.bankDetailsLbl.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.bankDetailsColor.backgroundColor = #colorLiteral(red: 0.7709710002, green: 0.8818235993, blue: 0.944216311, alpha: 1)
//            self.editBTN.isHidden = false
            container.segueIdentifierReceivedFromParent("myProfileDetails")
//        }
       
    }
    @IBAction func bankDetails(_ sender: Any) {
        self.allowToEditProfile = "0"
        self.isComeFrom = "None1"
        self.bankDetailsLbl.textColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
        self.bankDetailsColor.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
        self.personalDetailsLbl.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.personalDetailsLblColor.backgroundColor = #colorLiteral(red: 0.7709710002, green: 0.8818235993, blue: 0.944216311, alpha: 1)
        if self.accountStatus == "1" || self.accountStatus == "0"{
            self.editBTN.isHidden = true
            self.isComeFrom = "None"
        }else if self.accountStatus == "2"{
//            self.editBTN.isHidden = true
            self.isComeFrom = "bank"
        }else{
//             self.editBTN.isHidden = false
          
        }
        container.segueIdentifierReceivedFromParent("myProfileBankDetails")
//        NotificationCenter.default.post(name: .switchToEditBankDetails, object: self)
//        NotificationCenter.default.post(name: Notification.Name("SHOWDATA24"), object: self)
    }
    
    @IBAction func uploadNewImage(_ sender: Any) {
        if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "1"{
            let alert = UIAlertController(title: "Choose any option", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
                self.openCamera()
            }))
            alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler:{ (UIAlertAction)in
                self.openGallery()
            }))
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            }))
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "2"{
            let alert = UIAlertController(title: "कोई भी विकल्प चुनें", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "कैमरा", style: .default , handler:{ (UIAlertAction)in
                self.openCamera()
            }))
            alert.addAction(UIAlertAction(title: "गेलरी", style: .default, handler:{ (UIAlertAction)in
                self.openGallery()
            }))
            alert.addAction(UIAlertAction(title: "नकार देना", style: .cancel, handler:{ (UIAlertAction)in
            }))
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "3"{
            let alert = UIAlertController(title: "ಯಾವುದೇ ಆಯ್ಕೆಯನ್ನು ಆರಿಸಿ", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "ಕ್ಯಾಮೆರಾ", style: .default , handler:{ (UIAlertAction)in
                self.openCamera()
            }))
            alert.addAction(UIAlertAction(title: "ಗ್ಯಾಲರಿ", style: .default, handler:{ (UIAlertAction)in
                self.openGallery()
            }))
            alert.addAction(UIAlertAction(title: "ವಜಾಗೊಳಿಸಿ", style: .cancel, handler:{ (UIAlertAction)in
            }))
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "4"{
            let alert = UIAlertController(title: "எந்த விருப்பத்தையும் தேர்வு செய்யவும்", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "புகைப்பட கருவி", style: .default , handler:{ (UIAlertAction)in
                self.openCamera()
            }))
            alert.addAction(UIAlertAction(title: "கேலரி", style: .default, handler:{ (UIAlertAction)in
                self.openGallery()
            }))
            alert.addAction(UIAlertAction(title: "நிராகரி", style: .cancel, handler:{ (UIAlertAction)in
            }))
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "5"{
            let alert = UIAlertController(title: "ఏదైనా ఎంపికను ఎంచుకోండి", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "కెమెరా", style: .default , handler:{ (UIAlertAction)in
                self.openCamera()
            }))
            alert.addAction(UIAlertAction(title: "గ్యాలరీ", style: .default, handler:{ (UIAlertAction)in
                self.openGallery()
            }))
            alert.addAction(UIAlertAction(title: "రద్దుచేసే", style: .cancel, handler:{ (UIAlertAction)in
            }))
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "6"{
            let alert = UIAlertController(title: "Choose any option", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
                self.openCamera()
            }))
            alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler:{ (UIAlertAction)in
                self.openGallery()
            }))
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            }))
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }
    
    }
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
                if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "1"{
                    let alertVC = UIAlertController(title: "Godrej Visheshलाभ Mobile Application need to Access the Gallery", message: "Allow Gallery Access", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }
                    let cancelAction = UIAlertAction(title: "DisAllow", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                        
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "2"{
                    let alertVC = UIAlertController(title: "गोदरेज विशेषलाभ मोबाइल एप्लिकेशन को गैलरी तक पहुंचने की आवश्यकता है", message: "गैलरी एक्सेस की अनुमति दें", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "अनुमति देना", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }
                    let cancelAction = UIAlertAction(title: "अनुमति न दें", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                        
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "3"{
                    let alertVC = UIAlertController(title: "ಗೋದ್ರೇಜ್ ವಿಶೇಷಲಾಬ್ ಮೊಬೈಲ್ ಅಪ್ಲಿಕೇಶನ್ ಗ್ಯಾಲರಿಯನ್ನು ಪ್ರವೇಶಿಸುವ ಅಗತ್ಯವಿದೆ", message: "ಗ್ಯಾಲರಿ ಪ್ರವೇಶವನ್ನು ಅನುಮತಿಸಿ", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "ಅನುಮತಿಸಿ", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }
                    let cancelAction = UIAlertAction(title: "ಅನುಮತಿಸಬೇಡ", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                        
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "4"{
                    let alertVC = UIAlertController(title: "கோத்ரேஜ் விஷேஷ்லாப் மொபைல் பயன்பாடு கேலரியை அணுக வேண்டும்", message: "கேலரி அணுகலை அனுமதிக்கவும்", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "அனுமதி", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }
                    let cancelAction = UIAlertAction(title: "அனுமதிக்காதே", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                        
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "5"{
                    let alertVC = UIAlertController(title: "గోద్రెజ్ విశేషాలబ్ మొబైల్ అప్లికేషన్ గ్యాలరీని యాక్సెస్ చేయాలి", message: "గ్యాలరీ యాక్సెస్‌ని అనుమతించండి", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "అనుమతించు", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }
                    let cancelAction = UIAlertAction(title: "అనుమతించవద్దు", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                        
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "6"{
                    let alertVC = UIAlertController(title: "Godrej Visheshलाभ Mobile Application need to Access the Gallery", message: "Allow Gallery Access", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }
                    let cancelAction = UIAlertAction(title: "DisAllow", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                        
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }
                
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
                            if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "1"{
                                let alertVC = UIAlertController(title: "Godrej Visheshलाभ Mobile Application need to Access the Camera", message: "Allow Camera Access", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                }
                                let cancelAction = UIAlertAction(title: "DisAllow", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in
                                }
                                alertVC.addAction(okAction)
                                alertVC.addAction(cancelAction)
                                self.present(alertVC, animated: true, completion: nil)
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "2"{
                                let alertVC = UIAlertController(title: "गोदरेज विशेषलाभ मोबाइल एप्लिकेशन को कैमरे तक पहुंचने की आवश्यकता है", message: "कैमरा एक्सेस की अनुमति दें", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "अनुमति देना", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                }
                                let cancelAction = UIAlertAction(title: "अनुमति न दें", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in
                                }
                                alertVC.addAction(okAction)
                                alertVC.addAction(cancelAction)
                                self.present(alertVC, animated: true, completion: nil)
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "3"{
                                let alertVC = UIAlertController(title: "ಗೋದ್ರೇಜ್ ವಿಶೇಷಲಾಬ್ ಮೊಬೈಲ್ ಅಪ್ಲಿಕೇಶನ್ ಕ್ಯಾಮರಾವನ್ನು ಪ್ರವೇಶಿಸುವ ಅಗತ್ಯವಿದೆ", message: "ಕ್ಯಾಮರಾ ಪ್ರವೇಶವನ್ನು ಅನುಮತಿಸಿ", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "ಅನುಮತಿಸಿ", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                }
                                let cancelAction = UIAlertAction(title: "ಅನುಮತಿಸಬೇಡ", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in
                                }
                                alertVC.addAction(okAction)
                                alertVC.addAction(cancelAction)
                                self.present(alertVC, animated: true, completion: nil)
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "4"{
                                let alertVC = UIAlertController(title: "கோத்ரேஜ் விஷேஷ்லாப் மொபைல் பயன்பாடு கேமராவை அணுக வேண்டும்", message: "கேமரா அணுகலை அனுமதிக்கவும்", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "அனுமதி", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                }
                                let cancelAction = UIAlertAction(title: "அனுமதிக்காதே", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in
                                }
                                alertVC.addAction(okAction)
                                alertVC.addAction(cancelAction)
                                self.present(alertVC, animated: true, completion: nil)
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "5"{
                                let alertVC = UIAlertController(title: "గోద్రెజ్ విశేషాలబ్ మొబైల్ అప్లికేషన్ కెమెరాను యాక్సెస్ చేయాలి", message: "కెమెరా యాక్సెస్‌ని అనుమతించండి", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "అనుమతించు", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                }
                                let cancelAction = UIAlertAction(title: "అనుమతించవద్దు", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in
                                }
                                alertVC.addAction(okAction)
                                alertVC.addAction(cancelAction)
                                self.present(alertVC, animated: true, completion: nil)
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "6"{
                                let alertVC = UIAlertController(title: "Godrej Visheshलाभ Mobile Application need to Access the Camera", message: "Allow Camera Access", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                }
                                let cancelAction = UIAlertAction(title: "DisAllow", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in
                                }
                                alertVC.addAction(okAction)
                                alertVC.addAction(cancelAction)
                                self.present(alertVC, animated: true, completion: nil)
                            }
                        
                        
                        
                    }
                }} else {
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
                if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "1"{
                    let alertVC = UIAlertController(title: "No Camera access", message: "Allow Camera Access", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                    let cancelAction = UIAlertAction(title: "DisAllow", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "2"{
                    let alertVC = UIAlertController(title: "कोई कैमरा एक्सेस नहीं", message: "कैमरा एक्सेस की अनुमति दें", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "अनुमति देना", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                    let cancelAction = UIAlertAction(title: "अनुमति न दें", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "3"{
                    let alertVC = UIAlertController(title: "ಕ್ಯಾಮರಾ ಪ್ರವೇಶವಿಲ್ಲ", message: "ಕ್ಯಾಮರಾ ಪ್ರವೇಶವನ್ನು ಅನುಮತಿಸಿ", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "ಅನುಮತಿಸಿ", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                    let cancelAction = UIAlertAction(title: "ಅನುಮತಿಸಬೇಡ", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "4"{
                    let alertVC = UIAlertController(title: "கேமரா அணுகல் இல்லை", message: "கேமரா அணுகலை அனுமதிக்கவும்", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "அனுமதி", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                    let cancelAction = UIAlertAction(title: "அனுமதிக்காதே", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "5"{
                    let alertVC = UIAlertController(title: "కెమెరా యాక్సెస్ లేదు", message: "కెమెరా యాక్సెస్‌ని అనుమతించండి", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "అనుమతించు", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                    let cancelAction = UIAlertAction(title: "అనుమతించవద్దు", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "6"{
                    let alertVC = UIAlertController(title: "No Camera access", message: "Allow Camera Access", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                    let cancelAction = UIAlertAction(title: "DisAllow", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }
                
                
            }
        }
    }
     func noCamera(){
         if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "1"{
             let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
             let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
             alertVC.addAction(okAction)
             present(alertVC, animated: true, completion: nil)
//         }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "2"{
//             let alertVC = UIAlertController(title: "कैमरा निषिद्ध है", message: "क्षमा करें, इस डिवाइस में कोई कैमरा नहीं है", preferredStyle: .alert)
//             let okAction = UIAlertAction(title: "Ok".localizableString(loc: "hi"), style:.default, handler: nil)
//             alertVC.addAction(okAction)
//             present(alertVC, animated: true, completion: nil)
//         }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "3"{
//             let alertVC = UIAlertController(title: "ಕ್ಯಾಮರಾ ಇಲ್ಲ", message: "ಕ್ಷಮಿಸಿ, ಈ ಸಾಧನವು ಯಾವುದೇ ಕ್ಯಾಮರಾವನ್ನು ಹೊಂದಿಲ್ಲ", preferredStyle: .alert)
//             let okAction = UIAlertAction(title: "Ok".localizableString(loc: "kn-IN"), style:.default, handler: nil)
//             alertVC.addAction(okAction)
//             present(alertVC, animated: true, completion: nil)
//         }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "4"{
//             let alertVC = UIAlertController(title: "புகைப்பட கருவி இல்லை", message: "மன்னிக்கவும், இந்தச் சாதனத்தில் கேமரா இல்லை", preferredStyle: .alert)
//             let okAction = UIAlertAction(title: "Ok".localizableString(loc: "ta-IN"), style:.default, handler: nil)
//             alertVC.addAction(okAction)
//             present(alertVC, animated: true, completion: nil)
//         }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "5"{
//             let alertVC = UIAlertController(title: "కెమెరా లేదు", message: "క్షమించండి, ఈ పరికరంలో కెమెరా లేదు", preferredStyle: .alert)
//             let okAction = UIAlertAction(title: "సరే", style:.default, handler: nil)
//             alertVC.addAction(okAction)
//             present(alertVC, animated: true, completion: nil)
//         }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "6"{
//             let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
//             let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
//             alertVC.addAction(okAction)
//             present(alertVC, animated: true, completion: nil)
//         }
         
     }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            
            return
        }
        self.myProfileImg.image = selectedImage
        if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
            
            let imageData = selectedImage.resized(withPercentage: 0.1)
            let imageData1: NSData = imageData!.pngData()! as NSData
            let strBase64 = imageData1.base64EncodedString(options: .lineLength64Characters)
            strdata1 = strBase64
        }
        
      
//        if self.reachability.connectionStatus() == .offline {
//            if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "1"{
//            let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "en"), preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Ok".localizableString(loc: "en"), style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            }else  if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "2"{
//            let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "hi"), preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Ok".localizableString(loc: "hi"), style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            }else  if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "3"{
//                let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "kn-IN"), preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Ok".localizableString(loc: "kn-IN"), style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }else  if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "4"{
//                let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "ta-IN"), preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Ok".localizableString(loc: "ta-IN"), style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }else  if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "5"{
//                let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "te-IN"), preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Ok".localizableString(loc: "te-IN"), style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }else  if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "6"{
//                let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "hi"), preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                }
//        } else {
//            self.startLoading()
//        self.fromURL.almofireSOAPprofilephotoupload(methodName: methodName.saveProfilePhoto_methodName, actorid: self.userID, str64Data: strdata1, loyaltyid: self.loyaltyID) { (result, error) in
//            if result == nil{
//                print("NO INTERNET, PLEASE CHECK YOUR DATA CONNECTION NOW")
//                self.stopLoading()
//            }else{
//
//                let savephotoDetails = result as? SaveProfileImageModels
//                print(savephotoDetails?.ReturnMessage ?? "")
//                if Int(savephotoDetails?.ReturnMessage ?? "") ?? 0 == 1{
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "1"{
//                    let alert = UIAlertController(title: "", message: "Profile Image is saved Successfully", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: {(alert) in
//                        self.MerchantEmailDetailsAPI(userID: self.userID)
//                       }))
//                    self.present(alert, animated: true, completion: nil)
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "2"{
//                    let alert = UIAlertController(title: "", message: "प्रोफ़ाइल छवि सफलतापूर्वक सहेज ली गई है", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "ठीक", style: UIAlertAction.Style.default, handler: { (alert) in
//                        self.MerchantEmailDetailsAPI(userID: self.userID)
//
//                    }))
//                    self.present(alert, animated: true, completion: nil)
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "3"{
//                    let alert = UIAlertController(title: "", message: "ಪ್ರೊಫೈಲ್ ಚಿತ್ರವನ್ನು ಯಶಸ್ವಿಯಾಗಿ ಉಳಿಸಲಾಗಿದೆ", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "ಸರಿ", style: UIAlertAction.Style.default, handler: {(alert) in
//                        self.MerchantEmailDetailsAPI(userID: self.userID)
//                       }))
//                    self.present(alert, animated: true, completion: nil)
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "4"{
//                    let alert = UIAlertController(title: "", message: "சுயவிவரப் படம் வெற்றிகரமாகச் சேமிக்கப்பட்டது", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "சரி", style: UIAlertAction.Style.default, handler: {(alert) in
//                        self.MerchantEmailDetailsAPI(userID: self.userID)
//                       }))
//                    self.present(alert, animated: true, completion: nil)
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "5"{
//                    let alert = UIAlertController(title: "", message: "ప్రొఫైల్ చిత్రం విజయవంతంగా సేవ్ చేయబడింది", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "సరే", style: UIAlertAction.Style.default, handler: {(alert) in
//                        self.MerchantEmailDetailsAPI(userID: self.userID)
//                       }))
//                    self.present(alert, animated: true, completion: nil)
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "6"{
//                    let alert = UIAlertController(title: "", message: "Profile Image is saved Successfully", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: {(alert) in
//                        self.MerchantEmailDetailsAPI(userID: self.userID)
//                       }))
//                    self.present(alert, animated: true, completion: nil)
//                }
//
//                }else{
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "1"{
//                        let alert = UIAlertController(title: "", message: "Profile Image saving is failed", preferredStyle: UIAlertController.Style.alert)
//                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                        self.present(alert, animated: true, completion: nil)
//                    } else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "2"{
//                        let alert = UIAlertController(title: "", message: "प्रोफ़ाइल छवि सहेजना विफल रहा", preferredStyle: UIAlertController.Style.alert)
//                        alert.addAction(UIAlertAction(title: "ठीक", style: UIAlertAction.Style.default, handler: nil))
//                        self.present(alert, animated: true, completion: nil)
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "3"{
//                        let alert = UIAlertController(title: "", message: "ಪ್ರೊಫೈಲ್ ಇಮೇಜ್ ಉಳಿಸುವಿಕೆ ವಿಫಲವಾಗಿದೆ", preferredStyle: UIAlertController.Style.alert)
//                        alert.addAction(UIAlertAction(title: "ಸರಿ", style: UIAlertAction.Style.default, handler: nil))
//                        self.present(alert, animated: true, completion: nil)
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "4"{
//                        let alert = UIAlertController(title: "", message: "சுயவிவரப் படத்தைச் சேமிப்பதில் தோல்வி", preferredStyle: UIAlertController.Style.alert)
//                        alert.addAction(UIAlertAction(title: "சரி", style: UIAlertAction.Style.default, handler: nil))
//                        self.present(alert, animated: true, completion: nil)
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "5"{
//                        let alert = UIAlertController(title: "", message: "ప్రొఫైల్ చిత్రాన్ని సేవ్ చేయడం విఫలమైంది", preferredStyle: UIAlertController.Style.alert)
//                        alert.addAction(UIAlertAction(title: "సరే", style: UIAlertAction.Style.default, handler: nil))
//                        self.present(alert, animated: true, completion: nil)
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "6"{
//                        let alert = UIAlertController(title: "", message: "प्रोफ़ाइल छवि सहेजना विफल रहा", preferredStyle: UIAlertController.Style.alert)
//                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                        self.present(alert, animated: true, completion: nil)
//                    }
//                }
//                self.stopLoading()
//            }
//        }
//        }
//        picker.dismiss(animated: true, completion: nil)
//        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
//    func ApicallingMethod(){
//        startLoading()
//        self.fromURL.almofireSOAPRequestProfileDetails(methodName: methodName.GetProfileCustomerDetails, userID: (UserDefaults.standard.string(forKey: "UserID") ?? "")) { (result, error) in
//            if result == nil{
//                self.stopLoading()
//                return
//            }else{
//                self.stopLoading()
//                let myprofiledetails = result as! [MyprofileDetailsList]
//                if myprofiledetails.count != 0 {
//                    self.userNameLbl.text = myprofiledetails[0].name ?? ""
//                    let profileImage = UserDefaults.standard.string(forKey: "CUSTOMERIMAGE") ?? ""
//                    print(profileImage)
//                    let totalImageURL = BASE_IMGURL + profileImage
//                    print(totalImageURL)
//                    self.myProfileImg.sd_setImage(with: URL(string: totalImageURL), placeholderImage: UIImage(named: "defaultImage"));
//
//
//                    let bankAccStatus = myprofiledetails[0].bankAccountVerifiedStatus ?? ""
//                    print("\(bankAccStatus)", "bankAccount Status")
//                    self.accountStatus = bankAccStatus
//                    let bankAccountDetailsExist = myprofiledetails[0].backDetailsExits ?? ""
//                    print("\(bankAccountDetailsExist)")
//
//                    if bankAccStatus == "2"{
//                        self.accountStatus = "2"
//
//                    }else if bankAccStatus == "0"{
//                        self.accountStatus = "0"
//                    }else if bankAccStatus == "1"{
//                        self.accountStatus = "1"
//                    }
//
//                    if myprofiledetails[0].accountNumber ?? "" == ""{
//                        self.bankDetails = "Allow"
//                    }else{
//                        self.bankDetails = "Disallow"
//                    }
//                }
//
//            }
//        }
//    }
//    func MerchantEmailDetailsAPI(userID:String){
//        startLoading()
//        self.fromURL.almofireSOAPRequestForDashboardrequest2(methodName: methodName.GetMerchantEmailDetailsMobileApp, userID: userID) { (result, error) in
//            if result == nil{
//                self.stopLoading()
//            }else{
//                let merchantDetails = result as! MerchantEmailModels
//                print(merchantDetails.CustomerImage ?? "")
//                UserDefaults.standard.set(merchantDetails.CustomerImage ?? "", forKey: "CUSTOMERIMAGE")
//                UserDefaults.standard.set(merchantDetails.customer_email ?? "", forKey: "CUSTOMEReMAIL")
//                UserDefaults.standard.set(merchantDetails.customer_mobile ?? "", forKey: "CUSTOMERMOBILE")
//                self.stopLoading()
//
//            }
//        }
//
//    }
//    func languageLocalization(){
//        if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "1"{
//            self.myprofile1.text = "Myprofile".localizableString(loc: "en")
//            self.membershipIDLabel.text = "Membership ID : \(UserDefaults.standard.string(forKey: "LOYALTYiD") ?? "")"
//            self.personalDetailsLbl.text = "personalDetails".localizableString(loc: "en")
//            self.bankDetailsLbl.text = "bankDetails".localizableString(loc: "en")
//
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "2"{
//
//            self.myprofile1.text = "Myprofile".localizableString(loc: "hi")
//
//            self.membershipIDLabel.text = "सदस्यता आईडी : \(UserDefaults.standard.string(forKey: "LOYALTYiD") ?? "")"
//            self.personalDetailsLbl.text = "personalDetails".localizableString(loc: "hi")
//            self.bankDetailsLbl.text = "bankDetails".localizableString(loc: "hi")
//
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "3"{
//            self.myprofile1.text = "Myprofile".localizableString(loc: "kn-IN")
//            self.membershipIDLabel.text = "ಸದಸ್ಯತ್ವ ID : \(UserDefaults.standard.string(forKey: "LOYALTYiD") ?? "")"
//            self.personalDetailsLbl.text = "personalDetails".localizableString(loc: "kn-IN")
//            self.bankDetailsLbl.text = "bankDetails".localizableString(loc: "kn-IN")
//
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "4"{
//
//            self.myprofile1.text = "Myprofile".localizableString(loc: "ta-IN")
//            self.membershipIDLabel.text = "உறுப்பினர் ஐடி : \(UserDefaults.standard.string(forKey: "LOYALTYiD") ?? "")"
//            self.personalDetailsLbl.text = "personalDetails".localizableString(loc: "ta-IN")
//            self.bankDetailsLbl.text = "bankDetails".localizableString(loc: "ta-IN")
//
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "5"{
//
//            self.myprofile1.text = "Myprofile".localizableString(loc: "te-IN")
//            self.membershipIDLabel.text = "ಸದಸ್ಯತ್ವ ID : \(UserDefaults.standard.string(forKey: "LOYALTYiD") ?? "")"
//            self.personalDetailsLbl.text = "personalDetails".localizableString(loc: "te-IN")
//            self.bankDetailsLbl.text = "bankDetails".localizableString(loc: "te-IN")
//
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "6"{
//
//            self.myprofile1.text = "Myprofile".localizableString(loc: "kn-IN")
//
//            self.membershipIDLabel.text = "ಸದಸ್ಯತ್ವ ID : \(UserDefaults.standard.string(forKey: "LOYALTYiD") ?? "")"
//            self.personalDetailsLbl.text = "personalDetails".localizableString(loc: "kn-IN")
//            self.bankDetailsLbl.text = "bankDetails".localizableString(loc: "kn-IN")
//
//        }
//    }
//    func DashBoardCustomerDetailsAPI(usedID:String){
//        startLoading()
//        self.fromURL.almofireSOAPRequestForDashboardrequest1(methodName: methodName.getCustomerDashboardDetailsMobileApp, userID: usedID) { (result, error) in
//            if result == nil{
//                self.stopLoading()
//            }else{
//                let customerDetails = result as! DashboardModels
//                DispatchQueue.main.async {
//                    self.countLbl.text = customerDetails.notificationCount ?? ""
//
//                    if self.countLbl.text != "0"{
//                        self.countLbl.isHidden = false
//                    }else{
//                        self.countLbl.isHidden = true
//                    }
//
//
//
//            }
//        }
//    }
}
}
