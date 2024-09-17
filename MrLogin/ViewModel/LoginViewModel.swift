//
//  LoginViewModel.swift
//  MrLogin
//
//  Created by apple on 17/09/24.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var usernameError: String?
    @Published var passwordError: String?
    @Published var isLoggedIn: Bool = false

    private let apiManager = APIManager.shared
    private let userDataService: UserDataService
    
    init(userDataService: UserDataService) {
        self.userDataService = userDataService
        self.isLoggedIn = userDataService.user != nil
    }
    
    func login(username: String, password: String) {
        isLoading = true
        errorMessage = nil
        usernameError = nil
        passwordError = nil
        
        let usernameValidationResult = validateUsername(username)
        let passwordValidationResult = validatePassword(password)
        
        if let usernameError = usernameValidationResult {
            self.usernameError = usernameError
            self.isLoading = false
            return
        }
        if let passwordError = passwordValidationResult {
            self.passwordError = passwordError
            self.isLoading = false
            return
        }
        
        Task {
            do {
                let fetchedUser = try await apiManager.loginUser(username: username, password: password)
                DispatchQueue.main.async {
                    self.userDataService.user = fetchedUser
                    self.isLoggedIn = true
                }
            } catch {
                DispatchQueue.main.async {
                    if let networkError = error as? NetworkError {
                        self.errorMessage = "Login failed: \(networkError.localizedDescription)"
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    func logout() {
        self.userDataService.clearUser()
        self.isLoggedIn = false
    }
    
    private func validateUsername(_ username: String) -> String? {
        if username.isEmpty {
            return "Username cannot be empty."
        }
        return nil
    }
    
    private func validatePassword(_ password: String) -> String? {
        if password.isEmpty {
            return "Password cannot be empty."
        }
        return nil
    }
}
