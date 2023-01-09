//
//  LoginViewModel.swift
//  Recepti
//
//  Created by Digital Atrium on 4.1.23..
//

import Foundation
import FirebaseAuth
import FirebaseCore

class LoginViewModel: ObservableObject{
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String = ""
    @Published var success: Bool = false
    @Published var hasError = false
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if error != nil {
                self?.error = (error?.localizedDescription ?? "Unknown error")
                self?.hasError = true
            } else {
                self?.success = true
            }
        }
    }
    
}
