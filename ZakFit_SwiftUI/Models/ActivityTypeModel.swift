//
//  ActivityTypeModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class ActivityType: Identifiable {
    var id: UUID
    var name: String
    var caloriesBurnedPerHour: Double
    var image: String

    init(id: UUID, name: String, caloriesBurnedPerHour: Double, image: String) {
        self.id = id
        self.name = name
        self.caloriesBurnedPerHour = caloriesBurnedPerHour
        self.image = image
    }
}
