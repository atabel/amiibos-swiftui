//
//  AmiibosList.swift
//  amiibos
//
//  Created by Abel Toledano on 23/07/2020.
//  Copyright © 2020 Abel Toledano. All rights reserved.
//

import SwiftUI

struct Carousel: View {
    var collection: AmiiboCollection
    var searchText: String

    var filteredAmiibos: [Amiibo] {
        collection.amiibos.filter { searchText.isEmpty || $0.name.range(of: searchText, options: .caseInsensitive) != nil }
    }

    var body: some View {
        Group {
            if filteredAmiibos.count > 0 {
                VStack(alignment: .leading) {
                    Text(collection.name)
                        .font(.headline)
                        .padding(.leading)

                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(filteredAmiibos, id: \.id) { amiibo in
                                NavigationLink(destination: AmiiboDetail(amiibo: amiibo)) {
                                    VStack {
                                        
                                        Image("\(amiibo.id)-500w")
                                            .resizable()
                                            .scaledToFit()
                                        
                                        Text(amiibo.name)
                                            .font(.footnote)
                                            .lineLimit(1)
                                            .padding(.horizontal)
                                        
                                    }.frame(width: 120.0)
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
                .padding(.vertical)
            } else {
                EmptyView()
            }
        }
    }
}

struct AmiibosList: View {
    @State private var searchText = ""
    @State private var isSearching = false

    func onCancelSearch() {
        isSearching = false
    }

    var body: some View {
        NavigationView {
            List {
                if isSearching {
                    SearchBar(searchText: $searchText, onCancelSearch: onCancelSearch)
                }
                ForEach(collections, id: \.id) { collection in
                    Carousel(collection: collection, searchText: self.searchText).listRowInsets(.init())
                }
            }
            .navigationBarTitle("Amiibos")
            .navigationBarHidden(isSearching)
            .navigationBarItems(trailing:
                Button("Search") {
                    isSearching = true
                }
            )
        }
    }
}

struct AmiibosList_Previews: PreviewProvider {
    static var previews: some View {
        AmiibosList()
    }
}
