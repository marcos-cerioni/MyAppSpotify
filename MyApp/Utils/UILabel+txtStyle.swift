//
//  UILabel+txtStyle.swift
//  MyApp
//
//  Created by Marcos Cerioni on 25/11/2021.
//

import Foundation
import UIKit

extension UILabel {
    func textStle() {
        textColor = .lightGray
        let fontSize = self.font.pointSize
        font = UIFont(name: "HelveticaNeue", size: fontSize)
    }
}
