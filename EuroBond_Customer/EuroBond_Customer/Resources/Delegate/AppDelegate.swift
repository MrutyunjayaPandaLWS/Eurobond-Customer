//
//  AppDelegate.swift
//  EuroBond_Customer
//
//  Created by syed on 17/03/23.
//

import UIKit
import CoreData
import SlideMenuControllerSwift
import IQKeyboardManagerSwift
import FirebaseCore
import Firebase

import UserNotificationsUI
import FirebaseInstanceID
import FirebaseMessaging
import LanguageManager_iOS
//import FBSDKCoreKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate{

    var window: UIWindow?
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var slider : SlideMenuController!
    var nav : UINavigationController!
    var gcmMessageIDKey = "gcm.message_id"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 4.0))
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 4.0))
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        if UserDefaults.standard.string(forKey: "CURRENTLANGUAGE") ?? "" == "en"{
            LanguageManager.shared.setLanguage(language: .en)

        }else if UserDefaults.standard.string(forKey: "CURRENTLANGUAGE") ?? "" == "hi"{
            LanguageManager.shared.setLanguage(language: .hi)

        }else{
            LanguageManager.shared.setLanguage(language: .en)
        }
        
        IQKeyboardManager.shared.enable = true
        let isUserLoggedIn: Int = UserDefaults.standard.integer(forKey: "IsloggedIn?")
        print(isUserLoggedIn)
        tokendata()
        FirebaseApp.configure()
        
        if isUserLoggedIn == 1 {
            self.setInitialViewAsRootViewController()
        } else if isUserLoggedIn == 2 {
            self.setInitialViewAsRootViewController()
        }else if isUserLoggedIn == -1 {
            self.setInitialViewAsRootViewController()
        }else {
            self.setInitialViewAsRootViewController()
        }
        //  Messaging.messaging().isAutoInitEnabled = true
          application.registerForRemoteNotifications()
          Messaging.messaging().delegate = self
          Messaging.messaging().token { token, error in
            if let error = error {
              print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
              print("FCM registration token: \(token)")
              UserDefaults.standard.setValue(token, forKey: "UD_DEVICE_TOKEN")
            }
          }
//        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
//        ApplicationDelegate.initialize()
//        Settings.shared.isAutoLogAppEventsEnabled = true
//        Settings.shared.isAdvertiserIDCollectionEnabled = true
//        Settings.shared.isAdvertiserTrackingEnabled = true
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .badge, .sound])
    }
    //MessagingDelegate
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase token: \(fcmToken)")
        UserDefaults.standard.setValue(fcmToken, forKey: "DEVICE_TOKEN")

    }
    
    
    func setHomeAsRootViewController(){
        if UserDefaults.standard.string(forKey: "CURRENTLANGUAGE") ?? "" == "en"{
            LanguageManager.shared.setLanguage(language: .en)

        }else if UserDefaults.standard.string(forKey: "CURRENTLANGUAGE") ?? "" == "hi"{
            LanguageManager.shared.setLanguage(language: .hi)

        }else{
            LanguageManager.shared.setLanguage(language: .en)
        }
        IQKeyboardManager.shared.enable = true
        let leftVC = storyboard.instantiateViewController(withIdentifier: "EBC_SideMenuVC") as! EBC_SideMenuVC
        let homeVC = storyboard.instantiateViewController(withIdentifier: "EBC_DashboardVC") as! EBC_DashboardVC
        slider = SlideMenuController(mainViewController: homeVC, leftMenuViewController: leftVC)
        nav = UINavigationController(rootViewController: slider)
        nav.isNavigationBarHidden = true
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
    
    func setHomeAsRootViewController2(){
        IQKeyboardManager.shared.enable = true
        if UserDefaults.standard.string(forKey: "CURRENTLANGUAGE") ?? "" == "en"{
            LanguageManager.shared.setLanguage(language: .en)

        }else if UserDefaults.standard.string(forKey: "CURRENTLANGUAGE") ?? "" == "hi"{
            LanguageManager.shared.setLanguage(language: .hi)

        }else{
            LanguageManager.shared.setLanguage(language: .en)
        }
        let homeVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_Dashboard_2_VC") as! EBC_Dashboard_2_VC
        nav = UINavigationController(rootViewController: homeVC)
        nav.isNavigationBarHidden = true
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
    func setInitialLoginVC(){
        if UserDefaults.standard.string(forKey: "CURRENTLANGUAGE") ?? "" == "en"{
            LanguageManager.shared.setLanguage(language: .en)

        }else if UserDefaults.standard.string(forKey: "CURRENTLANGUAGE") ?? "" == "hi"{
            LanguageManager.shared.setLanguage(language: .hi)

        }else{
            LanguageManager.shared.setLanguage(language: .en)
        }
        IQKeyboardManager.shared.enable = true
        let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
        let initialVC = mainStoryboard.instantiateViewController(withIdentifier: "EBC_WelcomeVC") as! EBC_WelcomeVC
        nav = UINavigationController(rootViewController: initialVC)
        nav.modalPresentationStyle = .overCurrentContext
        nav.modalTransitionStyle = .partialCurl
        nav.isNavigationBarHidden = true
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
    
    func setInitialViewAsRootViewController(){
        IQKeyboardManager.shared.enable = true
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
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "EuroBond_Customer")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

