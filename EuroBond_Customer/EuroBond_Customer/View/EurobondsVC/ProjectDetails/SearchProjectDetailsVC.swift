//
//  SearchProjectDetailsVC.swift
//  EuroBond_Customer
//
//  Created by Arokia-M3 on 03/05/23.
//

import UIKit
import ImageSlideshow
import LanguageManager_iOS

class SearchProjectDetailsVC: BaseViewController {
    
    @IBOutlet var brandNaemTitleLbl: UILabel!
    @IBOutlet var brandNameLbl: UILabel!
    @IBOutlet var colorTitleLbl: UILabel!
    @IBOutlet var colorDataLbl: UILabel!
    @IBOutlet var colorCodeLbl: UILabel!
    @IBOutlet var colorCodeDataLbl: UILabel!
    @IBOutlet var collectionViewProjectDetails: UICollectionView!
    @IBOutlet var imageZoom: UIView!
//    @IBOutlet var collectionViewImage: UIImageView!
    
    @IBOutlet var scrollviewToZoom: UIScrollView!
    

    @IBOutlet var collectionImageView: UIImageView!
    
    
    
    
    var brand = ""
    var colorData = ""
    var colorCode = ""
    var productId = ""
    var brandId = ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var VM = ProjectCatalogeDetailsVM()
    var sourceArray = [AlamofireSource]()
    //let scrollview = UIScrollView.init(frame: self.view.bounds)
    let pageIndicator = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.imageZoom.isHidden = true
        self.collectionViewProjectDetails.delegate = self
        self.collectionViewProjectDetails.dataSource = self
        self.brandNameLbl.text = self.brand
        self.colorDataLbl.text = self.colorData
        self.colorCodeDataLbl.text = self.colorCode
        projecDetailsAPI()
        //imageZoomView.pageIndicator = pageIndicator
            
        setUpScrollView()
        let collectionViewFLowLayout1 = UICollectionViewFlowLayout()
        collectionViewFLowLayout1.scrollDirection = .horizontal
        collectionViewFLowLayout1.minimumLineSpacing = 0
        collectionViewFLowLayout1.minimumInteritemSpacing = 0
        collectionViewFLowLayout1.estimatedItemSize = CGSize(width: 100, height: 30)
         self.collectionViewProjectDetails.collectionViewLayout = collectionViewFLowLayout1
    
        let collectionViewFLowLayout2 = UICollectionViewFlowLayout()
        collectionViewFLowLayout2.itemSize = CGSize(width: CGFloat(((self.view.bounds.width - 20) - (self.collectionViewProjectDetails.contentInset.left + self.collectionViewProjectDetails.contentInset.right)) / 2), height: 200)
        collectionViewFLowLayout2.minimumLineSpacing = 2.5
        collectionViewFLowLayout2.minimumInteritemSpacing = 2.5
         self.collectionViewProjectDetails.collectionViewLayout = collectionViewFLowLayout2
        
        
    }
    
    
    func setUpScrollView(){
        scrollviewToZoom.delegate = self
        scrollviewToZoom.minimumZoomScale = 1.0
        scrollviewToZoom.maximumZoomScale = 10.0
    }

    func langLocaliz(){
        self.brandNaemTitleLbl.text = "Project Cataloge".localiz()
    }
    
    @IBAction func backBTN(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func projecDetailsAPI(){
        let parameter = [
            "ActorId": "\(userID)",
            "ActionType": "6",
            "Brand_id": "\(brandId)",//brand id
            "ProductId": "\(productId)"//color id
        ] as [String: Any]
        print(parameter)
        self.VM.projectCatalogeDetailsAPI(parameter: parameter)
       
    }


//    func ImageSetups(){
//        self.sourceArray.removeAll()
//        if self.VM.projectCatalogeDetailsArray.count > 0 {
////            for image in self.VM.projectCatalogeDetailsArray {
////                print("\(PROMO_IMG1)\(image.imageGalleryUrl ?? ""), sdafasf")
////                let imageURL = image.imageGalleryUrl ?? ""
////                let filteredURLArray = imageURL.dropFirst(1)
////                let replaceString = "\(PROMO_IMG1)\(filteredURLArray)".replacingOccurrences(of: " ", with: "%20")
////                print(replaceString)
////                self.sourceArray.append(AlamofireSource(urlString: "\(replaceString)", placeholder: UIImage(named: "ic_default_img"))!)
////            }
//            imageZoomView.setImageInputs(self.sourceArray)
//            imageZoomView.slideshowInterval = 3.0
//            imageZoomView.zoomEnabled = true
//            imageZoomView.contentScaleMode = .scaleToFill
////            bannerImage.pageControl.currentPageIndicatorTintColor = UIColor(red: 230/255, green: 27/255, blue: 34/255, alpha: 1)
////            bannerImage.pageControl.pageIndicatorTintColor = UIColor.lightGray
//        }else{
////            imageSlideShow.setImageInputs([
////                ImageSource(image: UIImage(named: "dashboardIMG222")!)
////            ])
//        }
//    }
//    @objc func didTap() {
//        if self.VM.projectCatalogeDetailsArray.count > 0 {
//            imageZoomView.presentFullScreenController(from: self)
//        }
//    }
    
//      var vWidth = self.view.frame.width
//      var vHeight = self.view.frame.height
//
//       var scrollImg: UIScrollView = UIScrollView()
//       scrollImg.delegate = self
//       scrollImg.frame = CGRectMake(0, 0, vWidth!, vHeight!)
//       scrollImg.backgroundColor = UIColor(red: 90, green: 90, blue: 90, alpha: 0.90)
//       scrollImg.alwaysBounceVertical = false
//       scrollImg.alwaysBounceHorizontal = false
//       scrollImg.showsVerticalScrollIndicator = true
//       scrollImg.flashScrollIndicators()
//
//       scrollImg.minimumZoomScale = 1.0
//       scrollImg.maximumZoomScale = 10.0
//
//       defaultView!.addSubview(scrollImg)
//
//       imageView!.layer.cornerRadius = 11.0
//       imageView!.clipsToBounds = false
//       scrollImg.addSubview(imageView!)

    
    
}


extension SearchProjectDetailsVC : UICollectionViewDelegate,UICollectionViewDataSource, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return VM.projectCatalogeDetailsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCatalogeCVC", for: indexPath) as! ProjectCatalogeCVC

        let imageURL = self.VM.projectCatalogeDetailsArray[indexPath.row].productImage ?? ""
        let splitDataa = imageURL.dropFirst(1)
        let url = URL(string: "\(PROMO_IMG1)" + "\(splitDataa)")
        print(url)
        cell.projectImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        imageZoom.isHidden = false
        let imageURL = self.VM.projectCatalogeDetailsArray[indexPath.row].productImage ?? ""
        let splitDataa = imageURL.dropFirst(1)
        let url = URL(string: "\(PROMO_IMG1)" + "\(splitDataa)")
        collectionImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "Logo"))
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.collectionImageView
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.collectionImageView
    }
}
