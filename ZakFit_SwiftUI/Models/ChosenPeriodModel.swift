//
//  ChosenPeriodModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

struct ChosenPeriod: Identifiable, Codable, Hashable {
    var id: UUID?
    var name: String

    init(id : UUID? = nil, name: String) {
        self.id = id ?? UUID()
        self.name = name
    }
    
    static func == (lhs: ChosenPeriod, rhs: ChosenPeriod) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
