//
//  WeightGoalModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class WeightGoal: Goal {
    var weight: Double
    
    init(weight: Double, dateStart: Date, idChosenPeriod: UUID, idUser: UUID) {
        self.weight = weight
        super.init(dateStart: dateStart, idChosenPeriod: idChosenPeriod, idUser: idUser)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        weight = try container.decode(Double.self, forKey: .weight)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case weight
    }
}
