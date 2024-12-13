//
//  ActivityTypeModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

struct ActivityType: Identifiable, Codable, Hashable {
    var id: UUID?
    var name: String
    var caloriesBurnedPerHour: Double
    var image: String

    init(id: UUID? = nil, name: String, caloriesBurnedPerHour: Double, image: String) {
        self.id = id ?? UUID()
        self.name = name
        self.caloriesBurnedPerHour = caloriesBurnedPerHour
        self.image = image
    }
    
    static func == (lhs: ActivityType, rhs: ActivityType) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id && lhs.caloriesBurnedPerHour == rhs.caloriesBurnedPerHour && lhs.image == rhs.image
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(id)
        hasher.combine(caloriesBurnedPerHour)
        hasher.combine(image)
    }
}
