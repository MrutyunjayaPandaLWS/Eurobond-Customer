//
//  EBC_ProductCatalogueVC.swift
//  EuroBond_Customer
//
//  Created by syed on 27/03/23.
//

import UIKit
import SDWebImage
import SafariServices
import PDFKit
import Toast_Swift
import LanguageManager_iOS
class EBC_ProductCatalogueVC: BaseViewController,UIDocumentInteractionControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, SFSafariViewControllerDelegate {

    @IBOutlet weak var productListingCV: UICollectionView!

    @IBOutlet var productCatalogeTitleLbl: UILabel!
    var VM = CatalogueBannerVM()
    
    let fileName = "EuroBond"
    var urlString = ""
    var imageName = ""
    var pdfUrl : URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.productListApi()
        productListingCV.delegate = self
        productListingCV.dataSource = self
        
        let collectionViewFLowLayout1 = UICollectionViewFlowLayout()
        collectionViewFLowLayout1.scrollDirection = .horizontal
        collectionViewFLowLayout1.minimumLineSpacing = 0
        collectionViewFLowLayout1.minimumInteritemSpacing = 0
        collectionViewFLowLayout1.estimatedItemSize = CGSize(width: 100, height: 30)
         self.productListingCV.collectionViewLayout = collectionViewFLowLayout1
    
        let collectionViewFLowLayout2 = UICollectionViewFlowLayout()
        collectionViewFLowLayout2.itemSize = CGSize(width: CGFloat(((self.view.bounds.width - 20) - (self.productListingCV.contentInset.left + self.productListingCV.contentInset.right)) / 2), height: 230)
        collectionViewFLowLayout2.minimumLineSpacing = 2.5
        collectionViewFLowLayout2.minimumInteritemSpacing = 2.5
         self.productListingCV.collectionViewLayout = collectionViewFLowLayout2
        langlocaliz()
    }
    
    
    func langlocaliz(){
        productCatalogeTitleLbl.text = "Product Catalogue".localiz()
    }
    
    
    
    @IBAction func selectBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func productListApi(){
        let parameter = [
            "ObjImageGallery": [
                   "AlbumCategoryID": 5
               ]
        ] as [String: Any]
        
        self.VM.productCatalogueList(parameter: parameter)
        
    }
    
    
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        guard let url = downloadTask.originalRequest?.url else{
//            return
//        }
//        let docsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
//        let distinationPath = docsPath.appendingPathComponent(url.lastPathComponent)
//        try? FileManager.default.removeItem(at: distinationPath)
//
//        do{
//            try FileManager.default.copyItem(at: location, to: distinationPath)
//            self.pdfUrl = distinationPath
//            print("File Downloding Location -",self.pdfUrl ?? "NOT")
//            self.view.makeToast("PDF has been downloded successfully !!", duration: 2.0, position: .bottom)
//        }catch let error {
//            print("Copy Error: \(error.localizedDescription)")
//        }
//
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.VM.productCatalgoueListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EBC_ProductCatalogueCVC", for: indexPath) as! EBC_ProductCatalogueCVC
        
        let productImage = String(self.VM.productCatalgoueListArray[indexPath.row].imageGalleryUrl ?? "").dropFirst(2)
        let urltoUse = String(PROMO_IMG1 + productImage).replacingOccurrences(of: " ", with: "%20")
        print(urltoUse)
        let urlt = URL(string: "\(urltoUse)")
        print(urlt)
        cell.productImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         let urlString = self.VM.productCatalgoueListArray[indexPath.row].actionImageUrl ?? ""
         let imageName = self.VM.productCatalgoueListArray[indexPath.row].displayName ?? ""
        //+ "\(randomNumberWith(digits: 6))"
//        savePdf(urlString:urlString , fileName: imageName)
        print(urlString)
//        guard let url = URL(string: urlString) else{return}
//        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
//        let downloadTask = urlSession.downloadTask(with: url)
//        downloadTask.resume()

       
        DispatchQueue.main.async {
            let urltoUse = String(urlString).replacingOccurrences(of: " ", with: "%20")
            print(urltoUse)
            let urlString = urltoUse
            let url = URL(string: urlString)
            let fileName = String((url!.lastPathComponent)) as NSString
            // Create destination URL
            let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
            let destinationFileUrl = documentsUrl.appendingPathComponent("\(fileName)")
            //Create URL to the source file you want to download
            let fileURL = URL(string: urlString)
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig)
            let request = URLRequest(url:fileURL!)
            let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                if let tempLocalUrl = tempLocalUrl, error == nil {
                    // Success
                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                        print("Successfully downloaded. Status code: \(statusCode)")
                    }
                    do {
                        try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                        do {
                            //Show UIActivityViewController to save the downloaded file
                            let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                            for indexx in 0..<contents.count {
                                if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
                                    let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
                                    self.present(activityViewController, animated: true, completion: nil)
                                   
                                }
                            }
                        }
                        catch (let err) {
                            print("error: \(err)")
                        }
                    } catch (let writeError) {
                        print("Error creating a file \(destinationFileUrl) : \(writeError)")
                    }
                } else {
                    print("Error took place while downloading a file. Error description: \(error?.localizedDescription ?? "")")
                }
            }
            task.resume()
//            let url = URL(string: urltoUse)
//            print(url)
//
//            let fileName = String((url!.lastPathComponent)) as NSString
//                // Create destination URL
//                let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
//                let destinationFileUrl = documentsUrl.appendingPathComponent("\(fileName)")
//
//            //Create URL to the source file you want to download
//            let fileURL = URL(string: urltoUse)
//            let sessionConfig = URLSessionConfiguration.default
//            let session = URLSession(configuration: sessionConfig)
//            let request = URLRequest(url:fileURL!)
//
//            let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
//                if let tempLocalUrl = tempLocalUrl, error == nil {
//                    // Success
//                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
//                        print("Successfully downloaded. Status code: \(statusCode)")
//                        let statusData = statusCode
//                        if statusData != 404{
//                            print("Successfully downloaded. Status code: \(statusCode)")
//                            self.view.makeToast("PDF has been downloded successfully !!", duration: 2.0, position: .bottom)
//                        }else{
//                            DispatchQueue.main.async {
//                                self.view.makeToast("Failed To Download PDF", duration: 2.0, position: .bottom)
//                                self.stopLoading()
//                            }
//                        }
//                    }
//                    do {
//                        DispatchQueue.main.async {
//                        self.stopLoading()
//                                }
//                            try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
//                            do {
//                                //Show UIActivityViewController to save the downloaded file
//                                let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
//                                for indexx in 0..<contents.count {
//                                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
//                                        self.startLoading()
//                                        if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
//                                            let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
//                                            activityViewController.modalTransitionStyle = .coverVertical
//                                            activityViewController.modalPresentationStyle = .overFullScreen
//                                            self.present(activityViewController, animated: true, completion: nil)
//
//                                        }
//                                    })
//                                    DispatchQueue.main.async {
//                                        self.stopLoading()
//                                    }
//                                }
//                            }
//                            catch (let err) {
//                                print("error: \(err)")
//                            }
//
//                    } catch (let writeError) {
//
//                        DispatchQueue.main.async {
//                            print("Error creating a file \(destinationFileUrl) : \(writeError)")
//                            self.view.makeToast("Already, this PDF has been downloded.", duration: 2.0, position: .bottom)
//                            self.stopLoading()
//                        }
//
//
//                    }
//                } else {
//                    print("Error took place while downloading a file. Error description: \(error?.localizedDescription ?? "")")
//                }
//            }
//            task.resume()

            self.stopLoading()
        }
    }
        
//func randomNumberWith(digits:Int) -> Int {
//        let min = Int(pow(Double(10), Double(digits-1))) - 1
//        let max = Int(pow(Double(10), Double(digits))) - 1
//        return Int(Range(uncheckedBounds: (min, max)))
//    }
//
//}
//extension Int {
//    init(_ range: Range<Int> ) {
//        let delta = range.startIndex < 0 ? abs(range.startIndex) : 0
//        let min = UInt32(range.startIndex + delta)
//        let max = UInt32(range.endIndex   + delta)
//        self.init(Int(min + arc4random_uniform(max - min)) - delta)
//    }
}
