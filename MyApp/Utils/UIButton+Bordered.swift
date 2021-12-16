//
//  UIButton+Bordered.swift
//  MyApp
//
//  Created by Marcos Cerioni on 25/11/2021.
//

import Foundation
import UIKit

extension UIButton {
    func bordered() {
        layer.cornerRadius = self.frame.size.height / 2
        backgroundColor = .white
        tintColor = .blue
//        self.layer.borderColor = UIColor.cyan.cgColor
        layer.borderWidth = 2
    }

    
    func fill() {
        backgroundColor = .blue
    }
}
