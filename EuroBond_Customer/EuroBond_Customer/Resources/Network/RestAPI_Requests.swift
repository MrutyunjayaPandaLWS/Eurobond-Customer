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
    //MARK: - MY CART LIST
    func myCartList(parameters: JSON, completion: @escaping (MyCartModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: myCartList_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(MyCartModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
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
    //MARK: - REMOVE DREAM GIFT
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
    func language_Api(parameters: JSON, completion: @escaping (LanguageModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: language_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(LanguageModels?.self, from: data as! Data)
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
}

