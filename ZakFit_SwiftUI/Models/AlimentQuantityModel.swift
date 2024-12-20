//
//  AlimentQuantityModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class AlimentQuantity: Identifiable, Codable, Equatable {
    var id: UUID?
    var quantity: Double
    var weightOrUnit: String
    var idAliment: UUID

    init(id: UUID? = nil, quantity: Double, weightOrUnit: String, idAliment: UUID) {
        self.id = id ?? UUID()
        self.quantity = quantity
        self.weightOrUnit = weightOrUnit
        self.idAliment = idAliment
    }
    
    static func == (lhs: AlimentQuantity, rhs: AlimentQuantity) -> Bool {
        return lhs.id == rhs.id && lhs.quantity == rhs.quantity && lhs.weightOrUnit == rhs.weightOrUnit && lhs.idAliment == rhs.idAliment
    }
    
    func verifyQuantity() -> Bool {
        if self.quantity <= 0 {
            return false
        }
        
        return true
    }
    
    func verifyWeightOrUnit() -> Bool {
        switch self.weightOrUnit {
        case "weight" :
            return true
        case "unit" :
            return true
        default :
            return false
        }
    }
}
