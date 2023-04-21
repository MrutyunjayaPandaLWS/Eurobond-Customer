//
//  EBC_WelcomeVC.swift
//  EuroBond_Customer
//
//  Created by syed on 17/03/23.
//

import UIKit

class EBC_WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tokendata()
    }

    @IBAction func selectEnglishBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_Login1VC") as? EBC_Login1VC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func selectHindiBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_Login1VC") as? EBC_Login1VC
        navigationController?.pushViewController(vc!, animated: true)
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
