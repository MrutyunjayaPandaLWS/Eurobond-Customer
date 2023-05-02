//
//  EBC_LaunchScreenVC.swift
//  EuroBond_Customer
//
//  Created by syed on 17/03/23.
//

import UIKit
import AVFoundation
import AVKit

class EBC_LaunchScreenVC: UIViewController {
    
        let isUserLoggedIn: Int = UserDefaults.standard.integer(forKey: "IsloggedIn?")
  
        var player = AVPlayer()
         
        let playerController = AVPlayerViewController()
        var timmer = Timer()
        override func viewDidLoad() {
            super.viewDidLoad()
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [unowned self] in
                self.update()
            }
        }
        override func viewDidAppear(_ animated: Bool) {
            playVideo()
        }
        private func playVideo() {
            guard let path = Bundle.main.path(forResource: "EUROBOND LOGO ANIMATION_1", ofType:"mp4") else {
                debugPrint("video.m4v not found")
                return
            }
            self.player = AVPlayer(url: URL(fileURLWithPath: path))
            playerController.player = player
            playerController.showsPlaybackControls = false
            present(playerController, animated: true) {
                self.player.play()
            }
        }

        @objc func goToWelcomeScreen(){
            timmer.invalidate()
            playerController.dismiss(animated: true)
        }
        
    @objc func update(){
        timmer.invalidate()
        playerController.dismiss(animated: true)
            let isUserLoggedIn: Int = UserDefaults.standard.integer(forKey: "IsloggedIn?")
            print(isUserLoggedIn)
            if isUserLoggedIn == 1 {
                if #available(iOS 13.0, *) {
                    DispatchQueue.main.async {
                        let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
                        sceneDelegate?.setHomeAsRootViewController()
                    }
                } else {
                    DispatchQueue.main.async {
                        if #available(iOS 13.0, *) {
                            let appDelegate = UIApplication.shared.delegate as? AppDelegate
                            appDelegate?.setHomeAsRootViewController()
                        }
                    }
                }
            } else if isUserLoggedIn == 2 {
                
                if #available(iOS 13.0, *) {
                    DispatchQueue.main.async {
                        let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
                        sceneDelegate?.setHomeAsRootViewController2()
                    }
                } else {
                    DispatchQueue.main.async {
                        if #available(iOS 13.0, *) {
                            let appDelegate = UIApplication.shared.delegate as? AppDelegate
                            appDelegate?.setHomeAsRootViewController2()
                        }
                    }
                }
                

            }else if isUserLoggedIn == -1 {
                if #available(iOS 13.0, *) {
                    DispatchQueue.main.async {
                        let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
                        sceneDelegate?.setInitialLoginVC()
                    }
                } else {
                    DispatchQueue.main.async {
                        if #available(iOS 13.0, *) {
                            let appDelegate = UIApplication.shared.delegate as? AppDelegate
                            appDelegate?.setInitialLoginVC()
                        }
                    }
                }
            }else {
                if #available(iOS 13.0, *) {
                    DispatchQueue.main.async {
                        let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
                        sceneDelegate?.setInitialLoginVC()
                    }
                } else {
                    DispatchQueue.main.async {
                        if #available(iOS 13.0, *) {
                            let appDelegate = UIApplication.shared.delegate as? AppDelegate
                            appDelegate?.setInitialLoginVC()
                        }
                    }
                }
            }
        }
    }

