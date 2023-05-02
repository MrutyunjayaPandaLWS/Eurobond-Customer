//
//  EBC_WhatsNewVC.swift
//  EuroBond_Customer
//
//  Created by syed on 27/03/23.
//

import UIKit
import WebKit
import LanguageManager_iOS

class EBC_WhatsNewVC: UIViewController{

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var whatsNewTV: UITableView!
    @IBOutlet weak var VCTitle: UILabel!
    
    var myData : [whatsNewModel] = [whatsNewModel(title: "Our Recent Project at Mumbai", description: "Modern construction has made the “skin of architecture” a central concern. Our Performance-rich, Feature-rich, and Natural Metal Panels are sure to win your heart! Eurobond, is a pinoneer in the field of aluminium composite panels. The business has had a headquaters in Mumbai for more than 19 years, and its plant in Umergaon effectively serves a clientele from around the world. We complete our entire production process quickly, efficient, and seamlessly by utilizing cutting-edge processes and a professional team."),
    whatsNewModel(title: "Bonds That Last Forever", description: "Modern construction has made the “skin of architecture” a central concern. Our Performance-rich, Feature-rich, and Natural Metal Panels are sure to win your heart! Eurobond, is a pinoneer in the field of aluminium composite panels. The business has had a headquaters in Mumbai for more than 19 years, and its plant in Umergaon effectively serves a clientele from around the world. We complete our entire production process quickly, efficient, and seamlessly by utilizing cutting-edge processes and a professional team.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegateSetup()
        localizSetup()
    }
    
//    func delegateSetup(){
//        whatsNewTV.delegate = self
//        whatsNewTV.dataSource = self
//    }
    func localizSetup(){
        self.VCTitle.text = "WhatNew".localiz()
        if self.VCTitle.text == "What's New"{
            self.webView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "eurobond-what's-new-eng", ofType: "html")!) as URL) as URLRequest)
        }else{
            self.webView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "eurobond-what's-new-hin", ofType: "html")!) as URL) as URLRequest)
        }
    }
    
    @IBAction func selectBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return myData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "EBC_WhatsNewTVC", for: indexPath) as! EBC_WhatsNewTVC
//        cell.selectionStyle = .none
//        if indexPath.row == 0{
//            cell.lineLable.isHidden = true
//        }else{
//            cell.lineLable.isHidden = false
//        }
//
//        cell.projectName.text = myData[indexPath.row].title
//        cell.projectDetails.text = myData[indexPath.row].description
//
//        return cell
//    }
    
    
    

}


struct whatsNewModel{
    let title: String
    let description: String
}
