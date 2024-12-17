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
    @StateObject var mealViewModel = MealViewModel()
    @State var meal : Meal // Faire que Meal soit optionelle
    @State var name : String = ""
    @State var date : Date = Date.now
    @State var totalCalories : String = ""
    @State var totalProteins : String = ""
    @State var totalCarbohydrates : String = ""
    @State var totalLipids : String = ""
    @State var errorMessage : String = ""
    
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
                    Text("Champ non obligatoire")
                        .foregroundStyle(.gray)
                        .font(.system(size: 12))
                    NumberFieldExView(textFieldTitle: "Total de calories", textUnit: "cal", textInTextField: $totalCalories)
                    TitleExView(imageSystem: "flame.fill", title: "Total de protéines")
                    Text("Champ non obligatoire")
                        .foregroundStyle(.gray)
                        .font(.system(size: 12))
                    NumberFieldExView(textFieldTitle: "Total de protéines", textUnit: "g", textInTextField: $totalProteins)
                    TitleExView(imageSystem: "flame.fill", title: "Total de glucides")
                    Text("Champ non obligatoire")
                        .foregroundStyle(.gray)
                        .font(.system(size: 12))
                    NumberFieldExView(textFieldTitle: "Total de glucides", textUnit: "g", textInTextField: $totalCarbohydrates)
                    TitleExView(imageSystem: "flame.fill", title: "Total de lipides")
                    Text("Champ non obligatoire")
                        .foregroundStyle(.gray)
                        .font(.system(size: 12))
                    NumberFieldExView(textFieldTitle: "Total de lipides", textUnit: "g", textInTextField: $totalLipids)
                    ErrorMessageExView(errorMessage: $errorMessage)
                }
                .padding()
            }
            Button(action: {
                let tempMeal : Meal = Meal(name: name, image: "", date: date, totalCalories: Double(totalCalories)!, totalProteins: Double(totalProteins)!, totalCarbohydrates: Double(totalCarbohydrates)!, totalLipids: Double(totalLipids)!, idMealType: mealTypeViewModel.selectedCategory.id!, idUser: userViewModel.user.id!)
                
                errorMessage = ""
                
                if !tempMeal.verifyName() {
                    errorMessage = "Veuillez rentrer un nom pour votre repas"
                }
                //
                //                if !tempMeal.verifyDuration() {
                //                    errorMessage = "Mauvaise Durée, veuillez rentrer une durée supérieur à 0"
                //                }
                //
                //                if errorMessage == "" && Double(caloriesBurned) ?? 0 <= 0{
                //                    tempsPhysicalActivity.calculateCaloriesBurned(caloriesBurnedPerHour: activityTypeViewModel.activityTypes.first(where: {
                //                        $0.id == tempsPhysicalActivity.idActivityType
                //                    })?.caloriesBurnedPerHour ?? 0, intensity : intensityViewModel.intensitys.first(where: {
                //                        $0.id == tempsPhysicalActivity.idIntensity
                //                    })?.name ?? "Pas d'intensité")
                //                }
                
                if errorMessage == "" {
                    mealViewModel.update(oldMeal: meal, newMeal: tempMeal)
                    dismiss()
                }
            }, label: {
                GeneralButtonDisplayExView(textToDisplay: "Valider", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 160)
            })
            .padding()
        }
        .navigationTitle("Editer l'activité")
        .navigationBarTitleDisplayMode(.large)
        .onAppear(perform: {
            name = meal.name
            date = meal.date
            totalCalories = String(meal.totalCalories)
            totalProteins = String(meal.totalProteins)
            totalCarbohydrates = String(meal.totalCarbohydrates)
            totalLipids = String(meal.totalLipids)
            
            mealTypeViewModel.selectedCategory = mealTypeViewModel.mealTypes.first {
                $0.id == meal.idMealType
            } ?? MealType(name: "Pas de période")
        })
    }
}

#Preview {
    EditMealView(meal: Meal(name: "", image: "", date: Date.now, totalCalories: 0, totalProteins: 0, totalCarbohydrates: 0, totalLipids: 0, idMealType: UUID(), idUser: UUID()))
}
