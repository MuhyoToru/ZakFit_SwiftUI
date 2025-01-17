//
//  GenderViewModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import Foundation

class AlimentQuantityViewModel : ObservableObject {
    @Published var alimentQuantitys : [AlimentQuantity] = []
    @Published var tempAlimentQuantitys : [AlimentQuantity] = []
    private let baseUrl : String = "http://127.0.0.1:8081/alimentQuantitys/"
    
    func fetch() {
        let modifyUrl : String = baseUrl
        
        guard let url = URL(string: "\(modifyUrl)") else {
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
                    let decodedAlimentQuantitys = try decoder.decode([AlimentQuantity].self, from: data)
                    DispatchQueue.main.async {
                        self.alimentQuantitys = decodedAlimentQuantitys.sorted(by: { $0.quantity < $1.quantity })
                        self.tempAlimentQuantitys = self.alimentQuantitys
                    }
                } catch {
                    print("Error decoding data : \(error)")
                }
            } else if let error = error {
                print("Error fetching data : \(error)")
            }
        }.resume()
    }
    
    func fetchByMealId(idMeal : UUID) {
        guard let url = URL(string: "\(baseUrl)idMeal/\(idMeal)/") else {
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
                    let decodedAlimentQuantitys = try decoder.decode([AlimentQuantity].self, from: data)
                    DispatchQueue.main.async {
                        self.alimentQuantitys = decodedAlimentQuantitys.sorted(by: { $0.quantity < $1.quantity })
                        self.tempAlimentQuantitys = self.alimentQuantitys
                    }
                } catch {
                    print("Error decoding data : \(error)")
                }
            } else if let error = error {
                print("Error fetching data : \(error)")
            }
        }.resume()
    }
    
    func create(alimentQuantity : AlimentQuantity) {
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
            request.httpBody = try JSONSerialization.data(withJSONObject: ["id": alimentQuantity.id!.uuidString, "quantity": alimentQuantity.quantity, "weightOrUnit": alimentQuantity.weightOrUnit, "idAliment" : alimentQuantity.idAliment.uuidString])
        } catch {
            fatalError("Erreur de serialisation en JSON")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let responseHTTP = response as? HTTPURLResponse
            if  responseHTTP?.statusCode != 200 {
                print("Creation AlimentQuantity failed")
                return
            }
            print("Creation AlimentQuantity successful")
            
            self.fetch()
        }.resume()
    }
    
    func update(oldAlimentQuantity : AlimentQuantity, newAlimentQuantity: AlimentQuantity) {
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
            request.httpBody = try JSONSerialization.data(withJSONObject: ["id": oldAlimentQuantity.id!.uuidString, "quantity": newAlimentQuantity.quantity, "weightOrUnit": newAlimentQuantity.weightOrUnit, "idAliment" : newAlimentQuantity.idAliment])
        } catch {
            fatalError("Erreur de serialisation en JSON")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let responseHTTP = response as? HTTPURLResponse
            if  responseHTTP?.statusCode != 200 {
                print("Update AlimentQuantity failed")
                return
            }
            print("Update AlimentQuantity successful")
            
            self.fetch()
        }.resume()
    }
}
