//
//  PhysicalActivityModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class PhysicalActivity: Identifiable, Codable {
    var id: UUID?
    var date: Date
    var duration: Double
    var caloriesBurned: Double
    var idUser: UUID
    var idIntensity: UUID
    var idActivityType: UUID

    init(id: UUID? = nil, date: Date, duration: Double, caloriesBurned: Double, idUser: UUID, idIntensity: UUID, idActivityType: UUID) {
        self.id = id ?? UUID()
        self.date = date
        self.duration = duration
        self.caloriesBurned = caloriesBurned
        self.idUser = idUser
        self.idIntensity = idIntensity
        self.idActivityType = idActivityType
    }
    
    func verifyDate() -> Bool {
        if date < Date.now {
            return false
        }
        
        return true
    }
    
    func verifyDuration() -> Bool {
        if duration <= 0 {
            return false
        }
        
        return true
    }
    
    func verifyCaloriesBurned() {
        print(caloriesBurned)
    }
}
