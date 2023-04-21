//
//  SceneDelegate.swift
//  EuroBond_Customer
//
//  Created by syed on 17/03/23.
//

import UIKit
import SlideMenuControllerSwift
import IQKeyboardManagerSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var slider : SlideMenuController!
    var nav : UINavigationController!


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        IQKeyboardManager.shared.enable = true
        tokendata()
        let isUserLoggedIn: Int = UserDefaults.standard.integer(forKey: "IsloggedIn?")
        print(isUserLoggedIn)
        if isUserLoggedIn == 1{
            self.setHomeAsRootViewController()
        } else if isUserLoggedIn == 2{
            self.setHomeAsRootViewController2()
        }else if isUserLoggedIn == -1 {
            self.setInitialLoginVC()
        }else{
            self.setInitialViewAsRootViewController()
        }
    }

    func setHomeAsRootViewController(){
        let leftVC = storyboard.instantiateViewController(withIdentifier: "EBC_SideMenuVC") as! EBC_SideMenuVC
        let homeVC = storyboard.instantiateViewController(withIdentifier: "EBC_DashboardVC") as! EBC_DashboardVC
        slider = SlideMenuController(mainViewController: homeVC, leftMenuViewController: leftVC)
        nav = UINavigationController(rootViewController: slider)
        nav.isNavigationBarHidden = true
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
         func setInitialLoginVC(){
             let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
             let initialVC = mainStoryboard.instantiateViewController(withIdentifier: "EBC_WelcomeVC") as! EBC_WelcomeVC
             nav = UINavigationController(rootViewController: initialVC)
             nav.modalPresentationStyle = .overCurrentContext
             nav.modalTransitionStyle = .partialCurl
             nav.isNavigationBarHidden = true
             window?.rootViewController = nav
             window?.makeKeyAndVisible()
         }
    
    func setHomeAsRootViewController2(){
        let homeVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_Dashboard_2_VC") as! EBC_Dashboard_2_VC
        nav = UINavigationController(rootViewController: homeVC)
        nav.isNavigationBarHidden = true
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
    func setInitialViewAsRootViewController(){
        let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
        let initialVC = mainStoryboard.instantiateViewController(withIdentifier: "EBC_LaunchScreenVC") as! EBC_LaunchScreenVC
        nav = UINavigationController(rootViewController: initialVC)
        nav.modalPresentationStyle = .overCurrentContext
        nav.modalTransitionStyle = .partialCurl
        nav.isNavigationBarHidden = true
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
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
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

