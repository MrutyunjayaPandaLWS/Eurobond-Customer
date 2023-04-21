//
//  EBC_CreatenewQueryVC.swift
//  EuroBond_Customer
//
//  Created by admin on 31/03/23.
//

import UIKit
import Photos
import Toast_Swift
class EBC_CreatenewQueryVC: BaseViewController, DropdownDelegate {
    func didTappedGenderBtn(_ vc: EBC_DropDownVC) {}
    func didtappedStateListBtn(_ vc: EBC_DropDownVC) {}
    func didtappedCityListBtn(_ vc: EBC_DropDownVC) {}
    func didtappedLanguageListBtn(_ vc: EBC_DropDownVC) {}
    func didTappedQueryListBtn(_ vc: EBC_DropDownVC) {
        self.helpTopicName = vc.queryTopicName
        self.helpTopicId = vc.queryTopicId
        self.selectTopicLbl.text = vc.queryTopicName
        
    }
    @IBOutlet weak var queryDetailsHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var querySummaryHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var browseImageBtn: GradientButton!
    @IBOutlet weak var queryImage: UIImageView!
    @IBOutlet weak var queryDetailsTitle: UILabel!
    @IBOutlet weak var lodgeQueryTitleLbl: UILabel!
    @IBOutlet weak var selectTopicLbl: UILabel!
    @IBOutlet weak var selectTopicTitleLbl: UILabel!
    @IBOutlet weak var createQueryInfoLbl: UILabel!
    @IBOutlet weak var titleVC: UILabel!
    @IBOutlet weak var querySummaryTV: UITextView!
    @IBOutlet weak var queryDetailsTV: UITextView!
    var isFrom = 2
    var helpTopicId = -1
    var helpTopicName = ""
    var querySummaryDetails = ""
    var selectedCodesArray = [String]()

    let picker = UIImagePickerController()
    var strBase64 = ""
    var fileType = ""
    var VM = EBC_QuerySubmissionVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        picker.delegate = self
        querySummaryTV.delegate = self
        queryDetailsTV.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToPrevious), name: Notification.Name.navigateToQueryList, object: nil)
        if self.isFrom == 21{
            self.querySummaryTV.isEditable = false
            for code in self.selectedCodesArray{
                self.querySummaryDetails = self.querySummaryDetails + "\(code)"
            }
            print(self.selectedCodesArray.count, "Selected Codes Array count")
            var str2 = self.querySummaryDetails
            str2.insert(separator: ", ", every: 12)
            print(str2)
            self.querySummaryTV.text = String(str2)
            self.querySummaryHeightConstraints.constant = self.querySummaryTV.contentSize.height
        }
    }
    
    @objc func navigateToPrevious(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        if self.isFrom != 21{
        self.navigationController?.popViewController(animated: true)
        }else{
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func selectTopicBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_DropDownVC") as! EBC_DropDownVC
        vc.flags = "Query"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func selectBrowseBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Any Option", message: "", preferredStyle: .actionSheet)
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
    
    @IBAction func selectQueryBtn(_ sender: Any) {
        
        if self.helpTopicId == -1{
            self.view.makeToast("Select Query Topic", duration: 2.0, position: .center)
        }else if self.querySummaryTV.text!.count == 0{
            self.view.makeToast("Enter query summary..", duration: 2.0, position: .center)
        }else if self.queryDetailsTV.text!.count == 0{
            self.view.makeToast("Enter query details..", duration: 2.0, position: .center)
        }else{
            let parameter = [
                "ActionType": "0",
                "ActorId": self.userId,
                "HelpTopicID": self.helpTopicId,
                "IsQueryFromMobile": "true",
                "ImageUrl": self.strBase64,
                "LoyaltyID": self.loyaltyId,
                "Mobile": self.customerMobileNumber!,
                "QueryDetails": self.queryDetailsTV.text ?? "",
                "QuerySummary": self.querySummaryTV.text ?? "",
                "QuerySummaryMultipleQuery": "",
                "SourceType": "3"
            ] as [String: Any]
            print(parameter)
            self.VM.newQuerySubmissionApi(parameter: parameter)
        }
        
    }
    
}
extension EBC_CreatenewQueryVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
                    let alertVC = UIAlertController(title: "HR Johnson need to access camera Gallery", message: "", preferredStyle: .alert)
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
        DispatchQueue.main.async { [self] in
            guard let selectedImage = info[.originalImage] as? UIImage else {
                return
            }
            let imageData = selectedImage.resized(withPercentage: 0.1)
            let imageData1: NSData = imageData!.pngData()! as NSData
            self.queryImage.image = selectedImage
            self.fileType = "JPG"
            self.strBase64 = imageData1.base64EncodedString(options: .lineLength64Characters)
            //self.attachedImgHeightConstraint.constant = 150
//            self.mainViewHeightConstraint.constant = 560
            picker.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
extension EBC_CreatenewQueryVC: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == querySummaryTV{
            self.querySummaryHeightConstraints.constant = self.querySummaryTV.contentSize.height
        }else{
            self.queryDetailsHeightConstraints.constant = self.queryDetailsTV.contentSize.height
        }
        return true
    }
}
extension StringProtocol where Self: RangeReplaceableCollection {

    mutating func insert<S: StringProtocol>(separator: S, every n: Int) {
        for index in indices.every(n: n).dropFirst().reversed() {
            insert(contentsOf: separator, at: index)
        }
    }

    func inserting<S: StringProtocol>(separator: S, every n: Int) -> Self {
        .init(unfoldSubSequences(limitedTo: n).joined(separator: separator))
    }
    
}
extension Collection {

    func unfoldSubSequences(limitedTo maxLength: Int) -> UnfoldSequence<SubSequence,Index> {
        sequence(state: startIndex) { start in
            guard start < endIndex else { return nil }
            let end = index(start, offsetBy: maxLength, limitedBy: endIndex) ?? endIndex
            defer { start = end }
            return self[start..<end]
        }
    }

    func every(n: Int) -> UnfoldSequence<Element,Index> {
        sequence(state: startIndex) { index in
            guard index < endIndex else { return nil }
            defer { formIndex(&index, offsetBy: n, limitedBy: endIndex) }
            return self[index]
        }
    }

    var pairs: [SubSequence] { .init(unfoldSubSequences(limitedTo: 2)) }
}

