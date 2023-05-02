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
class EBC_ProductCatalogueVC: BaseViewController,UIDocumentInteractionControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, SFSafariViewControllerDelegate {

    @IBOutlet weak var productListingCV: UICollectionView!

    var VM = CatalogueBannerVM()
    
    
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
        print(urlString)
        let urltoUse = String(urlString).replacingOccurrences(of: " ", with: "%20")
        print(urltoUse)
        let url = URL(string: urltoUse)
        print(url)
        let fileName = String((url!.lastPathComponent)) as NSString
        // Create destination URL
        let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
        let destinationFileUrl = documentsUrl.appendingPathComponent("\(fileName)")
        //Create URL to the source file you want to download
        let fileURL = URL(string: urltoUse)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL!)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                    self.view.makeToast("PDF has been downloded successfully !!", duration: 2.0, position: .bottom)
                }
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
//
                } catch (let writeError) {
                    
                    DispatchQueue.main.async {
                        print("Error creating a file \(destinationFileUrl) : \(writeError)")
                        self.view.makeToast("Already, this PDF has been downloded.", duration: 2.0, position: .bottom)
                        self.stopLoading()
                    }
                   

                }
            } else {
                print("Error took place while downloading a file. Error description: \(error?.localizedDescription ?? "")")
            }
        }
        task.resume()
       
        self.stopLoading()
    }
    
    
}
