//
//  GenderViewModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import Foundation

class FoodPreferenceViewModel : ObservableObject {
    @Published var foodPreferences : [FoodPreference] = []
    @Published var selectedCategory : FoodPreference = FoodPreference(name: "Aucune Sélection")
    let baseUrl : String = "http://127.0.0.1:8081/foodPreferences/"
    
    func fetchFoodPreferences() {
        guard let url = URL(string: "\(baseUrl)") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedFoodPreferences = try JSONDecoder().decode([FoodPreference].self, from: data)
                    DispatchQueue.main.async {
                        self.foodPreferences = decodedFoodPreferences.sorted(by: { $0.name < $1.name })
                        self.selectedCategory = self.foodPreferences.first!
                    }
                } catch {
                    print("Error decoding data : \(error)")
                }
            } else if let error = error {
                print("Error fetching data : \(error)")
            }
        }.resume()
    }
}
