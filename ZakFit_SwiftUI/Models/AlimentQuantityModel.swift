//
//  AlimentQuantityModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class AlimentQuantity: Identifiable {
    var id: UUID
    var quantity: Int
    var weightOrUnit: String
    var idAliment: UUID

    init(id: UUID, quantity: Int, weightOrUnit: String, idAliment: UUID) {
        self.id = id
        self.quantity = quantity
        self.weightOrUnit = weightOrUnit
        self.idAliment = idAliment
    }
}
