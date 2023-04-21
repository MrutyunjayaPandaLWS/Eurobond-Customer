//
//  HR_ProductCategoryCVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/19/22.
//

import UIKit

class HR_ProductCategoryCVC: UICollectionViewCell {
    

    @IBOutlet weak var categoryName: UILabel!
 
    override var isSelected: Bool {
        didSet {
//            if UserDefaults.standard.string(forKey: "CustomerType") ?? "" == "1"{
//                categoryName.textColor = isSelected ? .white : .black
//                categoryName.backgroundColor = isSelected ? #colorLiteral(red: 0.7437494397, green: 0.08922102302, blue: 0.1178346947, alpha: 1) : #colorLiteral(red: 0.8784313725, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
//            }else{
                categoryName.textColor = isSelected ? .white : .black
                categoryName.backgroundColor = isSelected ? #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1): #colorLiteral(red: 0.8784313725, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
           // }
            
         
        }
    }
}
