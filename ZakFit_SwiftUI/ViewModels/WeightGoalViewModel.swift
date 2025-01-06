//
//  UserViewModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import Foundation

class WeightGoalViewModel: ObservableObject {
    @Published var weightGoal: WeightGoal? /* = WeightGoal(weight: 0, idChosenPeriod: UUID(), idUser: UUID())*/
    
    private let baseUrl: String = "http://127.0.0.1:8081/weightGoals/"
    
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
                    let decodedWeightGoal = try decoder.decode(WeightGoal.self, from: data)
                    DispatchQueue.main.async {
                        self.weightGoal = decodedWeightGoal
                    }
                } catch {
                    print("Error decoding data : \(error)")
                }
            } else if let error = error {
                print("Error fetching data : \(error)")
            }
        }.resume()
    }
    
    func create(weightGoal : WeightGoal) {
        
    }
    
    func update(weightGoal : WeightGoal) {
        
    }
}
