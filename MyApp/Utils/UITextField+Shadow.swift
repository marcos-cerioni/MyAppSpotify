//
//  TextField+Shadow.swift
//  MyApp
//
//  Created by Marcos Cerioni on 25/11/2021.
//

import Foundation
import UIKit

extension UITextField {
    func tfShadow() {
        layer.shadowOpacity = 1
        layer.shadowRadius = 3.0
//        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.cyan.cgColor
    }
}
