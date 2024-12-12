//
//  ActivityTypeModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class ActivityType: Identifiable, Codable {
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
}
