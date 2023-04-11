//
//  ScannedCodes_VC.swift
//  centuryDemo
//
//  Created by Arokia-M3 on 16/03/22.
//

import UIKit
import CoreData
import Lottie

class ScannedCodes_VC: BaseViewController, RemoveCodeDelegate{
    func removeScannedCode(_ cell: ScannedCode_TVC) {
        guard let tappedIndexPath = scannedCodesTableView.indexPath(for: cell) else {return}
        let photosToRemove = self.codeLIST[tappedIndexPath.row]
        persistanceservice.context.delete(photosToRemove)
        persistanceservice.saveContext()
        fetchDetails()
        self.scannedCodesTableView.reloadData()
        
    }
    
    @IBOutlet var scannedCodesTableView: UITableView!
    @IBOutlet weak var titleView: GradientView!
    @IBOutlet weak var totalCount: GradientLabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var codeCountView: UIView!
    @IBOutlet weak var noDataFound: AnimationView!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var upload: GradientButton!
    var codeLIST:Array = [ScanCodeSTORE]()
    
    
    private var animationView: AnimationView?
    
    var newproductArray: [[String:Any]] = []
    var parameterJSON:JSON?
    
    var catalogueList = ""
    var addressString : String = ""
    var country = ""
    var city = ""
    var address = ""
    var pincode = ""
    var itsFrom = ""
    var codeIsSubmitted = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.noDataFound.isHidden = true
        self.totalCount.cornerRadius = totalCount.frame.width/2
        titleView.clipsToBounds = true
        titleView.layer.cornerRadius = 24
        titleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 24
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        fetchDetails()
        self.scannedCodesTableView.delegate = self
        self.scannedCodesTableView.dataSource = self
        languagelocalization()
    }
    
    override func touchesBegan(_ touchscreen: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touchscreen.first
        if touch?.view != self.presentingViewController
        {
            if itsFrom == "Scanner"{
                self.dismiss(animated: true){
                    self.fetchDetails()
                    NotificationCenter.default.post(name: .restartScan, object: nil)
                }
            }else{
                self.fetchDetails()
                self.dismiss(animated: true){
                NotificationCenter.default.post(name: .restartScan, object: nil)
                }
            }

        }
    }
    
    func languagelocalization(){
       // if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.header.text = "My QR Codes"
            self.upload.setTitle("Submit", for: .normal)
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//            self.header.text = "मेरे क्यूआर कोड"
//            self.upload.setTitle("जमा करें", for: .normal)
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//            self.header.text = "আমার QR কোড"
//            self.upload.setTitle("জমা দিন", for: .normal)
//        }else{
//            self.header.text = "నా QR కోడ్‌లు"
//            self.upload.setTitle("సమర్పించు", for: .normal)
//        }
    }
    
    func playAnimation(){
        animationView = .init(name: "lf30_editor_jh47f7lt")
        animationView!.frame = noDataFound.bounds
          // 3. Set animation content mode
        animationView!.contentMode = .scaleAspectFit
          // 4. Set animation loop mode
        animationView!.loopMode = .loop
          // 5. Adjust animation speed
        animationView!.animationSpeed = 0.5
        noDataFound.addSubview(animationView!)
          // 6. Play animation
        animationView!.play()

    }
    
    
    
    
    
    @IBAction func submitBTN(_ sender: Any) {
        if self.codeLIST.count == 0 {
            //if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                let alertController = UIAlertController(title: "Submit without scan Upload QR", message: "Please scan/upload QR code", preferredStyle: .alert)

                // Create the actions
                let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                    self.dismiss(animated: true){
                        NotificationCenter.default.post(name: .restartScan, object: nil)
                    }

                }
                alertController.addAction(okAction)

                // Present the controller
                self.present(alertController, animated: true, completion: nil)
//             }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                 let alertController = UIAlertController(title: "स्कैन के बिना सबमिट करें QR अपलोड करें", message: "कृपया QR कोड स्कैन/अपलोड करें", preferredStyle: .alert)
//
//                 // Create the actions
//                 let okAction = UIAlertAction(title: "ठीक", style: UIAlertAction.Style.default) {
//                     UIAlertAction in
//                     NSLog("OK Pressed")
//                     self.dismiss(animated: true){
//                         NotificationCenter.default.post(name: .restartScan, object: nil)
//                     }
//                 }
//                 alertController.addAction(okAction)
//
//                 // Present the controller
//                 self.present(alertController, animated: true, completion: nil)
//            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                let alertController = UIAlertController(title: "স্ক্যান ছাড়াই জমা দিন QR আপলোড করুন", message: "অনুগ্রহ করে QR কোড স্ক্যান/আপলোড করুন", preferredStyle: .alert)
//
//                // Create the actions
//                let okAction = UIAlertAction(title: "ওকে", style: UIAlertAction.Style.default) {
//                    UIAlertAction in
//                    NSLog("OK Pressed")
//                    self.dismiss(animated: true){
//                        NotificationCenter.default.post(name: .restartScan, object: nil)
//                    }
//
//                }
//                alertController.addAction(okAction)
//
//                // Present the controller
//                self.present(alertController, animated: true, completion: nil)
//            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                let alertController = UIAlertController(title: "స్కాన్ లేకుండా సమర్పించండి అప్‌లోడ్ QR", message: "దయచేసి QR కోడ్‌ని స్కాన్/అప్‌లోడ్ చేయండి", preferredStyle: .alert)
//
//                // Create the actions
//                let okAction = UIAlertAction(title: "సరే", style: UIAlertAction.Style.default) {
//                    UIAlertAction in
//                    NSLog("OK Pressed")
//                    self.dismiss(animated: true){
//                        NotificationCenter.default.post(name: .restartScan, object: nil)
//                    }
//
//                }
//                alertController.addAction(okAction)
//
//                // Present the controller
//                self.present(alertController, animated: true, completion: nil)
//              }
           
        }else{
            self.startLoading()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                NotificationCenter.default.post(name: .CodeSubmission, object: nil)
                     
            }
        )}
       
    }
    @IBAction func closeBTN(_ sender: Any) {
        if itsFrom == "Scanner"{
            self.dismiss(animated: true){
                self.fetchDetails()
                NotificationCenter.default.post(name: .restartScan, object: nil)
            }
        }else{
            self.fetchDetails()
            self.dismiss(animated: true, completion: nil)
        }
       
    }
    
    
    func fetchDetails(){
        self.codeLIST.removeAll()
        let fetchRequest:NSFetchRequest<ScanCodeSTORE> = ScanCodeSTORE.fetchRequest()
        do{
            self.codeLIST = try persistanceservice.context.fetch(fetchRequest)
            print(self.codeLIST.count, "Count")

            if self.codeLIST.count != 0{
                self.codeCountView.isHidden = false
                self.totalCount.text = "\(self.codeLIST.count)"
                self.scannedCodesTableView.isHidden = false
                self.noDataFound.isHidden = true
            }else{
                self.codeCountView.isHidden = true
                self.scannedCodesTableView.isHidden = true
                self.noDataFound.isHidden = false
                playAnimation()
            }

        }catch{
            print("error while fetching data")
        }
    }
    
}
extension ScannedCodes_VC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.codeLIST.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScannedCode_TVC", for: indexPath) as! ScannedCode_TVC
        cell.delegate = self
        cell.codeLabel.text = self.codeLIST[indexPath.row].code ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
