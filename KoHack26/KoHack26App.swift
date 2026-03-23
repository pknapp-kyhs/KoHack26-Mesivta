//
//  KoHack26App.swift
//  KoHack26
//
//  Created by Mendel W on 3/22/26.
//

import SwiftUI
import Firebase

@main
struct KoHack26App: App {
    @AppStorage("loggedIn") var loggedIn = false
    
    init(){
        FirebaseApp.configure()}

    var body: some Scene {
        WindowGroup {

            if loggedIn{
                ContentView()
            }
            else{
                Login()
            }
        }
    }
}
