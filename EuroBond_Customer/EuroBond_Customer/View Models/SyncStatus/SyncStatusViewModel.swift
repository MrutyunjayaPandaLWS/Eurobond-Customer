//
//  SyncStatusViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class SyncStatusViewModel{
    weak var VC:CodeStatusListVC?
    var requestAPIs = RestAPI_Requests()
    var syncCodeArray = [QrUsegereport]()
    
    func syncStatusListingAPI(parameters: JSON){
        self.VC?.codesCollectionsArray.removeAll()
        self.VC?.selectedDataArray.removeAll()
        self.VC?.startLoading()
        self.requestAPIs.syncCodeListApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    self.syncCodeArray = result?.qrUsegereport ?? []
                    print(self.syncCodeArray.count, "- Count")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        if self.syncCodeArray.count != 0{
                            for data in self.syncCodeArray{
                                self.VC?.selectedDataArray.append(SelectedCodeModels(uplodedCode: data.scratchCode, codeStatus: data.usedRemarks, codeUploadedDate: data.bankingDate, isSelected: 0))
                                self.VC?.codesCollectionsArray.append(SelectedCodeModels(uplodedCode: data.scratchCode, codeStatus: data.usedRemarks, codeUploadedDate: data.bankingDate, isSelected: 0))
                            }
                            self.VC?.codeStatusListTableView.isHidden = false
                            self.VC?.nodatafound.isHidden = true
                            
                        }else{
                            self.VC?.nodatafound.isHidden = false
                            self.VC?.codeStatusListTableView.isHidden = true
                        }
                        self.VC?.codeStatusListTableView.reloadData()
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
