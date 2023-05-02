//
//  RedemptionCatalogueListVM.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/19/22.
//

import UIKit
import LanguageManager_iOS
class HR_RedemptionCatalogueListVM:  popUpAlertDelegate {
    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    weak var VC: HR_RedemptionCatalogueVC?
    var requestAPIs = RestAPI_Requests()
    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    
    var categoryListArray = [ObjCatalogueCategoryListJson]()
    var productCategoryList = [ObjCatalogueCategoryListJson]()
    var brandArray = [ObjCatalogueList]()
    var catalgoueListArray = [ObjCatalogueList]()
    var filteredArray = [ObjCatalogueList]()
    var myCartListArray = [CatalogueSaveCartDetailListResponse]()
    var sumOfProductsCount = 0
    var plannerListArray = [ObjCatalogueList2]()
    var productCategoryListArray = [ProductCateogryModels]()
    var parameters : JSON?
    func getMycartList(){
        self.VC?.startLoading()
        let parameters = [
            "ActionType":"2",
            "LoyaltyID":"\(loyaltyId)"
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.myCartListApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.myCartListArray = result?.catalogueSaveCartDetailListResponse ?? []
                        self.sumOfProductsCount = Int(result?.catalogueSaveCartDetailListResponse?[0].sumOfTotalPointsRequired ?? 0)
                        print(self.myCartListArray.count, "My cart Count")
                       // self.VC?.productsDetailCollectionView.reloadData()
                        self.productCategoryApi()
                        
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
    
    
    func productCategoryApi(){
        self.VC?.startLoading()
        let parameters = [
                  "ActionType": "1",
                    "ActorId": "\(userID)",
                    "IsActive": 1
            
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.productCategoryListApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.productCategoryListArray.removeAll()
                        self.categoryListArray = result?.objCatalogueCategoryListJson ?? []
                        print(self.categoryListArray.count,"Product Category Count")
                        
                        if self.categoryListArray.count != 0{
                            self.productCategoryListArray.append((ProductCateogryModels(productCategoryId: "-1", productCategorName: "ALL", isSelected: 0)))
                            for item in self.categoryListArray{
                                self.productCategoryListArray.append(ProductCateogryModels(productCategoryId: "\(item.catogoryId ?? 0)", productCategorName: item.catogoryName ?? "", isSelected: 0))
                            }
                            self.VC?.productCategoryCollectionView.isHidden = false
                            
                            self.VC?.noDataFoundCategoryList.isHidden = true
                            self.VC?.productCategoryCollectionView.reloadData()
                            self.catalogueListApi(searchText: self.VC?.searchProductTF.text ?? "", startIndex: self.VC!.startIndex)
                        }else{
                            self.VC?.productCategoryCollectionView.isHidden = true
                            
                            self.VC?.noDataFoundCategoryList.isHidden = false
                        }
                        
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.noDataFoundCategoryList.isHidden = false
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
    func catalogueListApi(searchText: String, startIndex: Int){
        self.VC?.startLoading()
        self.parameters?.removeAll()
        if self.VC?.itsFrom == "Search"{
            self.parameters = [
                "ActionType": "6",
                "ActorId": "\(self.userID)",
                  "ObjCatalogueDetails": [
                      "MerchantId": 1,
                      "CatogoryId": -1,
                      "CatalogueType": 1,
                      "MultipleRedIds": ""
                  ],
                "SearchText": "\(self.VC?.searchProductTF.text ?? "")",
                "StartIndex": "\(self.VC?.startIndex ?? -1)",
                  "NoOfRows": 10,
                "Sort": ""
            ] as [String : Any]
            print(self.parameters!)
        }else{
            self.parameters = [
                "ActionType": "6",
                "ActorId": "\(self.userID)",
                  "ObjCatalogueDetails": [
                      "MerchantId": 1,
                      "CatogoryId": "\(self.VC?.categoryId ?? -1)",
                      "CatalogueType": 1,
                      "MultipleRedIds": "\(self.VC?.selectedPtsRange ?? "")"
                  ],
                "SearchText": "\(self.VC?.searchProductTF.text ?? "")",
                "StartIndex": "\(self.VC?.startIndex ?? -1)",
                  "NoOfRows": 10,
                "Sort": "\(self.VC?.sortedBy ?? -1)"
            ] as [String : Any]
            print(self.parameters!)
        }
        self.requestAPIs.productCatalogueListApi(parameters: self.parameters!) { (result, error) in

                if error == nil{
                    if result != nil{
                        DispatchQueue.main.async {
                            self.VC?.stopLoading()
                            let catalogueProductsList = result?.objCatalogueList ?? []
                            print(catalogueProductsList.count, "catalogueProductsList List Count")
                            if catalogueProductsList.isEmpty == false || catalogueProductsList.count != 0{
                                self.catalgoueListArray = self.catalgoueListArray + catalogueProductsList
                                self.VC?.noofelements = self.catalgoueListArray.count
                                self.brandArray = self.catalgoueListArray
                                print(self.catalgoueListArray.count, "Catalogue List Count")
                                if self.catalgoueListArray.count != 0{
                                    self.VC?.productsDetailCollectionView.isHidden = false
                                    self.VC?.noDataFound.isHidden = true
                                    self.VC?.productsDetailCollectionView.reloadData()
                                }else{
                                    self.VC?.startIndex = 1
                                    self.VC?.productsDetailCollectionView.isHidden = true
                                    self.VC?.noDataFound.isHidden = false
                                }
                                self.cartCountApi()
                            }else{
                                if self.VC?.itsFrom == "Search" && self.VC!.startIndex > 1 || self.VC?.itsFrom == "Category" && self.VC!.startIndex > 1 || self.VC?.itsFrom == "PtsRange" && self.VC!.startIndex > 1{
                                    self.VC?.startIndex = 1
                                    self.VC?.noofelements = 9
                                }else{
                                    self.VC?.productsDetailCollectionView.isHidden = true
                                    self.VC?.noDataFound.isHidden = false
                                }

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
    func cartCountApi(){
        self.VC?.startLoading()
        let parameters = [
            "ActionType":"1",
            "LoyaltyID":"\(loyaltyId)"
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.cartCountApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.redemptionPlannerList()

                    }
                }else{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async{
                    self.VC?.stopLoading()
                }
            }
        }
    }
    func redemptionPlannerList(){
        self.VC?.startLoading()
        let parameters = [
            "ActionType":"6",
            "ActorId":"\(userID)"
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.redemptionPlannerList(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.plannerListArray = result?.objCatalogueList ?? []
                        print(self.plannerListArray.count, "Planner List Count")
                        
                        self.VC?.productsDetailCollectionView.reloadData()
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
    
//    func filteredCategoryListApi(){
//        self.VC?.startLoading()
//        let parameters = [
//            "ActionType":"6",
//            "ActorId":"\(self.userID)",
//            "ObjCatalogueDetails":[
//                "CatalogueType":"1",
//                "CatogoryId": self.VC?.categoryId ?? -1,
//                "MerchantId":"1"
//        ]
//        ] as [String :Any]
//        print(parameters)
//        self.requestAPIs.filteredCatalogueListApi(parameters: parameters) { (result, error) in
//            if error == nil{
//                print(result ?? "", "Result")
//                if result != nil{
//                    DispatchQueue.main.async {
//                        self.catalgoueListArray = result?.objCatalogueList ?? []
//                        print(self.catalgoueListArray.count, "Catalogue List Count")
//                        if self.catalgoueListArray.count != 0{
//                            self.VC?.productsDetailCollectionView.isHidden = false
//                            self.VC?.noDataFound.isHidden = true
//                            self.VC?.productsDetailCollectionView.reloadData()
//                        }else{
//                            self.VC?.productsDetailCollectionView.isHidden = true
//                            self.VC?.noDataFound.isHidden = false
//                        }
//
//                    }
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                    }
//                }else{
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                    }
//                }
//            }else{
//                DispatchQueue.main.async {
//                    self.VC?.stopLoading()
//                }
//            }
//
//        }
//
//    }
//
    //Add to Cart Api
    
    func addToCartApi(){
        self.VC?.startLoading()
        let parameters = [
                "ActionType": "1",
                "ActorId": "\(userID)",
                "CatalogueSaveCartDetailListRequest": [
                    [
                        "CatalogueId": "\(self.VC?.selectedCatalogueID ?? 0)",
                        "DeliveryType": "1",
                        "NoOfQuantity": "1"
                    ]
                ],
                "LoyaltyID": "\(loyaltyId)",
                "MerchantId": "1"
        ] as [String :Any]
        print(parameters)
        self.requestAPIs.addToCartApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result?.returnValue ?? "", "ReturnValue")
                        if result?.returnValue == 1{
                            
                            NotificationCenter.default.post(name: .cartCount, object: nil)
                            self.catalgoueListArray.removeAll()
                            self.getMycartList()
                            let alert = UIAlertController(title: "", message: "Added To Cart".localiz(), preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK".localiz(), style: .default, handler: nil))
                            self.VC?.present(alert, animated: true, completion: nil)
                            self.VC?.productsDetailCollectionView.reloadData()
                            return
                        }else{
                            //PopUp Message
                            DispatchQueue.main.async{

                               let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                               vc!.delegate = self
                               vc!.titleInfo = ""
                                vc!.descriptionInfo = "Insufficient Point Balance".localiz()
                               vc!.modalPresentationStyle = .overCurrentContext
                               vc!.modalTransitionStyle = .crossDissolve
                               self.VC?.present(vc!, animated: true, completion: nil)
                            }
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
    
    func addedToPlanner(){
        self.VC?.startLoading()
        let parameters = [
            "ActionType": 0,
              "ActorId": "\(userID)",
              "ObjCatalogueDetails": [
                  "CatalogueId": self.VC?.plannerProductId ?? 0
              ]
        ] as [String :Any]
        print(parameters)
        self.requestAPIs.addToPlannerApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result?.returnValue ?? "", "Add To Planner Return Value")
                        if result?.returnValue ?? 0 >= 1{
                           DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                               vc!.delegate = self
                               vc!.titleInfo = ""
                               vc!.descriptionInfo = "Product is added into the Planner".localiz()
                               vc!.modalPresentationStyle = .overCurrentContext
                               vc!.modalTransitionStyle = .crossDissolve
                               self.VC?.present(vc!, animated: true, completion: nil)
                            }
                            self.catalgoueListArray.removeAll()
                            self.getMycartList()
                        }else{
                            DispatchQueue.main.async{

                               let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
                               vc!.delegate = self
                               vc!.titleInfo = ""
                                vc!.descriptionInfo = "You can't add this products into your planner List".localiz()
                               vc!.modalPresentationStyle = .overCurrentContext
                               vc!.modalTransitionStyle = .crossDissolve
                               self.VC?.present(vc!, animated: true, completion: nil)
                            }
                        }
                        self.VC?.productsDetailCollectionView.reloadData()
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
    
   
    
    
    func plannerAddOrNot(){
        self.VC?.startLoading()
        let parameters = [
            "ActionType":"18",
            "ActorId":"\(userID)"
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.plannerAddedOrNotApi(parameters: parameters) { (result, error) in
             if error == nil{
                if result != nil{
                    DispatchQueue.main.async{
//                        self.productListArray = result?.objCatalogueList ?? []
//                        print(self.productListArray.count, "Add To Planner Or Not")
                    }
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                    }
                }else{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                    }
                }
                
            }else{
                DispatchQueue.main.async{
                    self.VC?.stopLoading()
                }
            }
        }
    }
    
}
class ProductCateogryModels : NSObject{
    var productCategoryId:String!
    var productCategorName:String!
    var isSelected: Int!
    init(productCategoryId: String, productCategorName: String, isSelected: Int!){
        self.productCategoryId = productCategoryId
        self.productCategorName = productCategorName
        self.isSelected = isSelected
    }
}
