//
//  LoginView.swift
//  MrLogin
//
//  Created by apple on 17/09/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var viewModel: LoginViewModel
    
    @State private var username: String = "emilys"
    @State private var password: String = "emilyspass"
    @State private var loginSuccess: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Text("Welcome to My App")
                    .font(.system(size: 32, weight: .medium))
                
                Spacer()
                    .frame(height: 10)
                
                VStack(spacing: 12, content: {
                    MrInputField(textCase: .lowercase,
                                 leftImage: "person",
                                 placeholder: "Username",
                                 keyboardType: .emailAddress,
                                 textContentType: .emailAddress,
                                 text: $username)
                    if let usernameError = viewModel.usernameError {
                        Text(usernameError)
                            .foregroundColor(.red)
                    }
                })
                
                VStack(spacing: 12, content: {
                    MrInputField(textCase: .lowercase,
                                 leftImage: "lock",
                                 placeholder: "Password",
                                 keyboardType: .default,
                                 textContentType: .password,
                                 isSecureField: true,
                                 text: $password)
                    if let passwordError = viewModel.passwordError {
                        Text(passwordError)
                            .foregroundColor(.red)
                    }
                })
                
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    MrButton(title: "Sign In",
                             action: {
                                viewModel.login(username: username, password: password)
                        
                                if viewModel.isLoggedIn {
                                    loginSuccess = true
                                }
                            },
                            backgroundColor: Color.purple,
                            textColor: Color.white,
                            cornerRadius: 12
                    )
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text("\(errorMessage)")
                            .foregroundColor(.red)
                    }
                }
            }
            .padding(24)
            .navigationDestination(isPresented: $loginSuccess) {
                ProfileView()
            }
        }
        .themeBackground(color: Theme.backgroundColor)
    }
}

#Preview {
    LoginView()
}
