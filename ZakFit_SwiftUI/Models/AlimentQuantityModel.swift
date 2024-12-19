//
//  AlimentQuantityModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class AlimentQuantity: Identifiable, Codable {
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
