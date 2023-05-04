//
//  EBC_Signup2VC.swift
//  EuroBond_Customer
//
//  Created by syed on 18/03/23.
//

import UIKit
import Photos
import QCropper
import Toast_Swift

class EBC_Signup2VC: BaseViewController, UITextFieldDelegate{
    

    @IBOutlet weak var gstImage: UIImageView!
    @IBOutlet weak var panImage: UIImageView!
    @IBOutlet weak var clickHerebtn: UIButton!
    @IBOutlet weak var alreadyAccountLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var gstFileFormatLbl: UILabel!
    @IBOutlet weak var gstDoccumentLbl: UILabel!
    @IBOutlet weak var gstTF: UITextField!
    @IBOutlet weak var gstLbl: UILabel!
    @IBOutlet weak var panCradLbl: UILabel!
    @IBOutlet weak var panNumberTF: UITextField!
    @IBOutlet weak var pannumberLbl: UILabel!
    @IBOutlet weak var signupInfoLbl: UILabel!
    @IBOutlet weak var signUpTitleLbl: UILabel!
    
    var selectedStateID = -1
    var selectedStateName = ""
    var referralCode = ""
    var selectedCityName = ""
    var selectedCityId = -1
    
    var selectedGender = ""
    var selectedGenderId = -1
    
    var languageName = ""
    var languageId = -1
    var selectedDOB = ""
    
    var pincode = ""
    var firstNames = ""
    var lastName = ""
    var mobile = ""
    var address = ""
    var email = ""
    var selectTitle = ""
    
    let picker = UIImagePickerController()
    var strBase64PAN = ""
    var strBase64GST = ""
    var itsFrom = ""
    var VM = EBC_SignUpVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.picker.delegate = self
        self.gstTF.delegate = self
        self.panNumberTF.delegate = self
        self.panNumberTF.keyboardType = .asciiCapable
        self.gstTF.keyboardType = .asciiCapable
        NotificationCenter.default.addObserver(self, selector: #selector(registrationSubmission), name: Notification.Name.registrationSubmission, object: nil)
    }
    
    @objc func registrationSubmission(){
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: EBC_Login1VC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }

//    @IBAction func panValideTFAct(_ sender: Any) {
//        if panNumberTF.text?.count == 10{
//            let parameter = [
//                "PanNumber":"\(self.panNumberTF.text ?? "")"
//            ]
//            print(parameter,"PanNumber")
//            self.VM.pancardVerifyApi(parameters: parameter)
//        }else{
//            self.view.makeToast("Enter valid Pan Number", duration: 2.0, position: .bottom)
//        }
//    }
    
    
    @IBAction func selectpanFrontPageBtn(_ sender: UIButton) {
        self.itsFrom = "PAN"
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
    
    @IBAction func selectGstUploadBtn(_ sender: UIButton) {
        self.itsFrom = "GST"
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
    
    
    @IBAction func selectSubmitBtn(_ sender: Any) {
        
        if self.panNumberTF.text?.count == 0{
            self.view.makeToast("Enter PAN number", duration: 2.0, position: .bottom)
        }else if self.panNumberTF.text?.count != 10{
            self.view.makeToast("Enter valid PAN number", duration: 2.0, position: .bottom)
        }else if self.panNumberTF.text?.count != 10{
            self.view.makeToast("Enter valid PAN number", duration: 2.0, position: .bottom)
        }else if strBase64PAN == ""{
            self.view.makeToast("Attach PAN Image", duration: 2.0, position: .bottom)
        }
        //        else if self.gstTF.text?.count == 0 {
        //            self.view.makeToast("Enter GST number", duration: 2.0, position: .bottom)
        //         }else if self.gstTF.text?.count != 15{
        //                self.view.makeToast("Enter valid GST number", duration: 2.0, position: .bottom)
        //    }
        else{
            
            let parameterJSON = [
                "actiontype": "0",
                "lstidentityinfo": [
                    [
                        "identityid": "5", //hardcoded
                        "identityno": self.panNumberTF.text ?? "",
                        "identitytype": "6", //hardcoded
                        "IdentityDocument": self.strBase64PAN
                    ]
                ],
                "objcustomer": [
                    "Title": self.selectTitle,
                    "FirstName": self.firstNames,
                    "LastName": self.lastName,
                    "Address1": self.address,
                    "customeremail": self.email,
                    "CustomerMobile": self.mobile,
                    "CustomerCityId": self.selectedCityId,
                    "CustomerStateId": self.selectedStateID,
                    "CustomerZip": self.pincode,
                    "IsActive": "1", //hardcoded
                    "MerchantId": "1", //hardcoded
                    "ReferrerCode": self.referralCode,
                    "RegistrationSource": "2", // for IOS=>2, Android=3
                    "CustomerTypeId": "69",//hardcoded
                    "DOB": self.selectedDOB,
                    "LanguageId": self.languageId,
                    "Gender": self.selectedGender
                ],
                "ObjCustomerOfficalInfo": [
                    "OfficialGSTNumber": "\(self.gstTF.text ?? "")",
                    "GSTDocument": self.strBase64GST
                ]
            ] as [String: Any]
            print(parameterJSON)
            self.VM.registrationSubmission(parameter: parameterJSON)
            
            
        }
        
    }
    
    @IBAction func selectClickHereBtn(_ sender: UIButton) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: EBC_Login1VC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
////      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
////      let compSepByCharInSet = string.components(separatedBy: aSet)
////      let numberFiltered = compSepByCharInSet.joined(separator: "")
//
//        self.panNumberTF.text = self.panNumberTF.text?.uppercased()
//
//      if string == numberFiltered {
//          let currentText = self.panNumberTF.text ?? ""
//        guard let stringRange = Range(range, in: currentText) else { return false }
//        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
//        return updatedText.count <= 10
//      } else {
//        return false
//      }
//    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//         if string.isEmpty {
//             return true
//         }
//         let alphaNumericRegEx = "[a-zA-Z0-9]"
//         let predicate = NSPredicate(format:"SELF MATCHES %@", alphaNumericRegEx)
//         return predicate.evaluate(with: string)
//    }
    
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        self.panNumberTF.text = self.panNumberTF.text?.uppercased()
//        if textField == panNumberTF{
//            let currentCharacterCount = panNumberTF.text?.count ?? 0
//                   if (range.length + range.location > currentCharacterCount){
//                       return false
//                   }
//                   let newLength = currentCharacterCount + string.count - range.length
//                   return newLength <= 10
//        }
//        return true
//    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//          let aSet = NSCharacterSet(charactersIn:"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz").inverted
//          let compSepByCharInSet = string.components(separatedBy: aSet)
//          let numberFiltered = compSepByCharInSet.joined(separator: "")
//
//          if string == numberFiltered {
//              let currentText = self.mobileTF.text ?? ""
//            guard let stringRange = Range(range, in: currentText) else { return false }
//            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
//            return updatedText.count <= 10
//          } else {
//            return false
//          }
//        }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.panNumberTF.text = self.panNumberTF.text?.uppercased()
        self.gstTF.text = self.gstTF.text?.uppercased()
        
        
        
        if textField == panNumberTF{
            //"[a-zA-Z0-9]"
            let aSet = NSCharacterSet(charactersIn:"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            
            let currentCharacterCount = panNumberTF.text?.count ?? 0
                   if (range.length + range.location > currentCharacterCount){
                       return false
                   }
                   let newLength = currentCharacterCount + string.count - range.length
                   return newLength <= 10
            //return predicate.evaluate(with: string)
        }else  if textField == gstTF{
            
            let aSet = NSCharacterSet(charactersIn:"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            
            let currentCharacterCount = gstTF.text?.count ?? 0
                   if (range.length + range.location > currentCharacterCount){
                       return false
                   }
                   let newLength = currentCharacterCount + string.count - range.length
                   return newLength <= 15
        }
        
        return true
    }
    
    
    
}
extension EBC_Signup2VC: UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropperViewControllerDelegate {
    func openGallery() {
        PHPhotoLibrary.requestAuthorization({
            (newStatus) in
            if newStatus ==  PHAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    self.picker.allowsEditing = false
                    self.picker.sourceType = .savedPhotosAlbum
                    self.picker.mediaTypes = ["public.image"]
                    self.present(self.picker, animated: true, completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    let alertVC = UIAlertController(title: "Need Gallary access", message: "Allow Gallery access", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        DispatchQueue.main.async {
                            UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }
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
                                self.picker.sourceType = .camera
                                self.picker.mediaTypes = ["public.image"]
                                self.present(self.picker,animated: true,completion: nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let alertVC = UIAlertController(title: "Need Camera Access", message: "Allow", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                            }
                            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                UIAlertAction in
                            }
                            alertVC.addAction(okAction)
                            alertVC.addAction(cancelAction)
                            self.present(alertVC, animated: true, completion: nil)
                            
                        }
                    }
                }} else {
                    DispatchQueue.main.async {
                        self.noCamera()
                    }
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
                DispatchQueue.main.async {
                    let alertVC = UIAlertController(title: "Kashev need to access camera Gallery", message: "", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                    let cancelAction = UIAlertAction(title: "Disallow", style: UIAlertAction.Style.cancel) {
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
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry no device", preferredStyle: .alert)
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
            let cropper = CropperViewController(originalImage: image)
            cropper.delegate = self
            if self.itsFrom == "PAN"{
                self.panImage.image = image
                self.strBase64PAN = imageData1.base64EncodedString(options: .lineLength64Characters)
            }else{
                self.gstImage.image = image
                self.strBase64GST = imageData1.base64EncodedString(options: .lineLength64Characters)
            }
            
            
            picker.dismiss(animated: true)
            //self.dismiss(animated: true, completion: nil)
            self.present(cropper, animated: true, completion: nil)
            
            
        }
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func cropperDidConfirm(_ cropper: CropperViewController, state: CropperState?) {
        cropper.dismiss(animated: true, completion: nil)

        if let state = state,
           let image = cropper.originalImage.cropped(withCropperState: state) {
            print(image,"imageDD")
            let imageData = image.resized(withPercentage: 0.1)
            let imageData1: NSData = imageData!.pngData()! as NSData
            if self.itsFrom == "PAN"{
                self.panImage.image = image
            }else{
                self.gstImage.image = image
            }
        } else {
            print("Something went wrong")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
//extension MyProfileandBankDetailsVC: CropperViewControllerDelegate {
//
//    func cropperDidConfirm(_ cropper: CropperViewController, state: CropperState?) {
//    cropper.dismiss(animated: true, completion: nil)
// 
//    if let state = state,
//        let image = cropper.originalImage.cropped(withCropperState: state) {
//        print(image,"imageDD")
//        let imageData = image.resized(withPercentage: 0.1)
//        let imageData1: NSData = imageData!.pngData()! as NSData
//        self.myProfileImg.image = image
//        self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
//        print(strdata1,"kdjgjhdsj")
//        let parameters = [
//            "ActorId": "\(UserDefaults.standard.string(forKey: "UserID") ?? "")",
//            "ObjCustomerJson": [
//                "DisplayImage": strdata1,
//                "LoyaltyId": "\(UserDefaults.standard.string(forKey: "LoyaltyId") ?? "")"
//            ]
//        ]as [String : Any]
//        print(parameters)
//        self.VM.profileImageUpdate(parameter: parameters)
//    } else {
//        print("Something went wrong")
//    }
//    self.dismiss(animated: true, completion: nil)
//    }
//}
