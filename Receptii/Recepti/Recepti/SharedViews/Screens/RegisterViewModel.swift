//
//  RegisterViewModel.swift
//  Recepti
//
//  Created by Digital Atrium on 8.1.23..
//

import Foundation
import FirebaseAuth
import FirebaseCore

class RegisterViewModel: ObservableObject{
    
    @Published var displayName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String = ""
    @Published var success: Bool = false
    @Published var hasError = false
    
    func login() {
        Auth.auth().createUser(withEmail: email, password: password){ [weak self] (result, error) in
            if error != nil {
                self?.error = (error?.localizedDescription ?? "Unknown error")
                self?.hasError = true
            } else {
                Task{
                    do{
                        if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                            changeRequest.displayName = self?.displayName
                            try await changeRequest.commitChanges()
                            try await Auth.auth().currentUser?.reload()
                        }
                    }catch(let error){
                        debugPrint(error)
                    }
                }
                self?.success = true
            }
        }
    }
    
}
