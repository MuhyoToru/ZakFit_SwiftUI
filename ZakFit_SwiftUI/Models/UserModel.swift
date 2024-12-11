//
//  UserModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class User : Identifiable, Codable {
    var id : UUID?
    var name : String
    var firstname : String
    var email : String
    var size : Double
    var birthday : Date
    var notificationTime : String
    var idFoodPeference : UUID?
    var idGender : UUID?
    
    init(id: UUID? = nil, name: String, firstname: String, email: String, size: Double, birthday: Date, notificationTime: String) {
        self.id = id ?? UUID()
        self.name = name
        self.firstname = firstname
        self.email = email
        self.size = size
        self.birthday = birthday
        self.notificationTime = notificationTime
    }
    
    func verifyName() -> Bool {
        return self.name != ""
    }
    
    func verifyFirstname() -> Bool {
        return self.firstname != ""
    }
    
    func verifySize(size : String) -> Bool {
        if size == "" {
            return false
        }
        
        if Double(size) ?? 0 > 0 {
            self.size = Double(size) ?? 0
            return true
        }
        
        return false
    }
    
    func verifyEmail() -> Bool {
        return self.email.isValidEmail()
    }
    
    func verifyPassword(password : String) -> String {
        // Check Password Length
        if password.count < 8 {
            return "Mot de passe : Minimum 8 charactères"
        }
        
        // Check if password have Uppercased
        if password == password.lowercased() {
            return "Mot de passe : 1 majuscule minimum"
        }
        
        // Check if password have Lowercased
        if password == password.uppercased() {
            return "Mot de passe : 1 minuscule minimum"
        }
        
        // Check if password contains Number
        let numberArray : [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        var containsNumber : Bool = false
        
        for number in numberArray {
            if password.contains(number) {
                containsNumber = true
            }
        }
        
        if !containsNumber {
            return "Mot de passe : 1 chiffre minimum"
        }
        
        // Check if password contains Specific Charcater
        let specificCharacterArray : [String] = ["&", "é", "", "(", "§", "è", "!", "ç", "à", ")", "@", "#", "<", ">", ",", "?", ";", ".", ":", "/", "=", "+", "ù", "%", "£", "$", "€", "*"]
        var containsSpecificCharacter : Bool = false
        
        for specificCharacter in specificCharacterArray {
            if password.contains(specificCharacter) {
                containsSpecificCharacter = true
            }
        }
        
        if !containsSpecificCharacter {
            return "Mot de passe : 1 charactère spécial minimum"
        }
        
        return "ok"
    }
    
    func verifyPasswordConfirmation(password : String, confirmPassword : String) -> Bool {
        return password == confirmPassword
    }
    
    //    func verifyEmailInDatabase() {
    //
    //    }
}
