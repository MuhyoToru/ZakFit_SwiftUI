//
//  PhysicalActivityModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class PhysicalActivity: Identifiable {
    var id: UUID
    var date: Date
    var duration: Double
    var caloriesBurned: Double
    var idUser: UUID
    var idIntensity: UUID

    init(id: UUID, date: Date, duration: Double, caloriesBurned: Double, idUser: UUID, idIntensity: UUID) {
        self.id = id
        self.date = date
        self.duration = duration
        self.caloriesBurned = caloriesBurned
        self.idUser = idUser
        self.idIntensity = idIntensity
    }
}
