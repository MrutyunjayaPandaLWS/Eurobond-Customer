//
//  HistoryNotificationsViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class HistoryNotificationsViewModel{
    
    weak var VC:HistoryNotificationsViewController?
    var requestAPIs = RestAPI_Requests()
    var notificationListArray = [LstPushHistoryJson]()
    
    func notificationListApi(parameters: JSON, completion: @escaping (NotificationModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.notificationList(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
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

}
