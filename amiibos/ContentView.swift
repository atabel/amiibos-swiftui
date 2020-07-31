//
//  ContentView.swift
//  amiibos
//
//  Created by Abel Toledano on 20/07/2020.
//  Copyright © 2020 Abel Toledano. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AmiibosList()
                .tabItem {
                    Image(systemName: "person")
                    Text("Amiibos")
                }
            GamesList()
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Games")
                }
            YourLists()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Lists")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .environment(\.colorScheme, .dark)
        }
    }
}
