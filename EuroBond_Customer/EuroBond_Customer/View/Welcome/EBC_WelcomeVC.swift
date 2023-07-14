//
//  EBC_WelcomeVC.swift
//  EuroBond_Customer
//
//  Created by syed on 17/03/23.
//

import UIKit
import LanguageManager_iOS
import CoreData
class EBC_WelcomeVC: BaseViewController {

    @IBOutlet weak var englishOutBtn: UIButton!
    @IBOutlet weak var bangaliLangOutBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tokendata()
        englishOutBtn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        bangaliLangOutBtn.addTarget(self, action: #selector(buttonTapped1), for: .touchUpInside)
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.stopLoading()
    }
    
    
    @objc func buttonTapped() {
        self.englishOutBtn.isEnabled = false
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
               // Enable the button after the task is completed
               
               if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                   DispatchQueue.main.async{
                       self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
                   }
               }else{
                   LanguageManager.shared.setLanguage(language: .en)
                   UserDefaults.standard.setValue("en", forKey: "CURRENTLANGUAGE")
                   UserDefaults.standard.synchronize()
                   self.clearTable()
                   self.clearTable1()
                   self.clearTable2()
                   DispatchQueue.main.async {
                       self.startLoading()
                           let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_Login1VC") as? EBC_Login1VC
                           self.navigationController?.pushViewController(vc!, animated: true)
                   }
               }
               self.englishOutBtn.isEnabled = true
           }
       }
    
    @objc func buttonTapped1() {
        self.bangaliLangOutBtn.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                    self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
                }
            }else{
                LanguageManager.shared.setLanguage(language: .hi)
                UserDefaults.standard.setValue("hi", forKey: "CURRENTLANGUAGE")
                UserDefaults.standard.synchronize()
                self.clearTable()
                self.clearTable1()
                self.clearTable2()
                DispatchQueue.main.async {
                    self.startLoading()
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_Login1VC") as? EBC_Login1VC
                    self.navigationController?.pushViewController(vc!, animated: true)
                }
            }
            self.bangaliLangOutBtn.isEnabled = true
        }
    }
    
    
    
    func clearTable1(){
            
            let context = persistanceservice.persistentContainer.viewContext
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UploadedCodes")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print ("There was an error")
            }
        }
    func clearTable(){
        
        let context = persistanceservice.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ScanCodeSTORE")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func clearTable2(){
            
            let context = persistanceservice.persistentContainer.viewContext
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SendUploadedCodes")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print ("There was an error")
            }
        }

    @IBAction func selectEnglishBtn(_ sender: UIButton) {
        //self.startLoading()
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: { [self] in

            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                    self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
                }
            }else{
                LanguageManager.shared.setLanguage(language: .en)
                UserDefaults.standard.setValue("en", forKey: "CURRENTLANGUAGE")
                UserDefaults.standard.synchronize()
                self.clearTable()
                self.clearTable1()
                self.clearTable2()
                DispatchQueue.main.async {
                    self.startLoading()
                        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_Login1VC") as? EBC_Login1VC
                        self.navigationController?.pushViewController(vc!, animated: true)
                }
            }
    }
    
    @IBAction func selectHindiBtn(_ sender: UIButton) {
//        self.startLoading()
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
            }
        }else{
            LanguageManager.shared.setLanguage(language: .hi)
            UserDefaults.standard.setValue("hi", forKey: "CURRENTLANGUAGE")
            UserDefaults.standard.synchronize()
            clearTable()
            clearTable1()
            clearTable2()
            DispatchQueue.main.async {
                self.startLoading()
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_Login1VC") as? EBC_Login1VC
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
//        DispatchQueue.main.async {
//            self.stopLoading()
//            return
//        }
    }
    
    func tokendata(){
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
        }else{
            let parameters : Data = "username=\(username)&password=\(password)&grant_type=password".data(using: .utf8)!

        let url = URL(string: tokenURL)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = parameters
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
       
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do{
                let parseddata = try JSONDecoder().decode(TokenModels.self, from: data)
                    print(parseddata.access_token ?? "")
                    UserDefaults.standard.setValue(parseddata.access_token ?? "", forKey: "TOKEN")
                 }catch let parsingError {
                print("Error", parsingError)
            }
        })
        task.resume()
    }
    }
}
