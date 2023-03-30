//
//  String+Extenssion.swift
//  Hoya Thailand
//
//  Created by syed on 25/02/23.
//

import Foundation
import UIKit

extension String{
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
