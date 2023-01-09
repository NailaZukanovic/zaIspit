//
//  ContentView.swift
//  Recepti
//
//  Created by MacLab6 on 22.10.22..
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct ContentView: View {
    
    @StateObject private var appState = AppState.shared
    
    var body: some View {
        NavigationView {
            if(appState.authentificated){
                CategoriesScreenView()
            }else{
                LoginScreenView()
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
