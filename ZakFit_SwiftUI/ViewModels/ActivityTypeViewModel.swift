//
//  GenderViewModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 06/12/2024.
//

import Foundation

class ActivityTypeViewModel : ObservableObject {
    @Published var activityTypes : [ActivityType] = []
    @Published var selectedCategory : ActivityType = ActivityType(name: "Aucune activité", caloriesBurnedPerHour: 0, image: "ZF_fullLogo")
    let baseUrl : String = "http://127.0.0.1:8081/activityTypes/"
    
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
                    let decodedActivityTypes = try JSONDecoder().decode([ActivityType].self, from: data)
                    DispatchQueue.main.async {
                        self.activityTypes = decodedActivityTypes.sorted(by: { $0.name < $1.name })
                        self.selectedCategory = self.activityTypes.first!
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
