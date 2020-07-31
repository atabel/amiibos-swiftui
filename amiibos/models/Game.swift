//
//  Game.swift
//  amiibos
//
//  Created by Abel Toledano on 20/07/2020.
//  Copyright © 2020 Abel Toledano. All rights reserved.
//

import Foundation

struct Game: Codable, Identifiable {
    var id: String
    var name: String
    var dateRelease: String
    var system: String
    var developer: String
    var publisher: String
    var categories: [String]
    var gameSeries: [String]
}
