//
//  EditMealView.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 16/12/2024.
//

import SwiftUI

struct EditMealView: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var mealTypeViewModel : MealTypeViewModel
    @EnvironmentObject var alimentViewModel : AlimentViewModel
    @EnvironmentObject var aqMealLinkViewModel : AQMealLinkViewModel
    @StateObject var mealViewModel = MealViewModel()
    @StateObject var alimentQuantityViewModel = AlimentQuantityViewModel()
    @State var tempAlimentQuantitys : [AlimentQuantity] = []
    @State var meal : Meal?
    @State var name : String = ""
    @State var date : Date
    @State var totalCalories : String = ""
    @State var totalProteins : String = ""
    @State var totalCarbohydrates : String = ""
    @State var totalLipids : String = ""
    @State var errorMessage : String = ""
    let mealType : String
    
    let idMeal : UUID = UUID()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ErrorMessageExView(errorMessage: $errorMessage)
                    TitleExView(imageSystem: "rectangle.and.pencil.and.ellipsis", title: "Nom du repas")
                    TextFieldExView(textFieldTitle: "Nom du repas", textInTextField: $name)
                    TitleExView(imageSystem: "clock", title: "Période du repas")
                    MealTypePickerExView(pickerTitle: "")
                    TitleExView(imageSystem: "calendar", title: "Date du repas")
                    DatePickerExView(datePickerTitle: "", date: $date)
                    TitleExView(imageSystem: "flame.fill", title: "Total de calories")
                    NonObligatoryFieldExView()
                    NumberFieldExView(textFieldTitle: "Total de calories", textUnit: "cal", textInTextField: $totalCalories)
                    TitleExView(imageSystem: "flame.fill", title: "Total de protéines")
                    NonObligatoryFieldExView()
                    NumberFieldExView(textFieldTitle: "Total de protéines", textUnit: "g", textInTextField: $totalProteins)
                    TitleExView(imageSystem: "flame.fill", title: "Total de glucides")
                    NonObligatoryFieldExView()
                    NumberFieldExView(textFieldTitle: "Total de glucides", textUnit: "g", textInTextField: $totalCarbohydrates)
                    TitleExView(imageSystem: "flame.fill", title: "Total de lipides")
                    NonObligatoryFieldExView()
                    NumberFieldExView(textFieldTitle: "Total de lipides", textUnit: "g", textInTextField: $totalLipids)
                    HStack {
                        TitleExView(imageSystem: "carrot.fill", title: "Ingredients")
                        Spacer()
                        Button(action: {
                            alimentQuantityViewModel.tempAlimentQuantitys.append(AlimentQuantity(id: UUID(), quantity: 0, weightOrUnit: "weight", idAliment: alimentViewModel.aliments.first!.id!))
                        }, label: {
                            GeneralButtonDisplayExView(firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 44, imageSystem: "plus")
                        })
                    }
                    ForEach($alimentQuantityViewModel.tempAlimentQuantitys) { $alimentQuantity in
                        AlimentPickerExView(alimentQuantitys: $alimentQuantityViewModel.tempAlimentQuantitys, alimentQuantity : $alimentQuantity, pickerTitle: "")
                    }
                    ErrorMessageExView(errorMessage: $errorMessage)
                }
                .padding()
            }
            Button(action: {
                let tempMeal : Meal = Meal(id: idMeal, name: name, image: "", date: date, totalCalories: Double(totalCalories) ?? 0, totalProteins: Double(totalProteins) ?? 0, totalCarbohydrates: Double(totalCarbohydrates) ?? 0, totalLipids: Double(totalLipids) ?? 0, idMealType: mealTypeViewModel.selectedCategory.id!, idUser: userViewModel.user.id!)
                
                errorMessage = ""
                
                for alimentQuantity in tempAlimentQuantitys {
                    if !alimentQuantity.verifyQuantity() {
                        errorMessage = "Veuillez remplir les quantités d'aliment"
                    }
                    
                    if !alimentQuantity.verifyWeightOrUnit() {
                        errorMessage = "Veuillez choisir une unité valide"
                    }
                }
                
                if !tempMeal.verifyName() {
                    errorMessage = "Veuillez rentrer un nom pour votre repas"
                }
                
                if errorMessage == "" {
                    if tempMeal.totalCalories <= 0 {
                        tempMeal.calculateTotalCalories(alimentQuantitys: alimentQuantityViewModel.tempAlimentQuantitys, aliments: alimentViewModel.aliments)
                    }
                    
                    if tempMeal.totalProteins <= 0 {
                        tempMeal.calculateTotalProteins(alimentQuantitys: alimentQuantityViewModel.tempAlimentQuantitys, aliments: alimentViewModel.aliments)
                    }
                    
                    if tempMeal.totalCarbohydrates <= 0 {
                        tempMeal.calculateTotalCarbohydrates(alimentQuantitys: alimentQuantityViewModel.tempAlimentQuantitys, aliments: alimentViewModel.aliments)
                    }
                    
                    if tempMeal.totalLipids <= 0 {
                        tempMeal.calculateTotalLipids(alimentQuantitys: alimentQuantityViewModel.tempAlimentQuantitys, aliments: alimentViewModel.aliments)
                    }
                    
                    var tempCount = 0
                    
                    for tempAlimentQuantity in alimentQuantityViewModel.tempAlimentQuantitys {
                        if alimentQuantityViewModel.alimentQuantitys.contains(where: {
                            $0.id == tempAlimentQuantity.id
                        }) && meal != nil {
                            print("J'update 2 fois")
                            print(alimentQuantityViewModel.alimentQuantitys.first(where: {
                                $0.id == tempAlimentQuantity.id
                            })!.idAliment)
                            print(tempAlimentQuantity.idAliment)
                            aqMealLinkViewModel.updateAQUpdateMeal(oldAlimentQuantity: alimentQuantityViewModel.alimentQuantitys.first(where: {
                                $0.id == tempAlimentQuantity.id
                            })!, newAlimentQuantity: tempAlimentQuantity, oldMeal: meal!, newMeal: tempMeal)
                        } else if !alimentQuantityViewModel.alimentQuantitys.contains(where: {
                            $0.id == tempAlimentQuantity.id
                        }) && meal != nil {
                            print("J'update 1 fois et crée 1 fois")
                            aqMealLinkViewModel.createAQUpdateMeal(alimentQuantity: tempAlimentQuantity, oldMeal: meal!, newMeal: tempMeal)
                        } else if tempCount == 0 {
                            print("Je crée 2 fois")
                            aqMealLinkViewModel.createAQCreateMeal(alimentQuantity: tempAlimentQuantity, meal: tempMeal)
                        } else {
                            print("Je crée juste AQ")
                            aqMealLinkViewModel.onlyCreateAQ(alimentQuantity: tempAlimentQuantity, meal: tempMeal)
                        }
                        
                        tempCount += 1
                    }
                    dismiss()
                }
            }, label: {
                GeneralButtonDisplayExView(textToDisplay: "Valider", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160)
            })
            .padding()
        }
        .navigationTitle("Editer le repas")
        .navigationBarTitleDisplayMode(.large)
        .onAppear(perform: {
            if meal != nil {
                alimentQuantityViewModel.fetchByMealId(idMeal: meal!.id!)
                
                name = meal!.name
                date = meal!.date
                totalCalories = String(meal!.totalCalories)
                totalProteins = String(meal!.totalProteins)
                totalCarbohydrates = String(meal!.totalCarbohydrates)
                totalLipids = String(meal!.totalLipids)
                
                mealTypeViewModel.selectedCategory = mealTypeViewModel.mealTypes.first {
                    $0.id == meal!.idMealType
                } ?? MealType(name: "Pas de période")
            } else {
                mealTypeViewModel.selectedCategory = mealTypeViewModel.mealTypes.first(where: {
                    $0.name == mealType
                }) ?? mealTypeViewModel.mealTypes.first!
                
                if alimentQuantityViewModel.alimentQuantitys.isEmpty {
                    alimentQuantityViewModel.tempAlimentQuantitys.append(AlimentQuantity(quantity: 0, weightOrUnit: "weight", idAliment: alimentViewModel.aliments.first!.id!))
                }
            }
        })
    }
}

//#Preview {
//    EditMealView(date: Date.now)
//}
