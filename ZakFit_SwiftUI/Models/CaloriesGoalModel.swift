//
//  CaloriesGoalModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class CaloriesGoal: Goal {
    var caloriesGoal: Double
    var proteinsGoal: Double
    var carbohydratesGoal: Double
    var lipidsGoal: Double

    init(caloriesGoal: Double, proteinsGoal: Double, carbohydratesGoal: Double, lipidsGoal: Double, dateStart: Date, idChosenPeriod: UUID, idUser: UUID) {
        self.caloriesGoal = caloriesGoal
        self.proteinsGoal = proteinsGoal
        self.carbohydratesGoal = carbohydratesGoal
        self.lipidsGoal = lipidsGoal
        super.init(dateStart: dateStart, idChosenPeriod: idChosenPeriod, idUser: idUser)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        caloriesGoal = try container.decode(Double.self, forKey: .caloriesGoal)
        proteinsGoal = try container.decode(Double.self, forKey: .proteinsGoal)
        carbohydratesGoal = try container.decode(Double.self, forKey: .carbohydratesGoal)
        lipidsGoal = try container.decode(Double.self, forKey: .lipidsGoal)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case caloriesGoal
        case proteinsGoal
        case carbohydratesGoal
        case lipidsGoal
    }
}
