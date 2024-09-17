//
//  ProfileView.swift
//  MrLogin
//
//  Created by apple on 17/09/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userDataService: UserDataService
    @EnvironmentObject var viewModel: LoginViewModel

    var body: some View {
        VStack {
            if viewModel.isLoggedIn, let user = userDataService.user {
                List {
                    HStack {
                        Spacer()
                        if let url = URL(string: user.image) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                        .frame(width: 100, height: 100)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                        .frame(width: 100, height: 100)
                                case .failure:
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        } else {
                            Image(systemName: "person.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                .padding()
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    Text("Name: \(user.firstName) \(user.lastName)")
                    Text("Email: \(user.email)")
                    Text("Gender: \(user.gender)")
                }
                .listStyle(InsetGroupedListStyle())
                
                Button("Logout") {
                    viewModel.logout()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            } else {
                Text("No user is logged in.")
            }
        }
        .themeBackground(color: Theme.backgroundColor)
    }
}

#Preview {
    ProfileView()
}
