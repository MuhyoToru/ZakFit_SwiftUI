//
//  GenderViewModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import Foundation

class AlimentViewModel : ObservableObject {
    @Published var aliments : [Aliment] = []
    @Published var selectedCategory : Aliment = Aliment(name: "Pas d'aliment", description: "Pas de description", image: "")
    private let baseUrl : String = "http://127.0.0.1:8081/aliments/"
    
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
                    let decodedAliments = try JSONDecoder().decode([Aliment].self, from: data)
                    DispatchQueue.main.async {
                        self.aliments = decodedAliments.sorted(by: { $0.name < $1.name })
                        self.selectedCategory = self.aliments.first!
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
