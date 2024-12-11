//
//  NotificationModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class Notification: Identifiable {
    var id: UUID?
    var message: String
    var idNotificationType: UUID

    init(id: UUID? = nil, message: String, idNotificationType: UUID) {
        self.id = id ?? UUID()
        self.message = message
        self.idNotificationType = idNotificationType
    }
}
