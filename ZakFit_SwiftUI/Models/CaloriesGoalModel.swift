//
//  CaloriesGoalModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class CaloriesGoal: Identifiable {
    var id: UUID?
    var caloriesGoal: Double
    var proteinsGoal: Double
    var carbohydratesGoal: Double
    var lipidsGoal: Double
    var idChosenPeriod: UUID
    var idUser: UUID

    init(id: UUID? = nil, caloriesGoal: Double, proteinsGoal: Double, carbohydratesGoal: Double, lipidsGoal: Double, idChosenPeriod: UUID, idUser: UUID) {
        self.id = id ?? UUID()
        self.caloriesGoal = caloriesGoal
        self.proteinsGoal = proteinsGoal
        self.carbohydratesGoal = carbohydratesGoal
        self.lipidsGoal = lipidsGoal
        self.idChosenPeriod = idChosenPeriod
        self.idUser = idUser
    }
}
