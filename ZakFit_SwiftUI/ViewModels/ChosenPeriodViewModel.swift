//
//  GenderViewModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import Foundation

class ChosenPeriodViewModel : ObservableObject {
    @Published var chosenPeriods : [ChosenPeriod] = []
    @Published var selectedCategory : ChosenPeriod = ChosenPeriod(name: "Aucune Sélection")
    private let baseUrl : String = "http://127.0.0.1:8081/chosenPeriods/"
    
    func fetch() {
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
                    let decodedChosenPeriods = try JSONDecoder().decode([ChosenPeriod].self, from: data)
                    DispatchQueue.main.async {
                        self.chosenPeriods = decodedChosenPeriods.sorted(by: { $0.name < $1.name })
                        self.selectedCategory = self.chosenPeriods.first!
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
