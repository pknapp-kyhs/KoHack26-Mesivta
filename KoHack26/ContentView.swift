//
//  ContentView.swift
//  KoHack26
//
//  Created by Mendel W on 3/22/26.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var selection: [PhotosPickerItem] = []
    
    var body: some View {
        TabView {
            PageScan(selection: $selection)
                .tabItem{Label("Scan Page", systemImage: "camera")}
            TextDisplay()
                .tabItem{Label("Display Text" , systemImage: "printer")}
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
