//
//  MealModel.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import Foundation

class Meal: Identifiable, Codable {
    var id: UUID?
    var name: String
    var image: String?
    var date: Date
    var totalCalories: Double
    var totalProteins: Double
    var totalCarbohydrates: Double
    var totalLipids: Double
    var idMealType: UUID
    var idUser: UUID
    
    init(id: UUID? = nil, name: String, image: String? = nil, date: Date, totalCalories: Double, totalProteins: Double, totalCarbohydrates: Double, totalLipids: Double, idMealType: UUID, idUser: UUID) {
        self.id = id ?? UUID()
        self.name = name
        self.image = image ?? ""
        self.date = date
        self.totalCalories = totalCalories
        self.totalProteins = totalProteins
        self.totalCarbohydrates = totalCarbohydrates
        self.totalLipids = totalLipids
        self.idMealType = idMealType
        self.idUser = idUser
    }
    
    func verifyName() -> Bool {
        if self.name == "" {
            return false
        }
        
        return true
    }
    
    func calculateTotalCalories(alimentQuantitys : [AlimentQuantity], aliments: [Aliment]) {
        for alimentQuantity in alimentQuantitys {
            if alimentQuantity.weightOrUnit == "weight" {
                self.totalCalories += alimentQuantity.quantity * (aliments.first(where: {
                    $0.id == alimentQuantity.idAliment
                })?.caloriesKg)!
            } else {
                self.totalCalories += alimentQuantity.quantity * (aliments.first(where: {
                    $0.id == alimentQuantity.idAliment
                })?.caloriesUnit)!
            }
        }
    }
    
    func calculateTotalProteins(alimentQuantitys : [AlimentQuantity], aliments: [Aliment]) {
        for alimentQuantity in alimentQuantitys {
            self.totalProteins += alimentQuantity.quantity * (aliments.first(where: {
                $0.id == alimentQuantity.idAliment
            })?.proteins)!
        }
    }
    
    func calculateTotalCarbohydrates(alimentQuantitys : [AlimentQuantity], aliments: [Aliment]) {
        for alimentQuantity in alimentQuantitys {
            self.totalCarbohydrates += alimentQuantity.quantity * (aliments.first(where: {
                $0.id == alimentQuantity.idAliment
            })?.carbohydrates)!
        }
    }
    
    func calculateTotalLipids(alimentQuantitys : [AlimentQuantity], aliments: [Aliment]) {
        for alimentQuantity in alimentQuantitys {
            self.totalLipids += alimentQuantity.quantity * (aliments.first(where: {
                $0.id == alimentQuantity.idAliment
            })?.lipids)!
        }
    }
}
