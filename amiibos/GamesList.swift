//
//  GamesList.swift
//  amiibos
//
//  Created by Abel Toledano on 23/07/2020.
//  Copyright © 2020 Abel Toledano. All rights reserved.
//

import SwiftUI

struct Chip: View {
    var text: String = ""
    var body: some View {
        Text(text)
            .lineLimit(1)
            .font(.footnote)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color(white: 0.777))
            .cornerRadius(16)
    }
}

func formatCategory(_ category: String) -> String {
    return category.capitalized.replacingOccurrences(of: "_", with: " ")
}

struct GameRow: View {
    var game: Game
    var onSelectCategory: (String) -> ()

    var body: some View {
        NavigationLink(destination: GameDetail(game: game)) {
            HStack {
                Image("\(game.id)-500w")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(12)
                    .shadow(radius: 2)

                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading) {
                        Text(game.system)
                            .font(.subheadline)
                        Text(game.name)
                            .font(.headline)
                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    }
                    HStack(alignment: .center, spacing: 4) {
                        ForEach(game.categories, id: \.self) { category in
                            Chip(text: formatCategory(category))
                                .onTapGesture {
                                    onSelectCategory(category)
                                }
                        }
                    }
                }
                .padding(.leading)
                Spacer()
            }
            .padding(.vertical, 8.0)
        }
    }
}

struct GamesList: View {
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var selectedCategory = ""

    func onCancelSearch() {
        selectedCategory = ""
        isSearching = false
    }

    func onSelectCategory(newCategory: String) {
        selectedCategory = newCategory
        isSearching = true
    }

    func isGameVisible(game: Game) -> Bool {
        let isInSelectedCategory = selectedCategory.isEmpty || game.categories.contains(selectedCategory)
        let nameMatchesSearch = searchText.isEmpty || game.name.range(of: searchText, options: .caseInsensitive) != nil

        return isInSelectedCategory && nameMatchesSearch
    }

    var body: some View {
        NavigationView {
            List {
                if isSearching {
                    SearchBar(searchText: $searchText, onCancelSearch: onCancelSearch)
                    if !selectedCategory.isEmpty {
                        HStack {
                            Chip(text: formatCategory(selectedCategory))
                                .onTapGesture {
                                    selectedCategory = ""
                                }
                            Spacer()
                        }
                    }
                }

                ForEach(games.filter(isGameVisible), id: \.id) { game in
                    GameRow(game: game, onSelectCategory: onSelectCategory)
                }
            }
            .navigationBarTitle("Games")
            .navigationBarHidden(isSearching)
            .navigationBarItems(trailing:
                Button("Search") {
                    isSearching = true
                }
            )
        }
    }
}

struct GamesList_Previews: PreviewProvider {
    static var previews: some View {
        GamesList()
    }
}
