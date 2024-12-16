//
//  GenderViewModel 2.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 09/12/2024.
//


import Foundation

class PhysicalActivityViewModel : ObservableObject {
    @Published var physicalActivitys : [PhysicalActivity] = []
    private let baseUrl : String = "http://127.0.0.1:8081/physicalActivitys/"
    
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
                        self.physicalActivitys = decodedPhysicalActivitys.sorted(by: { $0.date < $1.date })
                    }
                } catch {
                    print("Error decoding data : \(error)")
                }
            } else if let error = error {
                print("Error fetching data : \(error)")
            }
        }.resume()
    }
    
    func update(oldPhysicalActivity : PhysicalActivity, newPhysicalActivity : PhysicalActivity) {
        let url = URL(string : baseUrl + "update/")!
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let token = KeychainManager.getTokenFromKeychain() else {
            print("No Token found")
            return
        }
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: ["id": oldPhysicalActivity.id!.uuidString, "duration": newPhysicalActivity.duration, "date": ISO8601DateFormatter().string(from: newPhysicalActivity.date), "caloriesBurned" : newPhysicalActivity.caloriesBurned, "idUser": newPhysicalActivity.idUser.uuidString, "idIntensity": newPhysicalActivity.idIntensity.uuidString, "idActivityType": newPhysicalActivity.idActivityType.uuidString])
        } catch {
            fatalError("Erreur de serialisation en JSON")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let responseHTTP = response as? HTTPURLResponse
            if  responseHTTP?.statusCode != 200 {
                print("Update PhysicalActivity failed")
                return
            }
            print("Update PhysicalActivity successful")
            
            self.fetch()
        }.resume()
    }
    
    func create(physicalActivity : PhysicalActivity) {
        guard let url = URL(string: baseUrl + "create/") else {
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
            request.httpBody = try JSONSerialization.data(withJSONObject: ["duration": physicalActivity.duration, "date": ISO8601DateFormatter().string(from: physicalActivity.date), "caloriesBurned" : physicalActivity.caloriesBurned, "idUser": physicalActivity.idUser.uuidString, "idIntensity": physicalActivity.idIntensity.uuidString, "idActivityType": physicalActivity.idActivityType.uuidString])
        } catch {
            fatalError("Erreur de serialisation en JSON")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let responseHTTP = response as? HTTPURLResponse
            if  responseHTTP?.statusCode != 200 {
                print("Creation PhysicalActivity failed")
                return
            }
            print("Creation PhysicalActivity successful")
            
            self.fetch()
        }.resume()
    }
}
