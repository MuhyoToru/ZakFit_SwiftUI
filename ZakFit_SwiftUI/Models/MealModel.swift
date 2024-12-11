//
//  MealModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class Meal: Identifiable {
    var id: UUID?
    var name: String
    var date: Date
    var totalCalories: Double
    var totalProteins: Double
    var totalCarbohydrates: Double
    var totalLipids: Double
    var idMealType: UUID
    var idUser: UUID

    init(id: UUID? = nil, name: String, date: Date, totalCalories: Double, totalProteins: Double, totalCarbohydrates: Double, totalLipids: Double, idMealType: UUID, idUser: UUID) {
        self.id = id ?? UUID()
        self.name = name
        self.date = date
        self.totalCalories = totalCalories
        self.totalProteins = totalProteins
        self.totalCarbohydrates = totalCarbohydrates
        self.totalLipids = totalLipids
        self.idMealType = idMealType
        self.idUser = idUser
    }
}
