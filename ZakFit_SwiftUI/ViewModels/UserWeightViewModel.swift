//
//  GenderViewModel 2.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 09/12/2024.
//


import Foundation

class UserWeightViewModel : ObservableObject {
    @Published var userWeights : [UserWeight] = []
    let baseUrl : String = "http://127.0.0.1:8081/userWeights/"
    
    func fetchUserWeights() {
        guard let url = URL(string: "\(baseUrl)") else {
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
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedUserWeights = try JSONDecoder().decode([UserWeight].self, from: data)
                    DispatchQueue.main.async {
                        self.userWeights = decodedUserWeights.sorted(by: { $0.date < $1.date })
                    }
                } catch {
                    print("Error decoding data : \(error)")
                }
            } else if let error = error {
                print("Error fetching data : \(error)")
            }
        }.resume()
    }
    
    func createUserWeight(weight : Double) {
        let url = URL(string : baseUrl + "create/")!
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let token = KeychainManager.getTokenFromKeychain() else {
            print("No Token found")
            return
        }
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: ["weight": weight, "date": ISO8601DateFormatter().string(from: Date.now)])
        } catch {
            fatalError("Erreur de serialisation en JSON")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let responseHTTP = response as? HTTPURLResponse
            if  responseHTTP?.statusCode != 200 {
                print("Creation UserWeight failed")
                return
            }
            print("Creation UserWeight successful")
            
            self.fetchUserWeights()
        }.resume()
    }
}
