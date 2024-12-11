//
//  PhysicalActivityGoalModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class PhysicalActivityGoal: Identifiable {
    var id: UUID?
    var activityFrequency: Int
    var caloriesBurned: Double
    var sessionDuration: Double
    var progressionWanted: Double
    var idChosenPeriod: UUID
    var idUser: UUID

    init(id: UUID? = nil, activityFrequency: Int, caloriesBurned: Double, sessionDuration: Double, progressionWanted: Double, idChosenPeriod: UUID, idUser: UUID) {
        self.id = id ?? UUID()
        self.activityFrequency = activityFrequency
        self.caloriesBurned = caloriesBurned
        self.sessionDuration = sessionDuration
        self.progressionWanted = progressionWanted
        self.idChosenPeriod = idChosenPeriod
        self.idUser = idUser
    }
}
