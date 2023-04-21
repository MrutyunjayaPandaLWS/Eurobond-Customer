//
//  RestAPI_Requests.swift
//  Millers_Customer_App
//
//  Created by ArokiaIT on 10/30/20.
//

import UIKit

typealias JSON = [String: Any]

class RestAPI_Requests {
    private let client = WebClient(baseUrl: baseURl)
    
    func myEarningListApi(parameters: JSON, completion: @escaping (MyEarningModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: myEarning_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(MyEarningModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // MARK : - CUSTOMER LOGIN
    func registrationSubmissionApi(parameters: JSON, completion: @escaping (RegistrationModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: registerSubmission_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(RegistrationModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // MARK : - CUSTOMER LOGIN
    func login_API(parameters: JSON, completion: @escaping (LoginSubmissionModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: loginSubmission_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(LoginSubmissionModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    func logintOtp_Post_API(parameters: JSON, completion: @escaping (LoginOTPModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: getOTP_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(LoginOTPModel?.self, from: data as! Data)
                    print(result1)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func dashboard_API(parameters: JSON, completion: @escaping (DashBordModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: dashboard_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(DashBordModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func dashboardBanner_API(parameters: JSON, completion: @escaping (DashboardBannerModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: dashboardBanner_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(DashboardBannerModel?.self, from: data as! Data)
                    completion(result1, nil)
                }

            }catch{
                completion(nil, error)
            }
        }
    }
    
    
    // MARK: - GAMIFICATION SUBMIT API
    func gamificationSubmit_Post_API(parameters: JSON, completion: @escaping (GamificationResultModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: UpdateGamificationTransaction_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(GamificationResultModels?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // MARK: - GAMIFICATION API
    func gamificationListing_Post_API(parameters: JSON, completion: @escaping (GamificationModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: GetGamificationTransaction_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(GamificationModels?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    
    //MARK: - SAVED UPLOAD/ SCANNED CODES
    func submitCodesApi(parameters: JSON, completion: @escaping (ScannedandUploadCodesModels?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: savedCodes_URLMethod, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(ScannedandUploadCodesModels?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
    }
    
    //MARK: - OTP
    func otp_Post_API(parameters: JSON, completion: @escaping (OTPModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: getOTP_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(OTPModels?.self, from: data as! Data)
                    print(result1)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    //MARK: - REDEMPTION SUBMISSION
    
    func redemptionSubmission(parameters: JSON, completion: @escaping (RedemptionSubmission?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: redemptionSubmission_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(RedemptionSubmission?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    //MARK: - SEND SUCCESS MESSAGE
    
    func sendSuccessMessage(parameters: JSON, completion: @escaping (SendSuccessModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: sendSuccessURL, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(SendSuccessModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
//    //MARK: - MY CART LIST
//    func myCartList(parameters: JSON, completion: @escaping (MyCartModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: myCartList_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(MyCartModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
    //MARK: - Redemption OTP
    
    func redemptionOTP(parameters: JSON, completion: @escaping (RedemptionOTPModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: getOTP_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(RedemptionOTPModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    //MARK: - SEND SMS
    
    func sendSMSApi(parameters: JSON, completion: @escaping (SendSMSModel?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: sendSMS_URL, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(SendSMSModel?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    //MARK: -  USER ISACTIVE
    func userIsActive(parameters: JSON, completion: @escaping (UserStatusModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: userStatus_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(UserStatusModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    //MARK: - MY PROFILE DETAILS
    func myProfile(parameters: JSON, completion: @escaping (MyProfileModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: getCustomerDetailsMobileApp_UrlMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(MyProfileModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    //MARK: - REMOVE CART COUNT
    func removeProduct(parameters: JSON, completion: @escaping (RemoveCartModel?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: updateMyCart_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(RemoveCartModel?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    
    
    //MARK: - INCREASE CART COUNT
    func increaseCartCount(parameters: JSON, completion: @escaping (IncreaseProductModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: updateMyCart_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(IncreaseProductModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
//    MARK: -LANGUAGE API
    func language_Api(parameters: JSON, completion: @escaping (LanguageModel?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: language_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(LanguageModel?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
//    MARK: - STATE LIST API
    func stateList_Api(parameters: JSON, completion: @escaping (StateListModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: stateList_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(StateListModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    
//    MARK: - City LIST API
    func cityList_Api(parameters: JSON, completion: @escaping (CityListModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: cityList_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(CityListModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }

    // Sync Code List
    
    func syncCodeListApi(parameters: JSON, completion: @escaping (SyncStatusModel?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: getQRCodeStatus, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(SyncStatusModel?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    //MyProfile
    
    func myProfileListApi(parameters: JSON, completion: @escaping(MyProfileModels?, Error?) -> ()) -> URLSessionDataTask?{
        return client.load(path: myProfileURLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 = try JSONDecoder().decode(MyProfileModels?.self, from: data as! Data)
                    completion(result1, nil)
                }
                
            }catch{
                completion(nil, error)
            }
        }
        
    }
    
    // Help Topic List
    
    func helpTopicListApi(parameters: JSON, completion: @escaping(HelpTopicListModel?, Error?) -> ()) -> URLSessionDataTask?{
        return client.load(path: getHelpTopics, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 = try JSONDecoder().decode(HelpTopicListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                
            }catch{
                completion(nil, error)
            }
        }
        
    }
    
    func querySubmissionApi(parameters: JSON, completion: @escaping(NewQuerySubmissionModel?, Error?) -> ()) -> URLSessionDataTask?{
        return client.load(path: saveCustomerQueryTicket, method: .post, params: parameters) { data, error in
            do{
                
                if data != nil{
                    let result1 = try JSONDecoder().decode(NewQuerySubmissionModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func queryListApi(parameters: JSON, completion: @escaping(QueryListModel?, Error?) -> ()) -> URLSessionDataTask?{
        return client.load(path: saveCustomerQueryTicket, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 = try JSONDecoder().decode(QueryListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    func newQueryTicket_API(parameters: JSON, completion: @escaping (QueryListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: saveCustomerQueryTicket, method: .post, params: parameters) { data, error in
            do{
//                print(data)
                if data != nil{
                    let result1 =  try JSONDecoder().decode(QueryListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // MARK : - CHAT QUERY DETAILS
    func chatQuery_Post_API(parameters: JSON, completion: @escaping (ChatDetailsModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: getQueryResponseInformation, method: .post, params: parameters) { data, error in
            do{
//                print(data)
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ChatDetailsModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // Update Profile
    func updateProfileApi(parameters: JSON, completion: @escaping (UpdateProfileModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: updateProfileURLMethod, method: .post, params: parameters) { data, error in
            do{
//                print(data)
                if data != nil{
                    let result1 =  try JSONDecoder().decode(UpdateProfileModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //ImageSavingAPI
    func imageSavingAPI(parameters: JSON, completion: @escaping (SideMenuModelClass?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: UpdateCustomerProfileMobileApp, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(SideMenuModelClass?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    func schemeandOffersApi(parameters: JSON, completion: @escaping (SchemeandOffersModel?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: schemeandOffersURL, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(SchemeandOffersModel?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    
    func referandEarnSubmissionApi(parameters: JSON, completion: @escaping (ReferandEarnModel?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: referandEarnURL, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(ReferandEarnModel?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }

    func productCategoryListApi(parameters: JSON, completion: @escaping (CategoryListModel?, Error?) -> ()) ->
    URLSessionDataTask?{
        return client.load(path: productCategoryListURL, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(CategoryListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func productCatalogueListApi(parameters: JSON, completion: @escaping (CatalogueListModel?, Error?) -> ()) ->
    URLSessionDataTask?{
        return client.load(path: productCatalogueListURL, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(CatalogueListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
//    func updateCartApi(parameters: JSON, completion: @escaping (UpdateCartModel?, Error?) -> ()) ->
//    URLSessionDataTask?{
//        return client.load(path: updateMyCart_URLMethod, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(UpdateCartModel?.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
    
    func myCartListApi(parameters: JSON, completion: @escaping (MyCartListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: myCartListURL, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(MyCartListModel.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func redemptionPlannerList(parameters: JSON, completion: @escaping (RedemptionPlannerDetailsModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: redemptionPlannerDetails_MethodName, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(RedemptionPlannerDetailsModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //Remove Redemption Planner
    
    func removeRedemptionPlannerList(parameters: JSON, completion: @escaping (RemoveRedemptionPlannerList?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: removeRedemptionPlanner_MethodName, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(RemoveRedemptionPlannerList.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    //Add To Planner
    
    func addToPlannerApi(parameters: JSON, completion: @escaping (AddToPlannerModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: addToPlanner_MethodName, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(AddToPlannerModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //Planner Added Or Not
    
    func plannerAddedOrNotApi(parameters: JSON, completion: @escaping (PlannerAddedOrNotModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: plannerAddedOrNot_MethodName, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(PlannerAddedOrNotModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // Cart Count List
    
    func cartCountApi(parameters: JSON, completion: @escaping (CartCountModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: cartCount_MethodName, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(CartCountModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    func myredemptionDetails(parameters: JSON, completion: @escaping (MyRedemptionDetailsModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: myredemptionDetails_URLMethodName, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(MyRedemptionDetailsModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //Add TO Cart
    
    func addToCartApi(parameters: JSON, completion: @escaping (AddToCartModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: addToCart_MethodName, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(AddToCartModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //productCatalogueListURL
    func evoucherListApi(parameters: JSON, completion: @escaping (EvoucherListModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: productCatalogueListURL, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(EvoucherListModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func redeemVoucher(parameters: JSON, completion: @escaping (VoucherRedemptionModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: voucherRedeem_URLMethodName, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(VoucherRedemptionModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    func TCDetails(parameters: JSON, completion: @escaping (TermsandConditonModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: tcMethodname, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(TermsandConditonModel.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //Save Redemption OTP
    
    func getRedemptionOTP(parameters: JSON, completion: @escaping (LoginOTPModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: saveLoginOTP_MethodName, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(LoginOTPModel.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func productSubmission_Post_API(parameters: JSON, completion: @escaping (SubmitProductModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: productSubmit_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(SubmitProductModels?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    func myRedemptionListApi(parameters: JSON, completion: @escaping (MyRedemptionModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: myRedemption_MethodName, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(MyRedemptionModels?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func cataloguedBanner_API(parameters: JSON, completion: @escaping (ProductCatalogueDetailsModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: dashboardBanner_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ProductCatalogueDetailsModel?.self, from: data as! Data)
                    completion(result1, nil)
                }

            }catch{
                completion(nil, error)
            }
        }
    }
    
    
    // MARK : - MY DREAM GIFT LISTING
     func myDreamGiftList(parameters: JSON, completion: @escaping (MyDreamGiftModels?, Error?) -> ()) -> URLSessionDataTask? {
             return client.load(path: myDreamGiftList_URLMethod, method: .post, params: parameters) { data, error in
                 do{
                     if data != nil{
                         let result1 =  try JSONDecoder().decode(MyDreamGiftModels?.self, from: data as! Data)
                         completion(result1, nil)
                     }
                 }catch{
                     completion(nil, error)
                 }
             }
         }
    //REMOVE DREAM GIFT
    
    func removeDreamGifts(parameters: JSON, completion: @escaping (RemoveGiftModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: removeDreamGift_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(RemoveGiftModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    //MY DREAM GIFT DETAILS
    
    func myDreamGiftDetails(parameters: JSON, completion: @escaping (DetailsGiftModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: myDreamGiftList_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(DetailsGiftModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    
    func myassistantListApi(parameters: JSON, completion: @escaping (MyAssistantModel?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: myAssistant, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(MyAssistantModel?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    func myassistantRegisterSubmissionApi(parameters: JSON, completion: @escaping (AssistantRegisterModel?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: registerSubmission_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(AssistantRegisterModel?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    //RegisterAccountDeactivateModel
    
    func registerAccountDeactivateApi(parameters: JSON, completion: @escaping (RegisterAccountDeactivateModel?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: customerAccountDelete, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(RegisterAccountDeactivateModel?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    //loginSubmission_URLMethod
    
    func myAssistantUpdatePasswordApi(parameters: JSON, completion: @escaping (UpdatePasswordModel?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: loginSubmission_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(UpdatePasswordModel?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    func notificationList(parameters: JSON, completion: @escaping (NotificationModels?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: historyNotification, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(NotificationModels?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
    }
}

