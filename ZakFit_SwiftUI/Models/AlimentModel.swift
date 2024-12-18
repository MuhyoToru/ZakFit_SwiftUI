//
//  AlimentModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class Aliment: Identifiable, Codable, Hashable {
    var id: UUID?
    var name: String
    var description: String
    var image: String
    var caloriesKg: Double?
    var caloriesUnit: Double?
    var proteins: Double?
    var carbohydrates: Double?
    var lipids: Double?

    init(id: UUID? = nil, name: String, description: String, image: String, caloriesKg: Double? = nil, caloriesUnit: Double? = nil, proteins: Double? = nil, carbohydrates: Double? = nil, lipids: Double? = nil) {
        self.id = id ?? UUID()
        self.name = name
        self.description = description
        self.image = image
        self.caloriesKg = caloriesKg
        self.caloriesUnit = caloriesUnit
        self.proteins = proteins
        self.carbohydrates = carbohydrates
        self.lipids = lipids
    }
    
    static func == (lhs: Aliment, rhs: Aliment) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.description == rhs.description && lhs.image == rhs.image && lhs.caloriesKg == rhs.caloriesKg && lhs.caloriesUnit == rhs.caloriesUnit && lhs.proteins == rhs.proteins && lhs.carbohydrates == rhs.carbohydrates && lhs.lipids == rhs.lipids
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(description)
        hasher.combine(image)
        hasher.combine(caloriesKg)
        hasher.combine(caloriesUnit)
        hasher.combine(proteins)
        hasher.combine(carbohydrates)
        hasher.combine(lipids)
    }
}
