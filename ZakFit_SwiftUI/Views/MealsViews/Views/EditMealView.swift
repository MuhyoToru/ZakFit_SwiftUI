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
    @StateObject var mealViewModel = MealViewModel()
    @StateObject var alimentQuantityViewModel = AlimentQuantityViewModel()
    @State var meal : Meal?
    @State var name : String = ""
    @State var date : Date
    @State var totalCalories : String = ""
    @State var totalProteins : String = ""
    @State var totalCarbohydrates : String = ""
    @State var totalLipids : String = ""
    @State var errorMessage : String = ""
    @State var needToBeUpdateCreate : String = "false"
    
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
                            alimentQuantityViewModel.alimentQuantitys.append(AlimentQuantity(quantity: 0, weightOrUnit: "weight", idAliment: alimentViewModel.aliments.first!.id!))
                        }, label: {
                            GeneralButtonDisplayExView(textToDisplay: "Ajouter", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 140, imageSystem: "plus")
                        })
                    }
                    ForEach(alimentQuantityViewModel.alimentQuantitys) { alimentQuantity in
                        AlimentPickerExView(needToBeUpdateCreate : $needToBeUpdateCreate, alimentQuantity: alimentQuantity, pickerTitle: "", idMeal: meal == nil ? idMeal : meal!.id!)
                    }
                    ErrorMessageExView(errorMessage: $errorMessage)
                }
                .padding()
            }
            Button(action: {
                let tempMeal : Meal = Meal(id: idMeal, name: name, image: "", date: date, totalCalories: Double(totalCalories) ?? 0, totalProteins: Double(totalProteins) ?? 0, totalCarbohydrates: Double(totalCarbohydrates) ?? 0, totalLipids: Double(totalLipids) ?? 0, idMealType: mealTypeViewModel.selectedCategory.id!, idUser: userViewModel.user.id!)
                
                errorMessage = ""
                
                if !tempMeal.verifyName() {
                    errorMessage = "Veuillez rentrer un nom pour votre repas"
                }
                
                if errorMessage == "" {
                    needToBeUpdateCreate = "waitingAlimentQuantity"
                }
            }, label: {
                GeneralButtonDisplayExView(textToDisplay: "Valider", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160)
            })
            .padding()
        }
        .navigationTitle("Editer l'activité")
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
                mealTypeViewModel.selectedCategory = mealTypeViewModel.mealTypes.first!
                
                if alimentQuantityViewModel.alimentQuantitys.isEmpty {
                    alimentQuantityViewModel.alimentQuantitys.append(AlimentQuantity(quantity: 0, weightOrUnit: "weight", idAliment: alimentViewModel.aliments.first!.id!))
                }
            }
        })
        .onChange(of: needToBeUpdateCreate, {
            if needToBeUpdateCreate == "verifyAlimentQuantityDone" {
                let tempMeal : Meal = Meal(id: idMeal, name: name, image: "", date: date, totalCalories: Double(totalCalories) ?? 0, totalProteins: Double(totalProteins) ?? 0, totalCarbohydrates: Double(totalCarbohydrates) ?? 0, totalLipids: Double(totalLipids) ?? 0, idMealType: mealTypeViewModel.selectedCategory.id!, idUser: userViewModel.user.id!)
                
                if meal != nil {
//                    mealViewModel.update(oldMeal: meal!, newMeal: tempMeal)
                } else {
                    mealViewModel.create(meal: tempMeal)
                    needToBeUpdateCreate = "mealDone"
                }
                
//                dismiss()
            }
        })
    }
}

#Preview {
    EditMealView(date: Date.now)
}
