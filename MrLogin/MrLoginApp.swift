//
//  MrLoginApp.swift
//  MrLogin
//
//  Created by apple on 17/09/24.
//

import SwiftUI

@main
struct MrLoginApp: App {
    @StateObject private var userDataService = UserDataService()

    init() {
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().tintColor = UIColor.black
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().tintColor = UIColor.black
        UITableView.appearance().backgroundColor = UIColor.white
        UILabel.appearance().textColor = UIColor.black
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userDataService)
                .environmentObject(LoginViewModel(userDataService: userDataService))
        }
    }
}
