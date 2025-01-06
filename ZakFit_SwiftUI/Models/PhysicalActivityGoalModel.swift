//
//  PhysicalActivityGoalModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class PhysicalActivityGoal: Goal {
    var activityFrequency: Int
    var caloriesBurned: Double
    var sessionDuration: Double
    var progressionWanted: Double
    
    init(activityFrequency: Int, caloriesBurned: Double, sessionDuration: Double, progressionWanted: Double, dateStart: Date, idChosenPeriod: UUID, idUser: UUID) {
        self.activityFrequency = activityFrequency
        self.caloriesBurned = caloriesBurned
        self.sessionDuration = sessionDuration
        self.progressionWanted = progressionWanted
        super.init(dateStart: dateStart, idChosenPeriod: idChosenPeriod, idUser: idUser)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        activityFrequency = try container.decode(Int.self, forKey: .activityFrequency)
        caloriesBurned = try container.decode(Double.self, forKey: .caloriesBurned)
        sessionDuration = try container.decode(Double.self, forKey: .sessionDuration)
        progressionWanted = try container.decode(Double.self, forKey: .progressionWanted)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case activityFrequency
        case caloriesBurned
        case sessionDuration
        case progressionWanted
    }
}
