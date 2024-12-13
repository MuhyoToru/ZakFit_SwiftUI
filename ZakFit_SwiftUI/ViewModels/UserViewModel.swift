//
//  UserViewModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: User = User(name: "", firstname: "", email: "", size: 0, birthday: Date.now, notificationTime: "18:00")
    @Published var isLoggedIn: Bool = false
    
    private let baseUrl: String = "http://127.0.0.1:8081/users/"
    
    func register(user : User, password : String) {
        //Configurer l'url
        let url = URL(string : baseUrl)!
        var request = URLRequest(url: url)
        
        //Configurer la requête
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Ajouter les identifiants dans le body
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: ["name" : user.name, "firstname" : user.firstname, "email": user.email, "size": user.size, "birthday": ISO8601DateFormatter().string(from: user.birthday), "notificationTime": user.notificationTime, "password": password, "idFoodPreference": user.idFoodPreference!.uuidString, "idGender": user.idGender!.uuidString])
        } catch {
            fatalError("Erreur de serialisation en JSON")
        }
        
        //Exécuter la requête
        URLSession.shared.dataTask(with: request) { data, response, error in
            let responseHTTP = response as? HTTPURLResponse
            if  responseHTTP?.statusCode != 200 {
                print("Registration failed")
                return
            }
            print("Registration successful")
        }.resume()
    }
    
    func login(email : String, password : String) {
        let url = URL(string : baseUrl + "login/")!
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let authData = "\(email):\(password)".data(using: .utf8)?.base64EncodedString() else {
            print("Error : Impossible to encode in Base64")
            return
        }
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            do {
                let token = try JSONDecoder().decode(JWToken.self, from: data)
                KeychainManager.saveTokenToKeychain(token: token.token)
                print("Login successful")
            } catch {
                print("Error decoding Token")
            }
        
            DispatchQueue.main.async {
                self.isLoggedIn = true
            }
            
            self.getById()
        }.resume()
    }
    
    func getById() {
        guard let url = URL(string: baseUrl + "id/") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let token = KeychainManager.getTokenFromKeychain() else {
            print("No Token found")
            return
        }
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decodedUser = try decoder.decode(User.self, from: data)
                    DispatchQueue.main.async {
                        self.user = decodedUser
                    }
                } catch {
                    print("Error decoding data: \(data)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }
    
    func logOut() {
        DispatchQueue.main.async {
            self.isLoggedIn = false
            KeychainManager.deleteTokenFromKeychain()
        }
    }
    
    func verifyIfLoggedIn() {
        guard let url = URL(string: baseUrl + "id/") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let token = KeychainManager.getTokenFromKeychain() else {
            print("No Token found")
            return
        }
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decodedUser = try decoder.decode(User.self, from: data)
                    DispatchQueue.main.async {
                        self.user = decodedUser
                        self.isLoggedIn = true
                    }
                } catch {
                    KeychainManager.deleteTokenFromKeychain()
                    print("Error decoding data: \(data)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }
    
    func update(user: User) {
        guard let url = URL(string: baseUrl + "update/") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let token = KeychainManager.getTokenFromKeychain() else {
            print("No Token found")
            return
        }
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: ["name" : user.name, "firstname" : user.firstname, "email": user.email, "size": user.size, "birthday": ISO8601DateFormatter().string(from: user.birthday), "notificationTime": user.notificationTime, "idFoodPreference": user.idFoodPreference!.uuidString, "idGender": user.idGender!.uuidString])
        } catch {
            fatalError("Erreur de serialisation en JSON")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let responseHTTP = response as? HTTPURLResponse
            if  responseHTTP?.statusCode != 200 {
                print("Update failed")
                return
            }
            print("Update successful")
            
            self.getById()
        }.resume()
    }
}
