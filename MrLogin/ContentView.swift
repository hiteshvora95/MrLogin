//
//  ContentView.swift
//  MrLogin
//
//  Created by apple on 17/09/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        Group {
            if viewModel.isLoggedIn {
                ProfileView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
