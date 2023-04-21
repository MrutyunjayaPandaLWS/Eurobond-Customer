//
//  ScanOrUpload_VC.swift
//  centuryDemo
//
//  Created by Arokia-M3 on 16/03/22.
//

import UIKit
import Firebase
import UserNotifications
import NotificationCenter
import CoreData
import AudioToolbox
import AVFoundation
import CoreLocation
import CoreData
import Firebase

class ScanOrUpload_VC: BaseViewController, AVCaptureVideoDataOutputSampleBufferDelegate, UNUserNotificationCenterDelegate, CLLocationManagerDelegate, UITextFieldDelegate, popUpDelegate1 {
    func popupAlertDidTap1(_ vc: PopupAlertOne_VC) {}

    @IBOutlet var codeCountView: UIView!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var scannerView: UIView!
    @IBOutlet var uploadView: UIView!
    @IBOutlet var codeTF: UITextField!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var scanQRCodeButton: UIButton!
    @IBOutlet var enterQRCodeLabel: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var BottomView: GradientView!
    @IBOutlet weak var headerView: GradientView!
    @IBOutlet weak var closeBTN: UIButton!
    @IBOutlet weak var scannerImage: UIImageView!
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    
    
    var reachability = Reach()
    var isComeFrom = ""
    var isComingFrom = 0
    var newproductArray: [[String:Any]] = []
   // let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var catalogueList = ""
    var addressString : String = ""
    var country = ""
    var city = ""
    var address = ""
    var pincode = ""
    
    var isScanned = false
    var isFirsttime = true
    var alertController = UIAlertController()
    var okAction = UIAlertAction()
    let session = AVCaptureSession()
    lazy var vision = Vision.vision()
    var barcodeDetector :VisionBarcodeDetector?
    var enteredCodeArray = [String]()
    var scannedListArray = [String]()
    var codeLIST:Array = [ScanCodeSTORE]()
    var uploadedCodes:Array = [UploadedCodes]()
    var sendScannedCodes:Array = [SendUploadedCodes]()
    var locationManager = CLLocationManager()
    var currentlocation:CLLocation!
    var isFrom = 0
    var isSwitchOn = 0
    var isscannedOnce = false
    var valueChecked = false
    var scannedCodes = ""
    
    var scannedStatus = false
    var scaned = 1
    var CapturedCodess = ""
    var currentUserID = ""
    var parameterJSON:JSON?
    var itsFrom = ""
    var VM = UploadAndScanViewModel()
    
    var fromSideMenu = ""
    var scannedCodeArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countLabel.cornerRadius = countLabel.frame.width/2
        self.codeCountView.cornerRadius = codeCountView.frame.width/2
        self.codeTF.keyboardType = .numberPad
        BottomView.clipsToBounds = true
        BottomView.layer.cornerRadius = 24
        BottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        fetchDetails()
        fetchDetails2()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        self.VM.VC = self
        codeTF.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(codeExists), name: Notification.Name.restartScan, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cameraAccess), name: Notification.Name.scanAccess, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(startVideo), name: Notification.Name.startVideo, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(codesSubmission), name: Notification.Name.CodeSubmission, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(codesUploadAgain), name: Notification.Name.uploadAgain, object: nil)
        languagelocalization()
        
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Scan/Upload QR code")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
 
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.header.text = "Upload"
            self.messageLbl.text = "Place a QR Code inside the view finder rectangle  to scan it."
            self.codeTF.placeholder = "Enter your code"
            self.submitButton.setTitle("Submit", for: .normal)
            self.enterQRCodeLabel.text = "Enter QR code in the above field and submit."
            self.scanQRCodeButton.setTitle("Scan QR Code", for: .normal)
            self.infoLbl.text = "Click here to see your QR Codes"
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.header.text = "अपलोड"
            self.messageLbl.text = "इसे स्कैन करने के लिए व्यू फाइंडर आयत के अंदर एक क्यूआर कोड रखें।"
            self.codeTF.placeholder = "अपना कोड दर्ज करे"
            self.submitButton.setTitle("प्रस्तुत", for: .normal)
            self.enterQRCodeLabel.text = "उपरोक्त फ़ील्ड में क्यूआर कोड दर्ज करें और सबमिट करें।"
            self.scanQRCodeButton.setTitle("क्यू आर कोड स्कैन करें", for: .normal)
            self.infoLbl.text = "अपने क्यूआर कोड देखने के लिए यहां क्लिक करें"
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.header.text = "আপলোড"
            self.messageLbl.text = "এটি স্ক্যান করতে ভিউ ফাইন্ডার আয়তক্ষেত্রের ভিতরে একটি QR কোড রাখুন।"
            self.codeTF.placeholder = "আপনার কোড লিখুন"
            self.submitButton.setTitle("জমা দিন", for: .normal)
            self.enterQRCodeLabel.text = "উপরের ক্ষেত্রে QR কোড লিখুন এবং জমা দিন।"
            self.scanQRCodeButton.setTitle("QR কোড স্ক্যান করুন", for: .normal)
            self.infoLbl.text = "আপনার QR কোড দেখতে এখানে ক্লিক করুন"
        }else{
            self.header.text = "Upload"
            self.messageLbl.text = "Place a QR Code inside the view finder rectangle  to scan it."
            self.codeTF.placeholder = "Enter your code"
            self.submitButton.setTitle("Submit", for: .normal)
            self.enterQRCodeLabel.text = "Enter QR code in the above field and submit."
            self.scanQRCodeButton.setTitle("Scan QR Code", for: .normal)
            self.infoLbl.text = "Click here to see your QR Codes"
        }
    }
    @objc func codesUploadAgain(notification: Notification){
        if self.itsFrom == "UploadCode"{
                self.fetchDetails()
                self.messageLbl.isHidden = false
                self.scannerView.isHidden = false
                self.uploadView.isHidden = true
                self.closeBTN.isHidden = false
                self.headerView.isHidden = true
            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it"
                self.scanQRCodeButton.setTitle("Upload QR Code", for: .normal)
                self.infoLbl.text = "Click here to see your QR Codes"
                
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                
                self.messageLbl.text = "इसे स्कैन करने के लिए व्यू फाइंडर आयत के अंदर एक क्यूआर कोड रखें।"
                self.scanQRCodeButton.setTitle("क्यूआर कोड अपलोड करें", for: .normal)
                self.infoLbl.text = "अपने क्यूआर कोड देखने के लिए यहां क्लिक करें"
                
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                self.messageLbl.text = "এটি স্ক্যান করতে ভিউ ফাইন্ডার আয়তক্ষেত্রের ভিতরে একটি QR কোড রাখুন।"
                self.scanQRCodeButton.setTitle("QR কোড আপলোড করুন", for: .normal)
                self.infoLbl.text = "আপনার QR কোড দেখতে এখানে ক্লিক করুন"
            }else{
                self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it"
                self.scanQRCodeButton.setTitle("Upload QR Code", for: .normal)
                self.infoLbl.text = "Click here to see your QR Codes"
            }
            self.scanQRCodeButton.setImage(UIImage(named: "software-upload"), for: .normal)
                self.isScanned = true
                if self.isFirsttime == true{
                    NotificationCenter.default.post(name: .startVideo, object: nil)
                    self.isFirsttime = false
                    self.scaned = 1
                    self.scannedStatus = true
                }else{
                    self.session.startRunning()
                }
                self.clearTable()
                self.codeLIST.removeAll()
                self.fetchDetails()
                
            }else{
                self.headerView.isHidden = false
                self.closeBTN.isHidden = true
               
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    self.enterQRCodeLabel.text = "Enter QR code in the above field and submit."
                    self.scanQRCodeButton.setTitle("Scan QR Code", for: .normal)
                    self.infoLbl.text = "Click here to see your QR Codes"
                    
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                    
                    self.enterQRCodeLabel.text = "उपरोक्त फ़ील्ड में क्यूआर कोड दर्ज करें और सबमिट करें।"
                    self.scanQRCodeButton.setTitle("क्यू आर कोड स्कैन करें", for: .normal)
                    self.infoLbl.text = "अपने क्यूआर कोड देखने के लिए यहां क्लिक करें"
                    
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    self.enterQRCodeLabel.text = "উপরের ক্ষেত্রে QR কোড লিখুন এবং জমা দিন।"
                    self.scanQRCodeButton.setTitle("QR কোড স্ক্যান করুন", for: .normal)
                    self.infoLbl.text = "আপনার QR কোড দেখতে এখানে ক্লিক করুন"
                }else{
                    self.enterQRCodeLabel.text = "Enter QR code in the above field and submit."
                    self.scanQRCodeButton.setTitle("Scan QR Code", for: .normal)
                    self.infoLbl.text = "Click here to see your QR Codes"
                }
                
                self.scanQRCodeButton.setImage(UIImage(named: "qr"), for: .normal)
                self.scannerView.isHidden = true
                self.uploadView.isHidden = false
                self.messageLbl.isHidden = true
                self.session.stopRunning()
                self.fetchDetails()
                self.isScanned = false
                self.isFrom = 0
                self.isscannedOnce = false
                self.fetchDetails()
                self.isScanned = false
                self.clearTable()
                self.session.stopRunning()
                self.codeLIST.removeAll()
                self.fetchDetails()
            }
         
    }
    
    @objc func startVideo(notification: Notification){
        startLiveVideo()
    }
    
    @objc func codeExists(notification: Notification){
        self.fetchDetails()
        self.restartScanning()
    }
    @objc func cameraAccess(notification: Notification){
        self.session.startRunning()
        self.messageLbl.isHidden = false
        self.headerView.isHidden = true
        self.closeBTN.isHidden = false
        self.scanQRCodeButton.setImage(UIImage(named: "software-upload"), for: .normal)
        self.scannerView.isHidden = false
        self.uploadView.isHidden = true
        
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it"
            self.scanQRCodeButton.setTitle("Upload QR Code", for: .normal)
            self.infoLbl.text = "Click here to see your QR Codes"
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            
            self.messageLbl.text = "इसे स्कैन करने के लिए व्यू फाइंडर आयत के अंदर एक क्यूआर कोड रखें।"
            self.scanQRCodeButton.setTitle("क्यूआर कोड अपलोड करें", for: .normal)
            self.infoLbl.text = "अपने क्यूआर कोड देखने के लिए यहां क्लिक करें"
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.messageLbl.text = "এটি স্ক্যান করতে ভিউ ফাইন্ডার আয়তক্ষেত্রের ভিতরে একটি QR কোড রাখুন।"
            self.scanQRCodeButton.setTitle("QR কোড আপলোড করুন", for: .normal)
            self.infoLbl.text = "আপনার QR কোড দেখতে এখানে ক্লিক করুন"
        }else{
            self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it"
            self.scanQRCodeButton.setTitle("Upload QR Code", for: .normal)
            self.infoLbl.text = "Click here to see your QR Codes"
        }
        
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted == true {
            } else {
                
            }
        })
    
        self.isScanned = true
        scaned = 1
        self.scannedStatus = false
        self.barcodeDetector = vision.barcodeDetector()
        isComingFrom = 0
        if isFirsttime == true{
            startLiveVideo()
            self.isFirsttime = false
            self.scaned = 1
            self.scannedStatus = true
        }else{
            session.startRunning()
        }
    }
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           self.scannerImage.layer.zPosition = 2
       }
    func fetchDetails(){
        self.codeLIST.removeAll()
        let fetchRequest:NSFetchRequest<ScanCodeSTORE> = ScanCodeSTORE.fetchRequest()
        do{
            self.codeLIST = try persistanceservice.context.fetch(fetchRequest)
            print(self.codeLIST.count, "Count")

            if self.codeLIST.count != 0{
                self.countLabel.isHidden = false
                self.countLabel.text = "\(self.codeLIST.count)"
            }else{
                self.countLabel.isHidden = true
            }

        }catch{
            print("error while fetching data")
        }
    }
    
    @objc func codesSubmission(notification: Notification){
        for item in self.codeLIST {
            let singleImageDict:[String:Any] = [
                "QRCode": item.code ?? "",
                "ScanType": 1,
                "Latitude": item.latitude ?? "",
                "Longitude": item.longitude ?? ""
            ]
            self.newproductArray.append(singleImageDict)
                }
        self.parameterJSON = [
            
            "Address": "\(self.addressString)",
            "City": "\(self.city)",
            "Country": "\(self.country)",
            "Latitude": "\(self.currentlocation.coordinate.latitude)",
            "Longitude": "\(self.currentlocation.coordinate.longitude)",
            "LoyaltyID": "\(loyaltyId)",
            "PinCode": "\(self.pincode)",
            "QRCodeSaveRequestList": self.newproductArray as [[String:Any]],
                "SourceType": "1",
            "State": ""
        ]
        print(self.parameterJSON ?? "")
        
        if self.scanQRCodeButton.currentTitle == "Upload QR Code" ||  self.scanQRCodeButton.currentTitle == "क्यूआर कोड अपलोड करें" ||  self.scanQRCodeButton.currentTitle == "QR কোড আপলোড করুন" ||  self.scanQRCodeButton.currentTitle == "QR కోడ్‌ని అప్‌లోడ్ చేయండి"{
            self.isFrom = 1
            self.session.stopRunning()
            self.codeTF.text = ""
            self.scannerView.isHidden = false
            self.session.stopRunning()
            self.fetchDetails()
            self.getAddressFromLatLon(pdblLatitude: String(self.currentlocation.coordinate.latitude), withLongitude: String(self.currentlocation.coordinate.longitude))
            return
        }else{
            self.isFrom = 0
            self.fetchDetails()
            self.codeTF.text = ""
            self.getAddressFromLatLon(pdblLatitude: String(self.currentlocation.coordinate.latitude), withLongitude: String(self.currentlocation.coordinate.longitude))
            return
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDetails()
        if self.itsFrom == "ScanCode"{
            fetchDetails()
            self.headerView.isHidden = true
            self.closeBTN.isHidden = false
            self.messageLbl.isHidden = false
            
            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it"
                self.scanQRCodeButton.setTitle("Upload QR Code", for: .normal)
                self.infoLbl.text = "Click here to see your QR Codes"
                
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                
                self.messageLbl.text = "इसे स्कैन करने के लिए व्यू फाइंडर आयत के अंदर एक क्यूआर कोड रखें।"
                self.scanQRCodeButton.setTitle("क्यूआर कोड अपलोड करें", for: .normal)
                self.infoLbl.text = "अपने क्यूआर कोड देखने के लिए यहां क्लिक करें"
                
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                self.messageLbl.text = "এটি স্ক্যান করতে ভিউ ফাইন্ডার আয়তক্ষেত্রের ভিতরে একটি QR কোড রাখুন।"
                self.scanQRCodeButton.setTitle("QR কোড আপলোড করুন", for: .normal)
                self.infoLbl.text = "আপনার QR কোড দেখতে এখানে ক্লিক করুন"
            }else{
                self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it"
                self.scanQRCodeButton.setTitle("Upload QR Code", for: .normal)
                self.infoLbl.text = "Click here to see your QR Codes"
            }
            
            self.scanQRCodeButton.setImage(UIImage(named: "software-upload"), for: .normal)
            self.scannerView.isHidden = false
            self.uploadView.isHidden = true
       

            self.session.startRunning()
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted == true {
                } else {

                }
            })

            self.isScanned = true
            scaned = 1
            self.scannedStatus = false
            self.barcodeDetector = vision.barcodeDetector()
            
            self.session.stopRunning()

            if isFirsttime == true{
                startLiveVideo()
                self.isFirsttime = false
                self.scaned = 1
                self.scannedStatus = true
            }else{
                session.startRunning()
            }


        }else{
            fetchDetails()
            self.headerView.isHidden = false
            self.closeBTN.isHidden = true
          
            self.scanQRCodeButton.setImage(UIImage(named: "qr"), for: .normal)
            self.messageLbl.isHidden = true
            self.scannerView.isHidden = true
            self.uploadView.isHidden = false
            self.session.stopRunning()
            self.codeTF.setLeftPaddingPoints(10)
            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                self.enterQRCodeLabel.text = "Enter QR code in the above field and submit."
                self.scanQRCodeButton.setTitle("Scan QR Code", for: .normal)
                self.infoLbl.text = "Click here to see your QR Codes"
                
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                
                self.enterQRCodeLabel.text = "उपरोक्त फ़ील्ड में क्यूआर कोड दर्ज करें और सबमिट करें।"
                self.scanQRCodeButton.setTitle("क्यू आर कोड स्कैन करें", for: .normal)
                self.infoLbl.text = "अपने क्यूआर कोड देखने के लिए यहां क्लिक करें"
                
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                self.enterQRCodeLabel.text = "উপরের ক্ষেত্রে QR কোড লিখুন এবং জমা দিন।"
                self.scanQRCodeButton.setTitle("QR কোড স্ক্যান করুন", for: .normal)
                self.infoLbl.text = "আপনার QR কোড দেখতে এখানে ক্লিক করুন"
            }else{
                self.enterQRCodeLabel.text = "Enter QR code in the above field and submit."
                self.scanQRCodeButton.setTitle("Scan QR Code", for: .normal)
                self.infoLbl.text = "Click here to see your QR Codes"
            }
        }
    }
   
    func fetchDetails1(){
           
           let fetchRequest:NSFetchRequest<UploadedCodes> = UploadedCodes.fetchRequest()
           do{
               self.uploadedCodes = try persistanceservice.context.fetch(fetchRequest)
               print(self.uploadedCodes.count, "Uploaded Count")
               
               for QRCodes in self.VM.savedCodeListArray{
                   print(QRCodes.qrCode ?? 0, "Codes")
                   let filterArray = self.uploadedCodes.filter{$0.code == QRCodes.qrCode}
                   if filterArray.count > 0{
                       for QrcodeData in self.uploadedCodes {
                           if QrcodeData.code == QRCodes.qrCode{
                               print(QRCodes.qrCode ?? "", "Deleted")
                               persistanceservice.context.delete(QrcodeData)
                               persistanceservice.saveContext()
                               self.fetchDetails2()
                           }
                       }
                   }
               }
          
           }catch{
               print("error while fetching data")
           }
       }

       func fetchDetails2(){
           let fetchRequest:NSFetchRequest<UploadedCodes> = UploadedCodes.fetchRequest()
           do{
               self.uploadedCodes = try persistanceservice.context.fetch(fetchRequest)
               print(self.uploadedCodes.count)
               
           }catch{
               print("error while fetching data")
           }
       }
    func codesSubmissionsApi(){
        
        print(parameterJSON,"jdskdj")
        self.VM.submitCodesApi(parameters: self.parameterJSON!)
    }
    
    
    @IBAction func closeScreen(_ sender: Any) {
        clearTable()
        self.session.stopRunning()
        if self.fromSideMenu == "SideMenu"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            }
        }else{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .goToParticularVc, object: nil)
            }
        }
        
    }
    
    @IBAction func submitButton(_ sender: Any) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.fetchDetails()
            if self.codeTF.text != ""{
                if self.codeTF.text?.count == 12{
                    if self.codeLIST.count == 0{
                        print("UploadCode")
                        let date = Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
                        let resultdate = formatter.string(from: date)
                        let qRCodeDBTable = ScanCodeSTORE(context: persistanceservice.context)
                        qRCodeDBTable.code = self.codeTF.text
                        qRCodeDBTable.date = resultdate
                        qRCodeDBTable.latitude = String(currentlocation.coordinate.latitude)
                       qRCodeDBTable.longitude = String(currentlocation.coordinate.longitude)
                        persistanceservice.saveContext()
                        self.fetchDetails()
                        self.restartScanning()
                    return
                    }else{
                        print("ScannedCode")
                        self.fetchDetails()
                        self.enteredCodeArray.removeAll()
                        for codes in self.codeLIST{
                            self.enteredCodeArray.append(codes.code ?? "")
                        }
                        let enterData = self.codeTF.text
                        if self.enteredCodeArray.contains(enterData ?? ""){
                            DispatchQueue.main.async{
                               let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                               vc!.delegate = self
                               vc!.titleInfo = ""
                                vc!.itsComeFrom = "Upload"
                                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                vc!.descriptionInfo = "Code scanned successfully"
                                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                    vc!.descriptionInfo = "कोड सफलतापूर्वक स्कैन किया गया"
                                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                    vc!.descriptionInfo = "কোড সফলভাবে স্ক্যান করা হয়েছে"
                                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                                    vc!.descriptionInfo = "కోడ్ విజయవంతంగా స్కాన్ చేయబడింది"
                                }else{
                                    vc!.descriptionInfo = "Code scanned successfully"
                                }
                               vc!.modalPresentationStyle = .overCurrentContext
                               vc!.modalTransitionStyle = .crossDissolve
                               self.present(vc!, animated: true, completion: nil)
                            }
                        }else{
                            if self.codeLIST.count <= 14{
                                let date = Date()
                                let formatter = DateFormatter()
                                formatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
                                let resultdate = formatter.string(from: date)
                                let qRCodeDBTable = ScanCodeSTORE(context: persistanceservice.context)
                                qRCodeDBTable.code = self.codeTF.text
                                qRCodeDBTable.date = resultdate
                                qRCodeDBTable.latitude = String(currentlocation.coordinate.latitude)
                                qRCodeDBTable.longitude = String(currentlocation.coordinate.longitude)
                                persistanceservice.saveContext()
                                self.fetchDetails()
                                self.restartScanning()
                            }else{
                                
                                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                    let alert = UIAlertController(title: "", message: "Offline scanning limit exceeded. Sync pending codes in Wifi/Mobile data or Clear processed codes .", preferredStyle: UIAlertController.Style.alert)
                                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                                            self.codeTF.text = ""
                                            self.session.stopRunning()
                                        NotificationCenter.default.post(name: .CodeSubmission, object: nil)
                                        }))
                                        self.present(alert, animated: true, completion: nil)
                                    
                                }else  if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                    let alert = UIAlertController(title: "", message: "ऑफलाइन स्कैनिंग की सीमा पार हो गई। वाई-फाई / मोबाइल डेटा या स्पष्ट संसाधित कोड में लंबित कोड सिंक करें।", preferredStyle: UIAlertController.Style.alert)
                                    alert.addAction(UIAlertAction(title: "ठीक", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                                            self.codeTF.text = ""
                                            self.session.stopRunning()
                                        NotificationCenter.default.post(name: .CodeSubmission, object: nil)
                                        }))
                                        self.present(alert, animated: true, completion: nil)
                                }else  if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                    let alert = UIAlertController(title: "", message: "অফলাইন স্ক্যানিং সীমা অতিক্রম হয়েছে। ওয়াইফাই / মোবাইল ডেটাতে বিচ্ছিন্ন কোডগুলি সিঙ্ক করুন বা প্রক্রিয়াজাত করণ  কোড ক্লিয়ার করুন", preferredStyle: UIAlertController.Style.alert)
                                    alert.addAction(UIAlertAction(title: "ওকে", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                                            self.codeTF.text = ""
                                            self.session.stopRunning()
                                        NotificationCenter.default.post(name: .CodeSubmission, object: nil)
                                        }))
                                        self.present(alert, animated: true, completion: nil)
                                }else  if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                                    let alert = UIAlertController(title: "", message: "ఆఫ్లైన్ స్కానింగ్ పరిమితి మించిపోయింది. వైఫై / మొబైల్ డేటాలో పెండింగ్ కోడ్లను సమకాలీకరించండి లేదా ప్రాసెస్ చేసిన కోడ్లను క్లియర్ చేయండి.", preferredStyle: UIAlertController.Style.alert)
                                    alert.addAction(UIAlertAction(title: "సరే", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                                            self.codeTF.text = ""
                                            self.session.stopRunning()
                                        NotificationCenter.default.post(name: .CodeSubmission, object: nil)
                                        }))
                                        self.present(alert, animated: true, completion: nil)
                                }else{
                                    let alert = UIAlertController(title: "", message: "Offline scanning limit exceeded. Sync pending codes in Wifi/Mobile data or Clear processed codes .", preferredStyle: UIAlertController.Style.alert)
                                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                                            self.codeTF.text = ""
                                            self.session.stopRunning()
                                        NotificationCenter.default.post(name: .CodeSubmission, object: nil)
                                        }))
                                        self.present(alert, animated: true, completion: nil)
                                    
                                }
                                
                            }
                        }
                        
                    }
                    
                }else{
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        let alert = UIAlertController(title: "", message: "QR Code length should be 12", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                                self.codeTF.text = ""
                                self.session.stopRunning()
                            }))
                            self.present(alert, animated: true, completion: nil)
                        
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                        let alert = UIAlertController(title: "", message: "क्यूआर कोड की लंबाई 12 . होनी चाहिए", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "ठीक", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                                self.codeTF.text = ""
                                self.session.stopRunning()
                            }))
                            self.present(alert, animated: true, completion: nil)
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        let alert = UIAlertController(title: "", message: "QR কোডের দৈর্ঘ্য 12 হওয়া উচিত", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "ওকে", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                                self.codeTF.text = ""
                                self.session.stopRunning()
                            }))
                            self.present(alert, animated: true, completion: nil)
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        let alert = UIAlertController(title: "", message: "QR కోడ్ పొడవు 12 ఉండాలి", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "సరే", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                                self.codeTF.text = ""
                                self.session.stopRunning()
                            }))
                            self.present(alert, animated: true, completion: nil)
                    }else{
                     
                        let alert = UIAlertController(title: "", message: "QR Code length should be 12", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                                self.codeTF.text = ""
                                self.session.stopRunning()
                            }))
                            self.present(alert, animated: true, completion: nil)
                    }
                  
                    
                }
            }else{
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    let alert = UIAlertController(title: "", message: "Enter the QR Code", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                    let alert = UIAlertController(title: "", message: "क्यूआर कोड दर्ज करें", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "ठीक", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    let alert = UIAlertController(title: "", message: "QR কোড লিখুন", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "ওকে", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    let alert = UIAlertController(title: "", message: "QR కోడ్‌ని నమోదు చేయండి", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "సరే", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                }else{
                    
                        let alert = UIAlertController(title: "", message: "Enter the QR Code", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        
                    
                }
                
                
                
            }
            
        }else{
                // Create the alert controller
            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                let alertController = UIAlertController(title: "Enable Location Services", message: "QR Code scanning requires Location Access", preferredStyle: .alert)
                    
                    // Create the actions
                let okAction = UIAlertAction(title: "Settings", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        NSLog("OK Pressed")
                        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                        self.authorizelocationstates()
                    }
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                        NSLog("Cancel Pressed")
                    }
                    
                    // Add the actions
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    
                    // Present the controller
                    self.present(alertController, animated: true, completion: nil)
                    // Note : This function is overlap permission
                
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                let alertController = UIAlertController(title: "लोकेशन सेवाओं को सक्षम करें", message: "क्यूआर कोड स्कैनिंग के लिए लोकेशन एक्सेस की आवश्यकता होती है", preferredStyle: .alert)
                    
                    // Create the actions
                let okAction = UIAlertAction(title: "समायोजन", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        NSLog("OK Pressed")
                        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                        self.authorizelocationstates()
                    }
                let cancelAction = UIAlertAction(title: "रद्द करना", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                        NSLog("Cancel Pressed")
                    }
                    
                    // Add the actions
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    
                    // Present the controller
                    self.present(alertController, animated: true, completion: nil)
                    // Note : This function is overlap permission
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                let alertController = UIAlertController(title: "অবস্থান পরিষেবা সক্রিয়", message: "QR কোড স্ক্যান করার জন্য অবস্থান অ্যাক্সেস প্রয়োজন", preferredStyle: .alert)
                    
                    // Create the actions
                let okAction = UIAlertAction(title: "সেটিংস", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        NSLog("OK Pressed")
                        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                        self.authorizelocationstates()
                    }
                let cancelAction = UIAlertAction(title: "বাতিল করুন", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                        NSLog("Cancel Pressed")
                    }
                    
                    // Add the actions
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    
                    // Present the controller
                    self.present(alertController, animated: true, completion: nil)
                    // Note : This function is overlap permission
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                let alertController = UIAlertController(title: "స్థాన సేవలను ప్రారంభించండి", message: "QR కోడ్ స్కానింగ్‌కు స్థాన యాక్సెస్ అవసరం", preferredStyle: .alert)
                    
                    // Create the actions
                let okAction = UIAlertAction(title: "సెట్టింగ్‌లు", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        NSLog("OK Pressed")
                        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                        self.authorizelocationstates()
                    }
                let cancelAction = UIAlertAction(title: "రద్దు చేయండి", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                        NSLog("Cancel Pressed")
                    }
                    
                    // Add the actions
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    
                    // Present the controller
                    self.present(alertController, animated: true, completion: nil)
                    // Note : This function is overlap permission
            }else{
                    let alertController = UIAlertController(title: "Enable Location Services", message: "QR Code scanning requires Location Access", preferredStyle: .alert)
                        
                        // Create the actions
                    let okAction = UIAlertAction(title: "Settings", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            NSLog("OK Pressed")
                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                            self.authorizelocationstates()
                        }
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                            UIAlertAction in
                            NSLog("Cancel Pressed")
                        }
                        
                        // Add the actions
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)
                        // Note : This function is overlap permission
            }
    
                
            }
        
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        clearTable()
        self.session.stopRunning()
        if self.fromSideMenu == "SideMenu"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            }
        }else{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .goToParticularVc, object: nil)
            }
        }
        
    }
    @IBAction func scannedCodesButton(_ sender: Any) {
        if self.scanQRCodeButton.currentTitle == "Upload QR Code" || self.scanQRCodeButton.currentTitle == "क्यूआर कोड अपलोड करें" || self.scanQRCodeButton.currentTitle == "QR কোড আপলোড করুন" || self.scanQRCodeButton.currentTitle == "QR కోడ్‌ని అప్‌లోడ్ చేయండి"{
            self.session.stopRunning()
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScannedCodes_VC") as! ScannedCodes_VC
            vc.itsFrom = "Scanner"
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScannedCodes_VC") as! ScannedCodes_VC
            vc.itsFrom = "Upload"
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
       
    }
    
    @IBAction func scanQRCode(_ sender: Any) {
        if self.scanQRCodeButton.currentTitle == "Upload QR Code" || self.scanQRCodeButton.currentTitle == "क्यूआर कोड अपलोड करें" || self.scanQRCodeButton.currentTitle == "QR কোড আপলোড করুন" || self.scanQRCodeButton.currentTitle == "QR కోడ్‌ని అప్‌లోడ్ చేయండి"{
            self.headerView.isHidden = false
            self.closeBTN.isHidden = true
            
            self.scanQRCodeButton.setImage(UIImage(named: "qr"), for: .normal)
            self.scannerView.isHidden = true
            self.uploadView.isHidden = false
            self.messageLbl.isHidden = true
            self.session.stopRunning()
            fetchDetails()
            self.isScanned = false
            self.isFrom = 0
            self.isscannedOnce = false
            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                self.enterQRCodeLabel.text = "Enter QR code in the above field and submit."
                self.scanQRCodeButton.setTitle("Scan QR Code", for: .normal)
                self.infoLbl.text = "Click here to see your QR Codes"
                
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                
                self.enterQRCodeLabel.text = "उपरोक्त फ़ील्ड में क्यूआर कोड दर्ज करें और सबमिट करें।"
                self.scanQRCodeButton.setTitle("क्यू आर कोड स्कैन करें", for: .normal)
                self.infoLbl.text = "अपने क्यूआर कोड देखने के लिए यहां क्लिक करें"
                
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                self.enterQRCodeLabel.text = "উপরের ক্ষেত্রে QR কোড লিখুন এবং জমা দিন।"
                self.scanQRCodeButton.setTitle("QR কোড স্ক্যান করুন", for: .normal)
                self.infoLbl.text = "আপনার QR কোড দেখতে এখানে ক্লিক করুন"
            }else{
                self.enterQRCodeLabel.text = "Enter QR code in the above field and submit."
                self.scanQRCodeButton.setTitle("Scan QR Code", for: .normal)
                self.infoLbl.text = "Click here to see your QR Codes"
            }
            
            session.stopRunning()
        }else{
            self.messageLbl.isHidden = false
            self.scannerView.isHidden = false
            self.uploadView.isHidden = true
            self.closeBTN.isHidden = false
            self.headerView.isHidden = true
            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it"
                self.scanQRCodeButton.setTitle("Upload QR Code", for: .normal)
                self.infoLbl.text = "Click here to see your QR Codes"
                
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                
                self.messageLbl.text = "इसे स्कैन करने के लिए व्यू फाइंडर आयत के अंदर एक क्यूआर कोड रखें।"
                self.scanQRCodeButton.setTitle("क्यूआर कोड अपलोड करें", for: .normal)
                self.infoLbl.text = "अपने क्यूआर कोड देखने के लिए यहां क्लिक करें"
                
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                self.messageLbl.text = "এটি স্ক্যান করতে ভিউ ফাইন্ডার আয়তক্ষেত্রের ভিতরে একটি QR কোড রাখুন।"
                self.scanQRCodeButton.setTitle("QR কোড আপলোড করুন", for: .normal)
                self.infoLbl.text = "আপনার QR কোড দেখতে এখানে ক্লিক করুন"
            }else{
                self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it"
                self.scanQRCodeButton.setTitle("Upload QR Code", for: .normal)
                self.infoLbl.text = "Click here to see your QR Codes"
            }
            self.scanQRCodeButton.setImage(UIImage(named: "software-upload"), for: .normal)
                if isComingFrom == 1{
                    NotificationCenter.default.post(name: .scanAccess, object: nil)
                }
               
                if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                    if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
                        fetchDetails()
                        self.isScanned = true
                        scaned = 1
                        self.scannedStatus = false
                        self.barcodeDetector = vision.barcodeDetector()
                        
                        

                        if isFirsttime == true{
                            startLiveVideo()
                            self.isFirsttime = false
                            self.scaned = 1
                            self.scannedStatus = true
                        }else{
                            session.startRunning()
//                            self.restartScanning()
//                            print("Restart Again")
                            self.messageLbl.isHidden = false
                            self.headerView.isHidden = true
                            self.closeBTN.isHidden = false
                            self.scanQRCodeButton.setImage(UIImage(named: "software-upload"), for: .normal)
                            self.scannerView.isHidden = false
                            self.uploadView.isHidden = true
                            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it"
                                self.scanQRCodeButton.setTitle("Upload QR Code", for: .normal)
                                self.infoLbl.text = "Click here to see your QR Codes"
                                
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                
                                self.messageLbl.text = "इसे स्कैन करने के लिए व्यू फाइंडर आयत के अंदर एक क्यूआर कोड रखें।"
                                self.scanQRCodeButton.setTitle("क्यूआर कोड अपलोड करें", for: .normal)
                                self.infoLbl.text = "अपने क्यूआर कोड देखने के लिए यहां क्लिक करें"
                                
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                self.messageLbl.text = "এটি স্ক্যান করতে ভিউ ফাইন্ডার আয়তক্ষেত্রের ভিতরে একটি QR কোড রাখুন।"
                                self.scanQRCodeButton.setTitle("QR কোড আপলোড করুন", for: .normal)
                                self.infoLbl.text = "আপনার QR কোড দেখতে এখানে ক্লিক করুন"
                            }else{
                                self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it"
                                self.scanQRCodeButton.setTitle("Upload QR Code", for: .normal)
                                self.infoLbl.text = "Click here to see your QR Codes"
                            }
                            self.scannedStatus = true
                            self.session.startRunning()
                        }

                    }else{
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            let alertVC = UIAlertController(title: "Century Ply Application need Camera permission for Scanning Codes", message: "Allow Camera Access", preferredStyle: .alert)
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
                            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            let alertVC = UIAlertController(title: "सेंचुरी प्लाई एप्लिकेशन को स्कैनिंग कोड के लिए कैमरा अनुमति की आवश्यकता है", message: "कैमरा एक्सेस की अनुमति दें", preferredStyle: .alert)
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
                            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            let alertVC = UIAlertController(title: "সেঞ্চুরি প্লাই অ্যাপ্লিকেশনটির স্ক্যানিং কোডের জন্য ক্যামেরার অনুমতি প্রয়োজন", message: "ক্যামেরা অ্যাক্সেসের অনুমতি দিন", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "অনুমতি দিন", style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                            }
                            let cancelAction = UIAlertAction(title: "অনুমতি না দেওয়া", style: UIAlertAction.Style.cancel) {
                                UIAlertAction in
                                
                            }
                            alertVC.addAction(okAction)
                            alertVC.addAction(cancelAction)
                            self.present(alertVC, animated: true, completion: nil)
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                            let alertVC = UIAlertController(title: "సెంచరీ ప్లై అప్లికేషన్ కోడ్‌లను స్కానింగ్ చేయడానికి కెమెరా అనుమతి అవసరం", message: "కెమెరా యాక్సెస్‌ని అనుమతించండి", preferredStyle: .alert)
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
                        }else{
                            let alertVC = UIAlertController(title: "EuroBond Application need Camera permission for Scanning Codes", message: "Allow Camera Access", preferredStyle: .alert)
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
                }else{
                    // Create the alert controller
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    let alertController = UIAlertController(title: "Enable Location Services", message: "QR Code scanning requires Location Access", preferredStyle: .alert)
                        
                        // Create the actions
                    let okAction = UIAlertAction(title: "Settings", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            NSLog("OK Pressed")
                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                            self.authorizelocationstates()
                        }
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                            UIAlertAction in
                            NSLog("Cancel Pressed")
                        }
                        
                        // Add the actions
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)
                        // Note : This function is overlap permission
                    
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                    let alertController = UIAlertController(title: "लोकेशन सेवाओं को सक्षम करें", message: "क्यूआर कोड स्कैनिंग के लिए लोकेशन एक्सेस की आवश्यकता होती है", preferredStyle: .alert)
                        
                        // Create the actions
                    let okAction = UIAlertAction(title: "समायोजन", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            NSLog("OK Pressed")
                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                            self.authorizelocationstates()
                        }
                    let cancelAction = UIAlertAction(title: "रद्द करना", style: UIAlertAction.Style.cancel) {
                            UIAlertAction in
                            NSLog("Cancel Pressed")
                        }
                        
                        // Add the actions
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)
                        // Note : This function is overlap permission
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    let alertController = UIAlertController(title: "অবস্থান পরিষেবা সক্রিয়", message: "QR কোড স্ক্যান করার জন্য অবস্থান অ্যাক্সেস প্রয়োজন", preferredStyle: .alert)
                        
                        // Create the actions
                    let okAction = UIAlertAction(title: "সেটিংস", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            NSLog("OK Pressed")
                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                            self.authorizelocationstates()
                        }
                    let cancelAction = UIAlertAction(title: "বাতিল করুন", style: UIAlertAction.Style.cancel) {
                            UIAlertAction in
                            NSLog("Cancel Pressed")
                        }
                        
                        // Add the actions
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)
                        // Note : This function is overlap permission
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    let alertController = UIAlertController(title: "స్థాన సేవలను ప్రారంభించండి", message: "QR కోడ్ స్కానింగ్‌కు స్థాన యాక్సెస్ అవసరం", preferredStyle: .alert)
                        
                        // Create the actions
                    let okAction = UIAlertAction(title: "సెట్టింగ్‌లు", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            NSLog("OK Pressed")
                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                            self.authorizelocationstates()
                        }
                    let cancelAction = UIAlertAction(title: "రద్దు చేయండి", style: UIAlertAction.Style.cancel) {
                            UIAlertAction in
                            NSLog("Cancel Pressed")
                        }
                        
                        // Add the actions
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)
                        // Note : This function is overlap permission
                }else{
                        let alertController = UIAlertController(title: "Enable Location Services", message: "QR Code scanning requires Location Access", preferredStyle: .alert)
                            
                            // Create the actions
                        let okAction = UIAlertAction(title: "Settings", style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                NSLog("OK Pressed")
                                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                                self.authorizelocationstates()
                            }
                        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                UIAlertAction in
                                NSLog("Cancel Pressed")
                            }
                            
                            // Add the actions
                            alertController.addAction(okAction)
                            alertController.addAction(cancelAction)
                            
                            // Present the controller
                            self.present(alertController, animated: true, completion: nil)
                            // Note : This function is overlap permission
                }
                    
                }
            
        }
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//    if string == " " {
//        return false
//    }
//
//        if textField == codeTF{
//            let maxLength = 12
//            let currentString: NSString = (codeTF.text ?? "") as NSString
//            let newString: NSString =
//                currentString.replacingCharacters(in: range, with: string) as NSString
//            return newString.length <= maxLength
//        }
//        return true
//    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
      let compSepByCharInSet = string.components(separatedBy: aSet)
      let numberFiltered = compSepByCharInSet.joined(separator: "")

      if string == numberFiltered {
        let currentText = codeTF.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 12
      } else {
        return false
      }
    }
    func authorizelocationstates(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentlocation = locationManager.location
            print(currentlocation)
        }
        else{
            // Note : This function is overlap permission
            locationManager.requestWhenInUseAuthorization()
            authorizelocationstates()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        // Only called when variable have location data
        authorizelocationstates()
    }
    func clearTable(){
        
        let context = persistanceservice.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ScanCodeSTORE")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }

    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        DispatchQueue.main.async {
            
            if let barcodeDetector = self.barcodeDetector {
                let visionImage = VisionImage(buffer: sampleBuffer)
                barcodeDetector.detect(in: visionImage) { (barcodes, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }else{
                        if self.scannedStatus == false{
                            self.session.stopRunning()
                            return
                        }else{
                            
                            for barcode in barcodes!{
                                if self.scaned == 1{
                                    
                                    self.session.stopRunning()
                                    let scannedCodess = barcode.rawValue!.replacingOccurrences(of: " ", with: "")
                                    self.CapturedCodess = scannedCodess
                                    
                                    if scannedCodess.count == 12{
                                        let compareCodes = self.codeLIST.filter({$0.code == self.CapturedCodess})
                                        self.session.stopRunning()
                                        AudioServicesPlaySystemSound(1103)
                                        if self.codeLIST.count <= 14{
                                            if compareCodes.count == 0{
                                                print("Success")
                                                let date = Date()
                                                let formatter = DateFormatter()
                                                formatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
                                                let resultdate = formatter.string(from: date)
                                                let qRCodeDBTable = ScanCodeSTORE(context: persistanceservice.context)
                                                qRCodeDBTable.code = self.CapturedCodess
                                                qRCodeDBTable.latitude = String(self.currentlocation.coordinate.latitude)
                                                qRCodeDBTable.longitude = String(self.currentlocation.coordinate.longitude)
                                                qRCodeDBTable.date = resultdate
                                                persistanceservice.saveContext()
                                                self.scaned = 0
                                                self.isScanned = true
                                                self.scannedStatus = false
                                                self.session.stopRunning()
                                                self.fetchDetails()
                                                self.restartScanning()
                                                self.session.stopRunning()
                                                return
                                            }else{
                                                self.scaned = 0
                                                self.Validation()
                                                return
                                            }
                                        }else{
                                            if compareCodes.count == 0{
                                                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                                    let alert = UIAlertController(title: "", message: "Offline scanning limit exceeded. Sync pending codes in Wifi/Mobile data or Clear processed codes .", preferredStyle: UIAlertController.Style.alert)
                                                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: {   UIAlertAction in
                                                        self.isScanned = true
                                                        self.session.startRunning()
                                                        NotificationCenter.default.post(name: .CodeSubmission, object: nil)
                                                    }))
                                                    self.present(alert, animated: true, completion: nil)
                                                    
                                                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                                    let alert = UIAlertController(title: "", message: "ऑफलाइन स्कैनिंग की सीमा पार हो गई। वाई-फाई / मोबाइल डेटा या स्पष्ट संसाधित कोड में लंबित कोड सिंक करें।", preferredStyle: UIAlertController.Style.alert)
                                                    alert.addAction(UIAlertAction(title: "ठीक", style: UIAlertAction.Style.default, handler: {   UIAlertAction in
                                                        self.isScanned = true
                                                        self.session.startRunning()
                                                        NotificationCenter.default.post(name: .CodeSubmission, object: nil)
                                                    }))
                                                    self.present(alert, animated: true, completion: nil)
                                                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                                    let alert = UIAlertController(title: "", message: "অফলাইন স্ক্যানিং সীমা অতিক্রম হয়েছে। ওয়াইফাই / মোবাইল ডেটাতে বিচ্ছিন্ন কোডগুলি সিঙ্ক করুন বা প্রক্রিয়াজাত করণ  কোড ক্লিয়ার করুন ", preferredStyle: UIAlertController.Style.alert)
                                                    alert.addAction(UIAlertAction(title: "ওকে", style: UIAlertAction.Style.default, handler: {   UIAlertAction in
                                                        self.isScanned = true
                                                        self.session.startRunning()
                                                        NotificationCenter.default.post(name: .CodeSubmission, object: nil)
                                                    }))
                                                    self.present(alert, animated: true, completion: nil)
                                                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                                                    let alert = UIAlertController(title: "", message: "ఆఫ్లైన్ స్కానింగ్ పరిమితి మించిపోయింది. వైఫై / మొబైల్ డేటాలో పెండింగ్ కోడ్లను సమకాలీకరించండి లేదా ప్రాసెస్ చేసిన కోడ్లను క్లియర్ చేయండి.", preferredStyle: UIAlertController.Style.alert)
                                                    alert.addAction(UIAlertAction(title: "సరే", style: UIAlertAction.Style.default, handler: {   UIAlertAction in
                                                        self.isScanned = true
                                                        self.session.startRunning()
                                                        NotificationCenter.default.post(name: .CodeSubmission, object: nil)
                                                    }))
                                                    self.present(alert, animated: true, completion: nil)
                                                }else{
                                                        let alert = UIAlertController(title: "", message: "Offline scanning limit exceeded. Sync pending codes in Wifi/Mobile data or Clear processed codes .", preferredStyle: UIAlertController.Style.alert)
                                                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: {   UIAlertAction in
                                                            self.isScanned = true
                                                            self.session.startRunning()
                                                            NotificationCenter.default.post(name: .CodeSubmission, object: nil)
                                                        }))
                                                        self.present(alert, animated: true, completion: nil)
                                                }
                                             
                                                return
                                            }else{
                                                
                                                self.scaned = 0
                                                self.Validation()
                                                return
                                            }
                                            
                                        }
                                        
                                    }else{
                                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                            let alert = UIAlertController(title: "", message: "QR Code length should be 12", preferredStyle: UIAlertController.Style.alert)
                                            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { UIAlertAction in
                                                self.isScanned = true
                                                self.session.startRunning()
                                                
                                            }))
                                            self.present(alert, animated: true, completion: nil)
                                            
                                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                            let alert = UIAlertController(title: "", message: "क्यूआर कोड की लंबाई 12 . होनी चाहिए", preferredStyle: UIAlertController.Style.alert)
                                            alert.addAction(UIAlertAction(title: "ठीक", style: UIAlertAction.Style.default, handler: { UIAlertAction in
                                                self.isScanned = true
                                                self.session.startRunning()
                                                
                                            }))
                                            self.present(alert, animated: true, completion: nil)
                                            
                                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                            let alert = UIAlertController(title: "", message: "QR কোডের দৈর্ঘ্য 12 হওয়া উচিত", preferredStyle: UIAlertController.Style.alert)
                                            alert.addAction(UIAlertAction(title: "ওকে", style: UIAlertAction.Style.default, handler: { UIAlertAction in
                                                self.isScanned = true
                                                self.session.startRunning()
                                                
                                            }))
                                            self.present(alert, animated: true, completion: nil)
                                            
                                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                                            let alert = UIAlertController(title: "", message: "QR కోడ్ పొడవు 12 ఉండాలి", preferredStyle: UIAlertController.Style.alert)
                                            alert.addAction(UIAlertAction(title: "సరే", style: UIAlertAction.Style.default, handler: { UIAlertAction in
                                                self.isScanned = true
                                                self.session.startRunning()
                                                
                                            }))
                                            self.present(alert, animated: true, completion: nil)
                                        }else{
                                            let alert = UIAlertController(title: "", message: "QR Code length should be 12", preferredStyle: UIAlertController.Style.alert)
                                            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { UIAlertAction in
                                                self.isScanned = true
                                                self.session.startRunning()
                                                
                                            }))
                                            self.present(alert, animated: true, completion: nil)
                                            
                                        }
                                       
                                        
                                    }
                                }else{
                                    self.scaned = 1
                                    return
                                }
                            }
                        }
                        
                    }
                    
                }
            }
        }
}
    
    
    func Validation(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            self.session.stopRunning()
            DispatchQueue.main.async{
               let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
               vc!.delegate = self
               vc!.titleInfo = ""
                vc!.itsComeFrom = "Scanner"
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                vc!.descriptionInfo = "Code scanned successfully"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                    vc!.descriptionInfo = "कोड सफलतापूर्वक स्कैन किया गया"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    vc!.descriptionInfo = "কোড সফলভাবে স্ক্যান করা হয়েছে"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    vc!.descriptionInfo = "కోడ్ విజయవంతంగా స్కాన్ చేయబడింది"
                }else{
                    vc!.descriptionInfo = "Code scanned successfully"
                    }
               vc!.modalPresentationStyle = .overCurrentContext
               vc!.modalTransitionStyle = .crossDissolve
               self.present(vc!, animated: true, completion: nil)
            }
        })

    }
    func restartScanning(){
        fetchDetails()
        if isScanned == true{
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                self.messageLbl.isHidden = false
                self.headerView.isHidden = true
                self.closeBTN.isHidden = false
                self.scanQRCodeButton.setImage(UIImage(named: "software-upload"), for: .normal)
                self.scannerView.isHidden = false
                self.uploadView.isHidden = true
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it"
                    self.scanQRCodeButton.setTitle("Upload QR Code", for: .normal)
                    self.infoLbl.text = "Click here to see your QR Codes"
                    
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                    
                    self.messageLbl.text = "इसे स्कैन करने के लिए व्यू फाइंडर आयत के अंदर एक क्यूआर कोड रखें।"
                    self.scanQRCodeButton.setTitle("क्यूआर कोड अपलोड करें", for: .normal)
                    self.infoLbl.text = "अपने क्यूआर कोड देखने के लिए यहां क्लिक करें"
                    
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    self.messageLbl.text = "এটি স্ক্যান করতে ভিউ ফাইন্ডার আয়তক্ষেত্রের ভিতরে একটি QR কোড রাখুন।"
                    self.scanQRCodeButton.setTitle("QR কোড আপলোড করুন", for: .normal)
                    self.infoLbl.text = "আপনার QR কোড দেখতে এখানে ক্লিক করুন"
                }else{
                    self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it"
                    self.scanQRCodeButton.setTitle("Upload QR Code", for: .normal)
                    self.infoLbl.text = "Click here to see your QR Codes"
                }
                self.scannedStatus = true
                self.session.startRunning()
            })
        }else{
            self.session.stopRunning()
            self.codeTF.text = ""
            self.headerView.isHidden = false
            self.closeBTN.isHidden = true
            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                self.enterQRCodeLabel.text = "Enter QR code in the above field and submit."
                self.scanQRCodeButton.setTitle("Scan QR Code", for: .normal)
                self.infoLbl.text = "Click here to see your QR Codes"
                
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                
                self.enterQRCodeLabel.text = "उपरोक्त फ़ील्ड में क्यूआर कोड दर्ज करें और सबमिट करें।"
                self.scanQRCodeButton.setTitle("क्यू आर कोड स्कैन करें", for: .normal)
                self.infoLbl.text = "अपने क्यूआर कोड देखने के लिए यहां क्लिक करें"
                
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                self.enterQRCodeLabel.text = "উপরের ক্ষেত্রে QR কোড লিখুন এবং জমা দিন।"
                self.scanQRCodeButton.setTitle("QR কোড স্ক্যান করুন", for: .normal)
                self.infoLbl.text = "আপনার QR কোড দেখতে এখানে ক্লিক করুন"
            }else{
                self.enterQRCodeLabel.text = "Enter QR code in the above field and submit."
                self.scanQRCodeButton.setTitle("Scan QR Code", for: .normal)
                self.infoLbl.text = "Click here to see your QR Codes"
            }

            self.scanQRCodeButton.setImage(UIImage(named: "qr"), for: .normal)
        }
       }
    
    private func startLiveVideo() {
        DispatchQueue.main.async {
            self.session.sessionPreset = AVCaptureSession.Preset.photo
            let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
            let deviceInput = try! AVCaptureDeviceInput(device: captureDevice!)
            let deviceOutput = AVCaptureVideoDataOutput()
            deviceOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
            deviceOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
            self.session.addInput(deviceInput)
            self.session.addOutput(deviceOutput)
            let imageLayer = AVCaptureVideoPreviewLayer(session: self.session)
            imageLayer.frame = CGRect(x: 0, y: 0, width: self.scannerView.frame.size.width, height: self.scannerView.frame.size.height)
            imageLayer.videoGravity = .resizeAspectFill
            self.scannerView.layer.addSublayer(imageLayer)
            self.session.startRunning()
            self.isscannedOnce = true
        }
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil)
                                        {
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                        }
                                        let pm = placemarks! as [CLPlacemark]
                                        if pm.count > 0 {
                                            let pm = placemarks![0]
                                            print(pm.country)
                                            print(pm.locality)
                                            print(pm.subLocality)
                                            print(pm.thoroughfare)
                                            print(pm.postalCode)
                                            print(pm.subThoroughfare)
                                            if pm.thoroughfare != nil {
                                                self.addressString = self.addressString + pm.thoroughfare! + ", "
                                                self.address = pm.thoroughfare!
                                            }
                                            if pm.subLocality != nil {
                                                self.addressString = self.addressString + pm.subLocality! + ", "
                                                self.address = self.address + pm.subLocality!
                                            }
                                            if pm.locality != nil {
                                                self.addressString = self.addressString + pm.locality! + ", "
                                                self.city = pm.locality!
                                            }
                                            if pm.country != nil {
                                                self.addressString = self.addressString + pm.country! + ", "
                                                self.country = pm.country!
                                            }
                                            if pm.postalCode != nil {
                                                self.addressString = self.addressString + pm.postalCode! + " "
                                                self.pincode = pm.postalCode!
                                            }
                                            
                                            
                                            print(self.addressString)
                                            
                                                self.stopLoading()
//                                                self.VM.saveScannedandUploadCodesApi(parameters: self.parameterJSON!)
                                            self.codesSubmissionsApi()
                                            
                                        }
                                    })
        
    }
    
    
    
    
}
//extension Array where Element: Hashable {
//    func removingDuplicates() -> [Element] {
//        var addedDict = [Element: Bool]()
//
//        return filter {
//            addedDict.updateValue(true, forKey: $0) == nil
//        }
//    }
//
//    mutating func removeDuplicates() {
//        self = self.removingDuplicates()
//    }
//}
