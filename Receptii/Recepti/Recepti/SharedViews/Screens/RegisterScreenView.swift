//
//  RegisterScreenView.swift
//  Recepti
//
//  Created by Digital Atrium on 8.1.23..
//

import Foundation
import SwiftUI

struct RegisterScreenView: View {
    
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        ZStack {
            ZStack{
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
            }.navigationBarHidden(true)
            VStack{
                Text("Register")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                TextField("Display name", text: $viewModel.displayName)
                    .padding()
                    .frame(height: 50)
                    .background(.black.opacity(0.05))
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .frame(height: 50)
                    .background(.black.opacity(0.05))
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .frame(height: 50)
                    .background(.black.opacity(0.05))
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
                Button("Register") {
                    viewModel.login()
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(.blue)
                .cornerRadius(12)
                .padding(.horizontal, 24)
                HStack{
                    Text("Already have an account?")
                    NavigationLink {
                        LoginScreenView()
                    } label: {
                        Text("Login")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }.padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .alert("Error", isPresented: $viewModel.hasError) {
            Button("OK") {
                viewModel.hasError = false
            }
        } message: {
            Text(viewModel.error)
        }

    }
}

struct RegisterScreenView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreenView()
    }
}
