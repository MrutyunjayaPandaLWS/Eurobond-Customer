//
//  ProjectCatalogeDetailsVM.swift
//  EuroBond_Customer
//
//  Created by Arokia-M3 on 03/05/23.
//

import UIKit

class ProjectCatalogeDetailsVM {
    
    
    weak var VC: SearchProjectDetailsVC?
    var requestAPIs = RestAPI_Requests()
    var projectCatalogeDetailsArray = [LstProductListDetails2]()
    
    func projectCatalogeDetailsAPI(parameter: JSON){
            DispatchQueue.main.async {
                self.VC?.startLoading()
            }
            self.requestAPIs.projectCatalogeDetailsAPI(parameters: parameter) { (result, error) in
                if error == nil{
                    if result != nil{
                        DispatchQueue.main.async {
                            self.VC?.stopLoading()
                            self.projectCatalogeDetailsArray = result?.lstProductListDetails ?? []
                        print(self.projectCatalogeDetailsArray.count, "My Project Count")
                        if self.projectCatalogeDetailsArray.count != 0 {
                            self.VC?.collectionViewProjectDetails.isHidden = false
                            self.VC?.collectionViewProjectDetails.reloadData()
                            //let gestureRecognizer = UITapGestureRecognizer(target: self.VC.self, action: #selector(self.VC!.didTap))
                        }else{
                            self.VC?.collectionViewProjectDetails.isHidden = true
                        }
                        
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
