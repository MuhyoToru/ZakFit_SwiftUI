//
//  UserWeightModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class UserWeight: Identifiable, Codable, Equatable {
    var id: UUID?
    var weight: Double
    var date: Date
    var idUser: UUID?

    init(id: UUID? = nil, weight: Double, date: Date, idUser: UUID? = nil) {
        self.id = id ?? UUID()
        self.weight = weight
        self.date = date
        self.idUser = idUser
    }
    
    static func == (lhs: UserWeight, rhs: UserWeight) -> Bool {
        return lhs.weight == rhs.weight && lhs.id == rhs.id && lhs.date == rhs.date && lhs.idUser == rhs.idUser
    }
    
    func verifyWeight(weight : String) -> Bool {
        if weight == "" {
            return false
        }
        
        if Double(weight) ?? 0 > 0 {
            self.weight = Double(weight) ?? 0
            return true
        }
        
        return false
    }
}
