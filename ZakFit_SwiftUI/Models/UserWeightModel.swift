//
//  UserWeightModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class UserWeight: Identifiable {
    var id: UUID
    var weight: Double
    var date: Date
    var idUser: UUID

    init(id: UUID, weight: Double, date: Date, idUser: UUID) {
        self.id = id
        self.weight = weight
        self.date = date
        self.idUser = idUser
    }
}
