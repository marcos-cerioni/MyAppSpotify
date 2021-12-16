//
//  Model.swift
//  MyApp
//
//  Created by Marcos Cerioni on 29/10/2021.
//

import Foundation

struct Account {
    let user: String
    let pass: String
}

struct Registered {
    let user1: Account = Account(user: "hola@gmail.com", pass: "queOnda123")
}

struct Track: Codable, Hashable {
    let title: String
    let artist: String?
    let album: String?
    let song_id: String?
    let genre: String?
    var isPlaying: Bool?
    
    enum CodingKeys: String, CodingKey {
        case artist
        case title = "name"
        case album
        case genre
        case song_id = "song_id"
    }
}

enum Genero: String, Codable {
    case Rock
    case Pop
    case Otros
    case vacio = ""
}

var misTracks = [Track]()
var tracks = Set<Track>()    // Para playlist
var tracksArray = [Track]()  // Para playlist

enum PlayerStates{
    case play
    case pause
    case next
    case previous
}

