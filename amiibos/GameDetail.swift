//
//  AmiiboDetail.swift
//  amiibos
//
//  Created by Abel Toledano on 21/07/2020.
//  Copyright © 2020 Abel Toledano. All rights reserved.
//

import SwiftUI

struct AmiiboForGameSheet: View {
    var amiibo: Amiibo
    var description: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image("\(amiibo.id)-500w").resizable().scaledToFit()
                
                VStack(alignment: .leading) {
                    Text(amiibo.name)
                        .font(.title)
                        .lineLimit(2)
                    
                    Text(description)
                        .padding(.top)
                    
                }.padding()
            }
        }
    }
}

struct GameDetail: View {
    var game: Game
    @State private var selectedCompatibleAmiibo: AmiiboForGame?
    @State private var viewDetail: Bool = false
    
    private func getOffset(_ geo: GeometryProxy) -> CGFloat {
        -max(geo.frame(in: .global).minY, 0)
    }
    
    private func getHeight(_ geo: GeometryProxy) -> CGFloat {
        geo.frame(in: .global).minY > 0 ? geo.size.height + geo.frame(in: .global).minY : geo.size.height
    }
    
    private func getBlur(_ geo: GeometryProxy) -> CGFloat {
        let offset = max(geo.frame(in: .global).minY - 140, 0)
        let maxBlurOffset: CGFloat = 100
        let blur = 1 - (maxBlurOffset - offset) / maxBlurOffset
        return blur * 6
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            GeometryReader { geo in
                Image("\(game.id)-500w")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: getHeight(geo))
                    .blur(radius: getBlur(geo))
                    .clipped()
                    .offset(y: getOffset(geo))
            }.frame(height: 300)
            
            VStack(alignment: .leading) {
                Text(game.system)
                    .font(.headline)
                    .fontWeight(.light)
                
                Text(game.name)
                    .font(.title)
                    .lineLimit(2)
                
                HStack(alignment: .center, spacing: 4) {
                    ForEach(game.categories, id: \.self) { category in
                        Chip(text: category.capitalized.replacingOccurrences(of: "_", with: " "))
                    }
                    Spacer()
                }.padding(.top)
            }.padding()
            
            HStack {
                Text("Compatible amiibos:")
                    .font(.headline)
                Spacer()
            }
            .padding([.top, .leading, .trailing])
            
            LazyVGrid(columns: columns) {
                ForEach(getAmiibosForGame(game: game), id: \.amiibo.id) { amiiboForGame in
                    Image("\(amiiboForGame.amiibo.id)-500w")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120.0)
                        .onTapGesture {
                            selectedCompatibleAmiibo = amiiboForGame
                        }
                }
            }
        }.sheet(item: $selectedCompatibleAmiibo) { amiiboForGame in
            AmiiboForGameSheet(amiibo: amiiboForGame.amiibo, description: amiiboForGame.description)
        }
    }
}

struct GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameDetail(game: games[0])
            AmiiboForGameSheet(amiibo: amiibos[0], description: "Some random description for the amiibo used in the game.")
        }
    }
}
