//
//  DataManager.swift
//  MyApp
//
//  Created by Marcos Cerioni on 18/11/2021.
//

import Foundation

class DataManager {
    static func cancionesPorGenero(tracks: [Track]) -> [Track] {
        return tracks.filter{ songs in
            songs.genre != nil
        }
    }
}
