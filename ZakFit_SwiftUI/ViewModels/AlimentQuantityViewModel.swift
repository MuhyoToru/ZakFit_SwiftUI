//
//  GenderViewModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import Foundation

class AlimentQuantityViewModel : ObservableObject {
    @Published var meals : [AlimentQuantity] = []
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
                        self.meals = decodedAlimentQuantitys.sorted(by: { $0.quantity < $1.quantity })
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
