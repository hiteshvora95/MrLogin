//
//  APIManager.swift
//  MrLogin
//
//  Created by apple on 17/09/24.
//

import Foundation

class EndPoint {
    static var LOGIN: String = "\(AppStrings.BASE_URL)auth/login"
}

enum NetworkError: Error {
    case badURL
    case requestFailed(String)
    case invalidResponse(String)
    case decodingError(String)
    case errorMessage(String)
    
    var localizedDescription: String {
       switch self {
       case .badURL:
           return "The URL provided was invalid."
       case .requestFailed(let message):
           return "Request failed with message: \(message)"
       case .invalidResponse(let message):
           return "Response error with message: \(message)"
       case .decodingError(let message):
           return "Data parsing error with message: \(message)"
       case .errorMessage(let message):
           return message
       }
   }
}

final class APIManager {
    static let shared = APIManager()  // Singleton instance

    private init() {}

    func loginUser(username: String, password: String) async throws -> User {
        guard let url = URL(string: EndPoint.LOGIN) else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["username": username, "password": password]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse("Invalid response")
        }
        
        if (200...299).contains(httpResponse.statusCode) {
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: data)
                return user
            } catch {
                throw NetworkError.decodingError("User")
            }
        } else if (400...499).contains(httpResponse.statusCode) {
//            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                var message: String = ""
                
                if let dictionary = jsonObject as? [String: Any], let messageError = dictionary["message"] as? String {
                    message = messageError
                }
                
                throw NetworkError.errorMessage(message)
//            } catch {
//                throw NetworkError.invalidResponse("Unknown")
//            }
        } else {
            throw NetworkError.invalidResponse("Unknown")
        }
    }
}
