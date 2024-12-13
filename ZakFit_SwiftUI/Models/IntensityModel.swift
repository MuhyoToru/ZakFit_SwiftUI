//
//  IntensityModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

struct Intensity: Identifiable, Codable, Hashable {
    var id: UUID?
    var name: String

    init(id: UUID? = nil, name: String) {
        self.id = id ?? UUID()
        self.name = name
    }
    
    static func == (lhs: Intensity, rhs: Intensity) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(id)
    }
}
