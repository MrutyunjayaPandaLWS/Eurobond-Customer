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
    
        var player = AVPlayer()
         
        let playerController = AVPlayerViewController()
        var timmer = Timer()
        override func viewDidLoad() {
            super.viewDidLoad()
            _ = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)
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
                self.timmer = Timer.scheduledTimer(timeInterval: 7.0, target: self, selector: #selector(self.goToWelcomeScreen), userInfo: nil, repeats: false)
            }
        }

        @objc func goToWelcomeScreen(){
            timmer.invalidate()
            playerController.dismiss(animated: true)
        }
        
        @objc func update(){
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EBC_WelcomeVC") as? EBC_WelcomeVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
