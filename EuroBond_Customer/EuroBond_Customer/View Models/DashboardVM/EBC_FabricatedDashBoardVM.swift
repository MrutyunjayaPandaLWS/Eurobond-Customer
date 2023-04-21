//
//  EBC_FabricatedDashBoardVM.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 13/04/2023.
//

import Foundation
import UIKit
import Kingfisher
class EBC_FabricatedDashBoardVM{
   
    weak var VC:EBC_Dashboard_2_VC?
    var requestAPIs = RestAPI_Requests()
    var bannerArray = [ObjImageGalleryList]()
    func dashboardBannerApi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.sourceArray.removeAll()
        self.VC?.offerimgArray.removeAll()
        
        self.requestAPIs.dashboardBanner_API(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.offerimgArray = result?.objImageGalleryList ?? []
                        self.bannerArray = result?.objImageGalleryList ?? []
                        print(self.bannerArray.count, "Banner Image")
                        if self.VC?.offerimgArray.count == 0{
                            self.VC?.ImageSetups()
                            let gestureRecognizer = UITapGestureRecognizer(target: self.VC.self, action: #selector(self.VC!.didTap))
                            self.VC!.imageSlideShow.addGestureRecognizer(gestureRecognizer)
                        }else{
                            self.VC?.ImageSetups()
                            let gestureRecognizer = UITapGestureRecognizer(target: self.VC.self, action: #selector(self.VC!.didTap))
                            self.VC!.imageSlideShow.addGestureRecognizer(gestureRecognizer)
                         
                        }
                    }
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }
        }
    }
    func dashboardApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.dashboard_API(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                DispatchQueue.main.async {
                   let dashboardDetails = result?.objCustomerDashboardList ?? []
                    if dashboardDetails.count != 0 {
                        
                        UserDefaults.standard.setValue(result?.objCustomerDashboardList?[0].memberSince, forKey: "MemberSince")
                        print(result?.objCustomerDashboardList?[0].memberSince ?? "", "Membersince")
                        print(result?.objCustomerDashboardList?[0].notificationCount ?? 0, "NotificationCount")
                        print(result?.objCustomerDashboardList?[0].redeemablePointsBalance ?? "", "totalpoints")
//                        self.VC?.totalBalanceLbl.text = "\(result?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0)"
                        UserDefaults.standard.setValue(result?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0, forKey: "RedeemablePointBalance")
                        UserDefaults.standard.synchronize()
                        self.VC?.memberSinceTitleLbl.text = "\(result?.objCustomerDashboardList?[0].memberSince ?? "")"
                        if result?.objCustomerDashboardList?[0].notificationCount ?? 0 != 0 {
                            self.VC?.notificationBadgesLbl.isHidden = false
                            self.VC?.notificationBadgesLbl.text = "\(result?.objCustomerDashboardList?[0].notificationCount ?? 0)"
                        }else{
                            self.VC?.notificationBadgesLbl.isHidden = true
                        }
                        
                    }
                    
                    let customerFeedbakcJSON = result?.lstCustomerFeedBackJsonApi ?? []
                    if customerFeedbakcJSON.count != 0 || customerFeedbakcJSON.isEmpty == false{
                        
                        if result?.lstCustomerFeedBackJsonApi?[0].customerStatus ?? 0 != 1{
                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ForgetPwdSuccessVC") as! KC_ForgetPwdSuccessVC
                            vc.itsComeFrom = "ACCOUNTDEACTIVATE"
                            vc.modalTransitionStyle = .coverVertical
                            vc.modalPresentationStyle = .overFullScreen
                            self.VC!.present(vc, animated: true)
                        }
                        
                        UserDefaults.standard.setValue(result?.lstCustomerFeedBackJsonApi?[0].customerType ?? "", forKey: "customerType")
                        UserDefaults.standard.setValue(result?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? -1, forKey: "customerTypeId")
                        print(result?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? -1)
                        UserDefaults.standard.setValue(result?.lstCustomerFeedBackJsonApi?[0].customerId, forKey: "customerId")
                            UserDefaults.standard.setValue(result?.lstCustomerFeedBackJsonApi?[0].firstName, forKey: "FirstName")
                           
                            UserDefaults.standard.setValue(result?.lstCustomerFeedBackJsonApi?[0].loyaltyId, forKey: "LoyaltyId")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].merchantEmail ?? "", forKey: "MerchantEmail")
                            print(result?.lstCustomerFeedBackJsonApi?[0].verifiedStatus ?? "")
                        UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].merchantMobile ?? "", forKey: "MerchantMobile")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].verifiedStatus ?? "4", forKey: "verificationStatus")

//                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].customerMobile ?? "", forKey: "Mobile")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].firstName ?? "", forKey: "FirstName")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].lastName ?? "", forKey: "LastName")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].customerEmail ?? "", forKey: "CustomerEmail")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].merchantId ?? "", forKey: "MerchantID")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].referralCode ?? "", forKey: "ReferralCode")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].company ?? "", forKey: "company")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].customerMobile ?? "", forKey: "CustomerMobileNumber")
                        
                        UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].cityID ?? "", forKey: "cityID")
                        UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].cityName ?? "", forKey: "cityName")
                        
                        UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].customerImage ?? "", forKey: "customerImage")
                        let imageurl = "\(result?.lstCustomerFeedBackJsonApi?[0].customerImage ?? "")".dropFirst(1)
                        let imageData = imageurl.split(separator: "~")
                        if imageData.count >= 2 {
                            print(imageData[1],"jdsnjkdn")
                            let totalImgURL = PROMO_IMG1 + (imageData[1])
                            print(totalImgURL, "Total Image URL")
                            self.VC?.profileImage.kf.setImage(with: URL(string: totalImgURL),placeholder: UIImage(named: "ic_default_img"))
                        }else{
                            let totalImgURL = PROMO_IMG1 + imageurl
                            print(totalImgURL, "Total Image URL")
                            self.VC?.profileImage.kf.setImage(with: URL(string: totalImgURL),placeholder: UIImage(named: "ic_default_img"))
                        }
                            UserDefaults.standard.synchronize()
                        self.VC?.userNameLbl.text = result?.lstCustomerFeedBackJsonApi?[0].firstName ?? ""
                         self.VC?.membershipIDTitleLbl.text = result?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? ""
                       
                    }else{
                        if result?.lstCustomerFeedBackJsonApi?[0].customerStatus ?? 0 != 1{
                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ForgetPwdSuccessVC") as! KC_ForgetPwdSuccessVC
                            vc.itsComeFrom = "ACCOUNTDEACTIVATE"
                            vc.modalTransitionStyle = .coverVertical
                            vc.modalPresentationStyle = .overFullScreen
                            self.VC!.present(vc, animated: true)
                        }
                    }
                 //   self.VC?.categoryCollectionView.reloadData()
                }
                    DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    }
                }else{
                    DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                self.VC?.stopLoading()
                }
            }
        }
    }
    
}
