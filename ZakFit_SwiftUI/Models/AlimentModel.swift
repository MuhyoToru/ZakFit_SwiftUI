//
//  AlimentModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

final class Aliment: Identifiable {
    var id: UUID
    var name: String
    var description: String
    var image: String
    var caloriesKg: Double?
    var caloriesUnit: Double?
    var proteins: Double?
    var carbohydrates: Double?
    var lipids: Double?

    init(id: UUID, name: String, description: String, image: String, caloriesKg: Double? = nil, caloriesUnit: Double? = nil, proteins: Double? = nil, carbohydrates: Double? = nil, lipids: Double? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
        self.caloriesKg = caloriesKg
        self.caloriesUnit = caloriesUnit
        self.proteins = proteins
        self.carbohydrates = carbohydrates
        self.lipids = lipids
    }
}
