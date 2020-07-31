//
//  SearchBar.swift
//  amiibos
//
//  Created by Abel Toledano on 23/07/2020.
//  Copyright © 2020 Abel Toledano. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var onCancelSearch: () -> ()
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("search", text: $searchText).foregroundColor(.primary)
                
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
            
            Button("Cancel") {
                self.searchText = ""
                onCancelSearch()
            }.foregroundColor(.blue)
        }
        .navigationBarHidden(true)
    }
}
