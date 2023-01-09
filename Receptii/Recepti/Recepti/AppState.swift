//
//  AppState.swift
//  Recepti
//
//  Created by Digital Atrium on 4.1.23..
//

import Foundation
import FirebaseCore
import FirebaseAuth

class AppState: ObservableObject {
    
    static let shared = AppState()
    
    @Published var authentificated: Bool = false
    
    init(){
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            self?.authentificated = user != nil
        }
    }
}
