//
//  User.swift
//  MrLogin
//
//  Created by apple on 17/09/24.
//

import Foundation

struct User: Codable {
    let id: Int
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    let gender: String
    let image: String
    let token: String
    let refreshToken: String
}

class UserDataService: ObservableObject {
    private let userDefaults = UserDefaults.standard
    private let userKey = "User"
    
    @Published var user: User? {
        didSet {
            saveUser(user)
        }
    }
    
    init() {
        loadUser()
    }
    
    func saveUser(_ user: User?) {
        let encoder = JSONEncoder()
        if let user = user {
            if let encoded = try? encoder.encode(user) {
                userDefaults.set(encoded, forKey: userKey)
            }
        } else {
            userDefaults.removeObject(forKey: userKey)
        }
    }
    
    private func loadUser() {
        if let savedUserData = userDefaults.object(forKey: userKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.self, from: savedUserData) {
                self.user = loadedUser
            }
        }
    }
    
    func clearUser() {
        self.user = nil
    }
}
