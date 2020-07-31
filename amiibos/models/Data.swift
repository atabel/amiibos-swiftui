//
//  Data.swift
//  amiibos
//
//  Created by Abel Toledano on 21/07/2020.
//  Copyright © 2020 Abel Toledano. All rights reserved.
//

import Foundation

struct JsonData: Codable {
    var amiibos: [Amiibo]
    var games: [Game]
}

let data: JsonData = load("amiibo-data.json")
let amiibos: [Amiibo] = data.amiibos
let games: [Game] = data.games
let collections: [AmiiboCollection] = makeCollections()

func makeCollections() -> [AmiiboCollection] {
    let collectionsMap: [String: [Amiibo]] = Dictionary(grouping: amiibos, by: { $0.collection })
    var arr = [AmiiboCollection]()

    for (collectionName, collectionAmiibos) in collectionsMap {
        arr.append(AmiiboCollection(id: collectionName, name: collectionName, amiibos: collectionAmiibos.sorted(by: { $0.dateRelease < $1.dateRelease })))
    }

    return arr.sorted(by: { $0.amiibos[0].dateRelease < $1.amiibos[0].dateRelease })
}

func getGameById(id: String) -> Game {
    return games.first(where: { $0.id == id })!
}

struct AmiiboForGame: Identifiable {
    var id: String {
        get {self.amiibo.id}
    }
    var amiibo: Amiibo
    var description: String
}

func getAmiibosForGame(game: Game) -> [AmiiboForGame] {
    amiibos.filter {
        $0.compatibleGames.contains(where: { $0.id == game.id })
    }.map { amiibo in
        AmiiboForGame(amiibo: amiibo, description: amiibo.compatibleGames.first(where: { $0.id == game.id })!.description)
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
