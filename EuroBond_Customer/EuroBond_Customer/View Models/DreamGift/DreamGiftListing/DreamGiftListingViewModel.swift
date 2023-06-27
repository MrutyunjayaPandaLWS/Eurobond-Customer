//
//  DreamGiftListingViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//


import UIKit
import LanguageManager_iOS

class DreamGiftListingViewModel: popUpDelegate1{
    func popupAlertDidTap1(_ vc: PopupAlertOne_VC) {}
    

    weak var VC: DreamGiftListingViewController?
    var requestAPIs = RestAPI_Requests()
    var myDreamGiftListArray = [LstDreamGift]()
    var myCartListArray = [CatalogueSaveCartDetailListResponse1]()
    
    func myDreamGiftLists(parameters: JSON){
        self.VC?.startLoading()
        self.requestAPIs.myDreamGiftList(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                            self.myDreamGiftListArray = result?.lstDreamGift ?? []
                            
                            if self.myDreamGiftListArray.count != 0{
                                UserDefaults.standard.set(self.myDreamGiftListArray[0].is_Redeemable ?? 0, forKey: "DreamGiftIsRedeemable")
                                UserDefaults.standard.synchronize()
                                self.VC?.dreamGifttableView.isHidden = false
                                self.VC?.noDataFound.isHidden = true
                                self.VC?.dreamGifttableView.reloadData()
                            }else{
                                self.VC?.dreamGifttableView.isHidden = true
                                self.VC?.noDataFound.isHidden = false
                                self.VC?.dreamGifttableView.reloadData()

                            }
                           
                        self.VC?.stopLoading()
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }

        }
    }
    
    }
    
    func removeDreamGift(parameters: JSON){
        self.VC?.startLoading()
        self.requestAPIs.removeDreamGifts(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                            let result = result?.returnValue ?? 0
                            print(result)
                            if result == 1 {
                                DispatchQueue.main.async{
                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                    vc!.delegate = self
                                    vc!.titleInfo = ""
                                    vc!.itsComeFrom = "DreamGift"
                                    vc!.descriptionInfo = "Dream Gift has been removed successfully".localiz()
                                    vc!.modalPresentationStyle = .overCurrentContext
                                    vc!.modalTransitionStyle = .crossDissolve
                                    self.VC!.present(vc!, animated: true, completion: nil)
                                }
                                
                            }else{
                                DispatchQueue.main.async{
                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                    vc!.delegate = self
                                    vc!.titleInfo = ""
                                    vc!.descriptionInfo = "Dream Gift has been removed failed".localiz()
                                    vc!.modalPresentationStyle = .overCurrentContext
                                    vc!.modalTransitionStyle = .crossDissolve
                                    self.VC!.present(vc!, animated: true, completion: nil)
                                }
                            }
                        self.VC?.stopLoading()
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }

        }
    }
    
    }
    func addToCart(parameters: JSON, completion: @escaping (AddToCartModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.addToCartApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                        
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }

        }
    }
    
    }
    
//    func myCartList(parameters: JSON, completion: @escaping (MyCartModels?) -> ()){
//        self.VC?.startLoading()
//        self.requestAPIs.myCartListApi(parameters: parameters) { (result, error) in
//            if error == nil{
//                if result != nil {
//                    DispatchQueue.main.async {
//                        completion(result)
//                        
//                    }
//                } else {
//                    print("No Response")
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                    }
//                }
//            }else{
//                print("ERROR_Login \(error)")
//                DispatchQueue.main.async {
//                    self.VC?.stopLoading()
//                }
//
//        }
//    }
//    
//    }
    
}
