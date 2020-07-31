//
//  Amiibo.swift
//  amiibos
//
//  Created by Abel Toledano on 20/07/2020.
//  Copyright © 2020 Abel Toledano. All rights reserved.
//

import Foundation

struct Amiibo: Codable, Identifiable {
    let id: String
    let name: String
    let number: String?
    let dateRelease: String
    let collection: String
    let gameSeries: [String]
    let compatibleGames: [GameCompatibility]
}

struct GameCompatibility: Codable, Identifiable {
    let id: String
    let rank: String?
    let description: String
}

struct AmiiboCollection: Identifiable {
    let id: String
    let name: String
    let amiibos: [Amiibo]
}
