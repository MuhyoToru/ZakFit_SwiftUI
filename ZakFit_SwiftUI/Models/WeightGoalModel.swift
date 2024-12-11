//
//  WeightGoalModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class WeightGoal: Identifiable {
    var id: UUID?
    var weight: Double
    var idChosenPeriod: UUID
    var idUser: UUID

    init(id: UUID? = nil, weight: Double, idChosenPeriod: UUID, idUser: UUID) {
        self.id = id ?? UUID()
        self.weight = weight
        self.idChosenPeriod = idChosenPeriod
        self.idUser = idUser
    }
    
    func editGoals() {
        
    }
}
