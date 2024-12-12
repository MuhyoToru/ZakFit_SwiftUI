//
//  GenderViewModel 2.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 09/12/2024.
//


import Foundation

class PhysicalActivityViewModel : ObservableObject {
    @Published var physicalActivitys : [PhysicalActivity] = []
    let baseUrl : String = "http://127.0.0.1:8081/physicalActivitys/"
    
    func fetch() {
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
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decodedPhysicalActivitys = try decoder.decode([PhysicalActivity].self, from: data)
                    DispatchQueue.main.async {
                        self.physicalActivitys = decodedPhysicalActivitys.sorted(by: { $0.date > $1.date })
                    }
                } catch {
                    print("Error decoding data : \(error)")
                }
            } else if let error = error {
                print("Error fetching data : \(error)")
            }
        }.resume()
    }
    
    func create(weight : Double) {
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
            
            self.fetch()
        }.resume()
    }
    
    func update(userWeight: UserWeight, newWeight : Double) {
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
            request.httpBody = try JSONSerialization.data(withJSONObject: ["id": userWeight.id!.uuidString,"weight": newWeight, "date": ISO8601DateFormatter().string(from: userWeight.date)])
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
            
            self.fetch()
        }.resume()
    }
}
