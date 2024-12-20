//
//  GenderViewModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import Foundation

class AQMealLinkViewModel : ObservableObject {
    private let baseUrl : String = "http://127.0.0.1:8081/aqMealLinks/"
    
    func onlyCreateAQ(alimentQuantity : AlimentQuantity, meal: Meal) {
        guard let url = URL(string: baseUrl + "onlyCreateAQ/") else {
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
        
        let payload: [String: Any] = [
                "alimentQuantity": [
                    "id": alimentQuantity.id!.uuidString,
                    "quantity": alimentQuantity.quantity,
                    "weightOrUnit": alimentQuantity.weightOrUnit,
                    "idAliment": alimentQuantity.idAliment.uuidString
                ],
                "meal": [
                    "id": meal.id!.uuidString,
                    "name": meal.name,
                    "date": ISO8601DateFormatter().string(from: meal.date),
                    "image": meal.image ?? "",
                    "totalCalories": meal.totalCalories,
                    "totalProteins": meal.totalProteins,
                    "totalCarbohydrates": meal.totalCarbohydrates,
                    "totalLipids": meal.totalLipids,
                    "idUser": meal.idUser.uuidString,
                    "idMealType": meal.idMealType.uuidString
                ]
            ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        } catch {
            fatalError("Erreur de serialisation en JSON")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let responseHTTP = response as? HTTPURLResponse
            if  responseHTTP?.statusCode != 200 {
                print("Creation AQMealLink failed")
                return
            }
            print("Creation AQMealLink successful")
        }.resume()
    }
    
    func createAQCreateMeal(alimentQuantity : AlimentQuantity, meal: Meal) {
        guard let url = URL(string: baseUrl + "createAQCreateMeal/") else {
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
        
        let payload: [String: Any] = [
                "alimentQuantity": [
                    "id": alimentQuantity.id!.uuidString,
                    "quantity": alimentQuantity.quantity,
                    "weightOrUnit": alimentQuantity.weightOrUnit,
                    "idAliment": alimentQuantity.idAliment.uuidString
                ],
                "meal": [
                    "id": meal.id!.uuidString,
                    "name": meal.name,
                    "date": ISO8601DateFormatter().string(from: meal.date),
                    "image": meal.image ?? "",
                    "totalCalories": meal.totalCalories,
                    "totalProteins": meal.totalProteins,
                    "totalCarbohydrates": meal.totalCarbohydrates,
                    "totalLipids": meal.totalLipids,
                    "idUser": meal.idUser.uuidString,
                    "idMealType": meal.idMealType.uuidString
                ]
            ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        } catch {
            fatalError("Erreur de serialisation en JSON")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let responseHTTP = response as? HTTPURLResponse
            if  responseHTTP?.statusCode != 200 {
                print("Creation AQMealLink failed")
                return
            }
            print("Creation AQMealLink successful")
        }.resume()
    }
    
    func createAQUpdateMeal(alimentQuantity : AlimentQuantity, oldMeal: Meal, newMeal: Meal) {
        guard let url = URL(string: baseUrl + "createAQUpdateMeal/") else {
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
        
        let payload: [String: Any] = [
                "alimentQuantity": [
                    "id": alimentQuantity.id!.uuidString,
                    "quantity": alimentQuantity.quantity,
                    "weightOrUnit": alimentQuantity.weightOrUnit,
                    "idAliment": alimentQuantity.idAliment.uuidString
                ],
                "meal": [
                    "id": oldMeal.id!.uuidString,
                    "name": newMeal.name,
                    "date": ISO8601DateFormatter().string(from: newMeal.date),
                    "image": newMeal.image ?? "",
                    "totalCalories": newMeal.totalCalories,
                    "totalProteins": newMeal.totalProteins,
                    "totalCarbohydrates": newMeal.totalCarbohydrates,
                    "totalLipids": newMeal.totalLipids,
                    "idUser": newMeal.idUser.uuidString,
                    "idMealType": newMeal.idMealType.uuidString
                ]
            ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        } catch {
            fatalError("Erreur de serialisation en JSON")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let responseHTTP = response as? HTTPURLResponse
            if  responseHTTP?.statusCode != 200 {
                print("Creation AQMealLink failed")
                return
            }
            print("Creation AQMealLink successful")
        }.resume()
    }
    
    func updateAQUpdateMeal(oldAlimentQuantity: AlimentQuantity, newAlimentQuantity: AlimentQuantity, oldMeal: Meal, newMeal: Meal) {
        guard let url = URL(string: baseUrl + "updateAQUpdateMeal/") else {
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
        
        let payload: [String: Any] = [
                "alimentQuantity": [
                    "id": oldAlimentQuantity.id!.uuidString,
                    "quantity": newAlimentQuantity.quantity,
                    "weightOrUnit": newAlimentQuantity.weightOrUnit,
                    "idAliment": newAlimentQuantity.idAliment.uuidString
                ],
                "meal": [
                    "id": oldMeal.id!.uuidString,
                    "name": newMeal.name,
                    "date": ISO8601DateFormatter().string(from: newMeal.date),
                    "image": newMeal.image ?? "",
                    "totalCalories": newMeal.totalCalories,
                    "totalProteins": newMeal.totalProteins,
                    "totalCarbohydrates": newMeal.totalCarbohydrates,
                    "totalLipids": newMeal.totalLipids,
                    "idUser": newMeal.idUser.uuidString,
                    "idMealType": newMeal.idMealType.uuidString
                ]
            ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        } catch {
            fatalError("Erreur de serialisation en JSON")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let responseHTTP = response as? HTTPURLResponse
            if  responseHTTP?.statusCode != 200 {
                print("Creation AQMealLink failed")
                return
            }
            print("Creation AQMealLink successful")
        }.resume()
    }
}
