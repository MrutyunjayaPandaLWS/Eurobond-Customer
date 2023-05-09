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
import QCropper
import LanguageManager_iOS
import Kingfisher
class MyProfileandBankDetailsVC: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var giveMissedCallLbl: UILabel!
    @IBOutlet weak var facingIssueLbl: UILabel!
    @IBOutlet weak var myprofile1: UILabel!
    @IBOutlet weak var myProfileImg: UIImageView!
    @IBOutlet weak var personalDetailsLbl: UILabel!
    @IBOutlet weak var personalDetailsLblColor: UILabel!
    @IBOutlet weak var bankDetailsLbl: UILabel!
    @IBOutlet weak var bankDetailsColor: UILabel!
    @IBOutlet weak var editBTN: UIButton!
    
    var container: ContainerViewController!
    let mobilenumber = UserDefaults.standard.string(forKey: "CUSTOMERMOBILE") ?? ""
    let custEmail = UserDefaults.standard.string(forKey: "CUSTOMEReMAIL") ?? ""
    let loyaltyID = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let picker = UIImagePickerController()
    var strdata1 = ""
    var reachability = Reach()
    var bankDetails = ""
    var accountStatus = ""
    var isComeFrom = "None"
    var allowToEditProfile = "1"
    
    var VM = EBC_MyProfileUpdateVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        
        let imageurl = "\(UserDefaults.standard.string(forKey: "customerImage") ?? "")".dropFirst(1)
        let imageData = imageurl.split(separator: "~")
        if imageData.count >= 2 {
            print(imageData[1],"jdsnjkdn")
            let totalImgURL = PROMO_IMG1 + (imageData[1])
            print(totalImgURL, "Total Image URL")
            self.myProfileImg.kf.setImage(with: URL(string: totalImgURL),placeholder: UIImage(named: "ic_default_img"))
        }else{
            let totalImgURL = PROMO_IMG1 + imageurl
        print(totalImgURL, "Total Image URL")
        self.myProfileImg.kf.setImage(with: URL(string: totalImgURL),placeholder: UIImage(named: "ic_default_img"))
            }
        
        //self.myProfileImg.sd_setImage(with: URL(string: PROMO_IMG + "\(customerImage)"), placeholderImage: UIImage(named: "icons8-test-account-96"))
            picker.delegate = self
            self.personalDetailsLbl.textColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
            self.personalDetailsLblColor.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
            self.bankDetailsLbl.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.bankDetailsColor.backgroundColor = #colorLiteral(red: 0.7709710002, green: 0.8818235993, blue: 0.944216311, alpha: 1)
            container.segueIdentifierReceivedFromParent("myProfileDetails")
        langloc()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }
    
    func langloc(){
        self.myprofile1.text = "My Profile".localiz()
        self.personalDetailsLbl.text = "Personal Details".localiz()
        self.facingIssueLbl.text = "Facing any issues".localiz()
        self.giveMissedCallLbl.text = "Give a Missed Call".localiz()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "myProfile"{
            self.container = segue.destination as? ContainerViewController
        }
    }
    
    @IBAction func selectGiveMissedCallBtn(_ sender: Any) {
            if let phoneCallURL = URL(string: "tel://\(+918875509444)") {
                
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                    
                }
            }
    }
    @IBAction func selectProfileImageEditBtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
            }
        }else{
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

   
    @IBAction func backBTn(_ sender: Any) {
        print(self.isComeFrom, "BankButton")
        if self.isComeFrom == "BankDetails"{
            self.isComeFrom = "none"
            self.allowToEditProfile = "1"
            self.personalDetailsLbl.textColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
            self.personalDetailsLblColor.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
            self.bankDetailsLbl.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.bankDetailsColor.backgroundColor = #colorLiteral(red: 0.7709710002, green: 0.8818235993, blue: 0.944216311, alpha: 1)
            self.editBTN.isHidden = false
            container.segueIdentifierReceivedFromParent("myProfileDetails")

        }else if self.isComeFrom == "bank" || self.isComeFrom == "Catalogue" || self.isComeFrom == "None1"{
            self.isComeFrom = "none"
            self.allowToEditProfile = "1"
            self.personalDetailsLbl.textColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
            self.personalDetailsLblColor.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
            self.bankDetailsLbl.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.bankDetailsColor.backgroundColor = #colorLiteral(red: 0.7709710002, green: 0.8818235993, blue: 0.944216311, alpha: 1)
            self.editBTN.isHidden = false
            container.segueIdentifierReceivedFromParent("myProfileDetails")
        }else{
           //self.ApicallingMethod()
           self.allowToEditProfile = "1"
           self.navigationController?.popViewController(animated: true)
       }
    }
  
    
    @IBAction func personalDetailsBTN(_ sender: Any) {
            self.allowToEditProfile = "1"
            self.personalDetailsLbl.textColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
            self.personalDetailsLblColor.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.5098039216, blue: 0.7529411765, alpha: 1)
            self.bankDetailsLbl.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.bankDetailsColor.backgroundColor = #colorLiteral(red: 0.7709710002, green: 0.8818235993, blue: 0.944216311, alpha: 1)
            container.segueIdentifierReceivedFromParent("myProfileDetails")
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
                
                    let alertVC = UIAlertController(title: "EuroBond Application need to Access the Gallery", message: "Allow Gallery Access", preferredStyle: .alert)
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
                        
                        let alertVC = UIAlertController(title: "EuroBond Application need to Access the Camera", message: "Allow Camera Access", preferredStyle: .alert)
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
     func noCamera(){
             let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
             let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
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
                    self.myProfileImg.image = image
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
extension MyProfileandBankDetailsVC: CropperViewControllerDelegate {

    func cropperDidConfirm(_ cropper: CropperViewController, state: CropperState?) {
    cropper.dismiss(animated: true, completion: nil)
 
    if let state = state,
        let image = cropper.originalImage.cropped(withCropperState: state) {
        print(image,"imageDD")
        let imageData = image.resized(withPercentage: 0.1)
        let imageData1: NSData = imageData!.pngData()! as NSData
        self.myProfileImg.image = image
        self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
        print(strdata1,"kdjgjhdsj")
        
        //{"ActionType":"159","ObjCustomerJson":{"DisplayImage":"",}}
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
