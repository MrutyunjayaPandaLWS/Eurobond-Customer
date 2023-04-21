//
//  EBC_MyAssistantVM.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 20/04/2023.
//

import Foundation

class EBC_MyAssistantVM{
    
    weak var VC: EBC_MyAssistantVC?
    var requestAPIs = RestAPI_Requests()
    
    var myAssistantArrayList = [LstCustParentChildMapping]()
    
    func myAssistantList(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.myassistantListApi(parameters: parameter) { (result, error) in
        
            if error == nil{
                
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        let myAssitantList = result?.lstCustParentChildMapping ?? []
                        if myAssitantList.isEmpty == false{
                            self.myAssistantArrayList += myAssitantList
                            self.VC?.noofelements = self.myAssistantArrayList.count
                            print(self.myAssistantArrayList.count)
                            if self.myAssistantArrayList.count != 0 {
                                self.VC?.myAssistantTV.isHidden = false
                                self.VC?.noDataFoundLbl.isHidden = true
                                self.VC?.myAssistantTV.reloadData()
                            }else{
                                self.VC?.myAssistantTV.isHidden = true
                                self.VC?.noDataFoundLbl.isHidden = false
                            }
                        }else{
                            if self.VC!.startIndex > 1{
                                self.VC?.startIndex = 1
                                self.VC?.noofelements = 9
                            }else{
                                self.VC?.myAssistantTV.isHidden = true
                                self.VC?.noDataFoundLbl.isHidden = false
                            }
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result, "Result")
                    }
                }
                
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    print(error, "Error")
                }
            }
        }
    }
    
    func deactivateExecutiveApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }

        self.requestAPIs.registerAccountDeactivateApi(parameters: parameter) { (result, error) in
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        
                        if result?.isActive ?? false == false || result?.returnMessage ?? "" == "1"{
                            
                            self.VC?.popView.isHidden = false
                            self.VC?.accountStatus.text = "Account is deactivated"
                            DispatchQueue.main.asyncAfter(deadline: .now()+3.0, execute: {
                                self.VC?.popView.isHidden = true
                                self.myAssistantArrayList.removeAll()
                                self.VC?.startIndex = 1
                                self.VC?.selectedFromDate = ""
                                self.VC?.selectedToDate = ""
                                self.VC?.myAssistantApi(StartIndex: self.VC!.startIndex, searchText: "", FromDate: self.VC!.selectedFromDate, ToDate: self.VC!.selectedToDate)
                            })
                            
                            
                        }else if result?.isActive ?? false == true || result?.returnMessage ?? "" == "1"{
                            self.VC?.popView.isHidden = false
                            self.VC?.accountStatus.text = "Account is activated"
                            DispatchQueue.main.asyncAfter(deadline: .now()+3.0, execute: {
                                self.VC?.popView.isHidden = true
                                self.myAssistantArrayList.removeAll()
                                self.VC?.startIndex = 1
                                self.VC?.selectedFromDate = ""
                                self.VC?.selectedToDate = ""
                                self.VC?.myAssistantApi(StartIndex: self.VC!.startIndex, searchText: "", FromDate: self.VC!.selectedFromDate, ToDate: self.VC!.selectedToDate)
                            })
                           
                            
                        }else{
                            self.VC!.view.makeToast("Something went wrong! Try again later!", duration: 2.0, position: .bottom)
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        print(error)
                        self.VC?.stopLoading()
                    }
                }
            }
        }
        
    }
}
