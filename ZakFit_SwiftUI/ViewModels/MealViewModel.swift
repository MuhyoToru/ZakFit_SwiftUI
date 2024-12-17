//
//  GenderViewModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import Foundation

class MealViewModel : ObservableObject {
    @Published var meals : [Meal] = []
    private let baseUrl : String = "http://127.0.0.1:8081/meals/"
    
    func fetch(filters: Filter) {
        var modifyUrl : String = baseUrl
        var queryUrl : String = ""
        
        if filters.date != nil {
            let dateString : String = filters.date!.ISO8601Format()
            queryUrl += "date=\(dateString.split(separator: "T").first!)"
        }

        if queryUrl != "" {
            queryUrl = "?" + queryUrl
            modifyUrl += queryUrl
            print(modifyUrl)
        }
        
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
                    let decodedMeals = try decoder.decode([Meal].self, from: data)
                    DispatchQueue.main.async {
                        self.meals = decodedMeals.sorted(by: { $0.date < $1.date })
                    }
                } catch {
                    print("Error decoding data : \(error)")
                }
            } else if let error = error {
                print("Error fetching data : \(error)")
            }
        }.resume()
    }
    
    func update(oldMeal : Meal, newMeal : Meal) {
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
            request.httpBody = try JSONSerialization.data(withJSONObject: ["id": oldMeal.id!.uuidString, "name": newMeal.name, "date": ISO8601DateFormatter().string(from: newMeal.date), "totalCalories" : newMeal.totalCalories, "totalProteins" : newMeal.totalProteins, "totalCarbohydrates" : newMeal.totalCarbohydrates, "totalLipids" : newMeal.totalLipids, "idUser": newMeal.idUser.uuidString, "idMealType": newMeal.idMealType.uuidString])
        } catch {
            fatalError("Erreur de serialisation en JSON")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let responseHTTP = response as? HTTPURLResponse
            if  responseHTTP?.statusCode != 200 {
                print("Update Meal failed")
                return
            }
            print("Update Meal successful")
            
            self.fetch(filters: Filter())
        }.resume()
    }
}
