//
//  AmiiboDetail.swift
//  amiibos
//
//  Created by Abel Toledano on 21/07/2020.
//  Copyright © 2020 Abel Toledano. All rights reserved.
//

import SwiftUI

struct CompatibleGameSheet: View {
    var game: Game
    var description: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image("\(game.id)-500w").resizable().scaledToFit().ignoresSafeArea()

                VStack(alignment: .leading) {
                    Text(game.system)
                        .font(.headline)
                        .fontWeight(.light)

                    Text(game.name)
                        .font(.title)
                        .lineLimit(2)

                    Text(description)
                        .padding(.top)

                }.padding()
            }
        }
    }
}

struct AmiiboDetail: View {
    var amiibo: Amiibo
    @State private var selectedCompatibleGame: GameCompatibility?

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            Image("\(amiibo.id)-500w").resizable().scaledToFit().listRowInsets(.init())

            HStack {
                VStack(alignment: .leading, spacing: 24) {
                    Text(amiibo.name)
                        .font(.title)
                        .lineLimit(2)

                    Text("Compatible games:")
                        .font(.headline)
                }
                Spacer()
            }.padding(.horizontal)

            LazyVGrid(columns: columns) {
                ForEach(amiibo.compatibleGames, id: \.id) { compatibleGame in
                    Image("\(compatibleGame.id)-500w")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .shadow(radius: 6)
                        .onTapGesture {
                            selectedCompatibleGame = compatibleGame
                        }
                }
            }.padding(.horizontal)
        }
        .sheet(item: $selectedCompatibleGame) { compatibleGame in
            CompatibleGameSheet(game: getGameById(id: compatibleGame.id), description: compatibleGame.description)
        }
        .navigationBarTitle(Text(amiibo.name), displayMode: .inline)
    }
}

struct AmiiboDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AmiiboDetail(amiibo: amiibos[0])
            CompatibleGameSheet(game: games[0], description: "Some random description for the amiibo used in the game.")
        }
    }
}
