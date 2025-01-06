//
//  GoalModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 20/12/2024.
//

import Foundation

class Goal: Identifiable, Codable {
    var id: UUID?
    var dateStart: Date
    var idChosenPeriod: UUID
    var idUser: UUID
    
    init(id: UUID? = nil, dateStart: Date, idChosenPeriod: UUID, idUser: UUID) {
        self.id = id ?? UUID()
        self.dateStart = dateStart
        self.idChosenPeriod = idChosenPeriod
        self.idUser = idUser
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dateStart = try container.decode(Date.self, forKey: .dateStart)
        idChosenPeriod = try container.decode(UUID.self, forKey: .idChosenPeriod)
        idUser = try container.decode(UUID.self, forKey: .idUser)
    }
    
    private enum CodingKeys: String, CodingKey {
        case dateStart
        case idChosenPeriod
        case idUser
    }
    
    func verifyDate() -> Bool {
        if self.dateStart < Date.now {
            return false
        }
        
        return true
    }
}
