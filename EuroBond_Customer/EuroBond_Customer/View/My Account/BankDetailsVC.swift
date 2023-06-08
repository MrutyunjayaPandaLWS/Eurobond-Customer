//
//  BankDetailsVC.swift
//  GogrejLocksMobileApplication
//
//  Created by ADMIN on 01/07/2022.
//  Copyright © 2022 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Kingfisher
import LanguageManager_iOS
class BankDetailsVC: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, popUpAlertDelegate, popUpDelegate1{
    func popupAlertDidTap1(_ vc: PopupAlertOne_VC) {}
    
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    

    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var uploadDoccumentInfoLbl: UILabel!
    @IBOutlet weak var uploadDoccumentBtn: UIButton!
    @IBOutlet weak var ifscCodeTF: UITextField!
    @IBOutlet weak var ifscCodeLbl: UILabel!
    @IBOutlet weak var bankNameTF: UITextField!
    @IBOutlet weak var bankNameLbl: UILabel!
    @IBOutlet weak var confirmAccountNumberTF: UITextField!
    @IBOutlet weak var connfirmAccountNumberLbl: UILabel!
    @IBOutlet weak var accountNumberTF: UITextField!
    @IBOutlet weak var accountNnumberLbl: UILabel!
    @IBOutlet weak var accountHolderTF: UITextField!
    @IBOutlet weak var accounntHolderNameTitle: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet var uploadImageHeight: NSLayoutConstraint!
    @IBOutlet var verificationStatusTitle: UILabel!
    @IBOutlet var verificationStatusLbl: UILabel!
    @IBOutlet weak var uploadOutButton: UIButton!
    
    let picker = UIImagePickerController()
    var strdata1 = ""
    var VM = EBC_MyProfileVM()
    var requestAPIs = RestAPI_Requests()
    
    var beneficiaryTypeTF: String = "", firstNameTF: String = "", lastNameTF: String = "", mobileNumberTF: String = "", emailTF: String = "", addressTF: String = "", stateTF: String = "", cityTF: String = "", pinCodeTF: String = "", doB: String = "", stateId: String = "0", cityId: String = "0", customerId: String = "0", addressId:String = "0", imageChecking = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        
        self.VM.VC2 = self
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToPrevious), name: Notification.Name.navigateToQueryList, object: nil)
        self.localization()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.verificationStatusLbl.isHidden = true
        self.verificationStatusTitle.isHidden = true
        NotificationCenter.default.post(name: .getProfileDetails, object: self)
        if self.strdata1 == "" {
            self.myProfileApi(UserID: self.userId)
        }
        
    }
    @objc func navigateToPrevious(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func localization(){
        
        self.accountHolderTF.placeholder = "Enter Account Holder Name".localiz()
        self.accounntHolderNameTitle.text = "AccountHolderName".localiz()
        
        self.accountNumberTF.placeholder = "Enter Account Number".localiz()
        self.accountNnumberLbl.text = "AccountNumber".localiz()
        
        self.confirmAccountNumberTF.placeholder = "Enter Confirm Account Number".localiz()
        self.connfirmAccountNumberLbl.text = "ConformNumber".localiz()
        
        self.bankNameTF.placeholder = "Enter Bank Name".localiz()
        self.bankNameLbl.text = "Bank Name".localiz()
        
        self.ifscCodeTF.placeholder = "Enter IFSC Code".localiz()
        self.ifscCodeLbl.text = "IFSC_Code".localiz()
        
        self.verificationStatusTitle.text = "Verification Status :".localiz()
        self.verificationStatusLbl.text = "verificationStatus".localiz()
        
    }
    
    @IBAction func selectUploadDoccumentBtn(_ sender: Any) {
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
    
    @IBAction func selectSubmitBtn(_ sender: UIButton) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "No Internet Connection".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
//            if self.emailTF == ""{
//                self.view.makeToast("Enter Email", duration: 2.0, position: .bottom)
//            }else
            if self.accountHolderTF.text!.count == 0 && self.accountNumberTF.text!.count == 0 && self.bankNameTF.text!.count == 0 && self.ifscCodeTF.text!.count == 0 && self.confirmAccountNumberTF.text!.count == 0 && self.strdata1 == "" {
//                let parameter = [
//                    "ActionType": "4",
//                    "ActorId": self.userId,
//                    "ObjCustomerJson": [
//                        "CustomerId": self.customerId,
//                        "MerchantId": "1",
//                        "FirstName": self.firstNameTF,
//                        "LastName": self.lastNameTF,
//                        "Mobile": self.customerMobileNumber,
//                        "Address1": self.addressTF,
//                        "StateId": self.stateId,
//                        "CityId": self.cityId,
//                        "Zip": self.pinCodeTF,
//                        "JDOB": self.doB,
//                        "AddressId": self.addressId,
//                        "AcountHolderName": self.accountHolderTF.text ?? "",
//                        "AccountNumber": self.accountNumberTF.text ?? "",
//                        "BankName": self.bankNameTF.text ?? "",
//                        "IFSCCode": self.ifscCodeTF.text ?? "",
//                        "BankPassbookImage": self.strdata1,
//                        "IsMobileRequest":1
//                    ]
//                ] as [String : Any]
//                print(parameter)
//                self.VM.flags = "BankDetails"
//                self.VM.updateProfileDetailsApi(parameter: parameter)
                
                self.view.makeToast("Please enter the valid feilds".localiz(), duration: 2.0, position: .bottom)
                
            }else{
                if self.accountHolderTF.text!.count != 0 || self.accountNumberTF.text!.count != 0 || self.bankNameTF.text!.count != 0 || self.ifscCodeTF.text!.count != 0 || self.confirmAccountNumberTF.text!.count != 0 || self.strdata1 != ""{
                    
                    if self.accountHolderTF.text!.count == 0 {
                        self.view.makeToast("Enter_Account_Holder_Name".localiz(), duration: 2.0, position: .bottom)
                    }else if self.accountNumberTF.text!.count == 0 {
                        self.view.makeToast("Enter account number".localiz(), duration: 2.0, position: .bottom)
                    }else if self.accountNumberTF.text!.count < 9 || self.accountNumberTF.text!.count > 16{
                        self.view.makeToast("Enter valid account number".localiz(), duration: 2.0, position: .bottom)
                    }else if self.confirmAccountNumberTF.text!.count < 9 || self.confirmAccountNumberTF.text!.count > 16{
                        self.view.makeToast("Enter confirm account number".localiz(), duration: 2.0, position: .bottom)
                    }else if self.accountNumberTF.text! != self.confirmAccountNumberTF.text!{
                        self.view.makeToast("Both account number should be same".localiz(), duration: 2.0, position: .bottom)
                    }else if self.ifscCodeTF.text!.count == 0{
                        self.view.makeToast("Enter IFSC Code".localiz(), duration: 2.0, position: .bottom)
                    }
//                    else if self.ifscCodeTF.text!.count != 11  {
//                        self.view.makeToast("Enter valid IFSC Code".localiz(), duration: 2.0, position: .bottom)
//                    }
                    else if self.strdata1 == ""{
                        self.view.makeToast("Attach Passbook Image".localiz(), duration: 2.0, position: .bottom)
                    }else{
                        let parameter = [
                            "ActionType": "4",
                            "ActorId": self.userId,
                            "ObjCustomerJson": [
                                "CustomerId": self.customerId,
                                "MerchantId": "1",
                                "FirstName": self.firstNameTF,
                                "LastName": self.lastNameTF,
                                "Mobile": self.customerMobileNumber,
                                "Address1": self.addressTF,
                                "StateId": self.stateId,
                                "CityId": self.cityId,
                                "Zip": self.pinCodeTF,
                                "JDOB": self.doB,
                                "AddressId": self.addressId,
                                "AcountHolderName": self.accountHolderTF.text ?? "",
                                "AccountNumber": self.accountNumberTF.text ?? "",
                                "BankName": self.bankNameTF.text ?? "",
                                "IFSCCode": self.ifscCodeTF.text ?? "",
                                "BankPassbookImage": self.strdata1,
                                "IsMobileRequest":1
                            ]
                        ] as [String : Any]
                        print(parameter)
                        self.VM.updateProfileDetailsApi(parameter: parameter)
                    }
                    
                }
                
            }
        }
      
    }
    func myProfileApi(UserID: String){
        let parameter = [
            "CustomerId": UserID,
            "ActionType": "6"
        ] as [String: Any]
        print(parameter)
        self.VM.myProfileListApi2(parameter: parameter)
        
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
        let alertVC = UIAlertController(title: "No Camera".localiz(), message: "Sorry no device".localiz(), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        self.uploadImage.image = selectedImage
        if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
            
            let imageData = selectedImage.resized(withPercentage: 0.1)
            let imageData1: NSData = imageData!.pngData()! as NSData
            let strBase64 = imageData1.base64EncodedString(options: .lineLength64Characters)
            self.uploadImageHeight.constant = 150
            self.imageChecking = "1"
            strdata1 = strBase64
        }
        picker.dismiss(animated: true, completion: nil)
//        dismiss(animated: true, completion: nil)
    }

//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
}
