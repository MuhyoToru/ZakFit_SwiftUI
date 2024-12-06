//
//  UserModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class User : Identifiable {
    var id : UUID
    var name : String
    var firstname : String
    var email : String
    var size : Double
    var birthday : Date
    var notificationTime : String
    
    init(id: UUID, name: String, firstname: String, email: String, size: Double, birthday: Date, notificationTime: String) {
        self.id = id
        self.name = name
        self.firstname = firstname
        self.email = email
        self.size = size
        self.birthday = birthday
        self.notificationTime = notificationTime
    }
    
    func verifyEmail() {
        
    }
    
    func verifyPassword() {
        
    }
    
    func verifyPasswordConfirmation() {
        
    }
    
//    func verifyEmailInDatabase() {
//
//    }
}
