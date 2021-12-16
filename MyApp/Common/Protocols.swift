//
//  ButtonOnCellDelegate.swift
//  MyApp
//
//  Created by Marcos Cerioni on 04/11/2021.
//

import Foundation
import UIKit

protocol ButtonOnCellDelegate{
    func buttonTouchedOnCell(parametro: UITableViewCell)
}

protocol TracksPickerDelegate {
    func addTrack(objetoTrack: Track)
}

protocol TracksTableVCDelegate {
    func addTrackTV(objetoTrack: Track)
}
