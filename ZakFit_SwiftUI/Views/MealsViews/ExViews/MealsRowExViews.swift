//
//  MealsRowExViews.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 16/12/2024.
//

import SwiftUI

struct MealsRowExViews: View {
    @EnvironmentObject var mealTypeViewModel : MealTypeViewModel
    @StateObject var mealViewModel : MealViewModel = MealViewModel()
    var dateToFetch : Date
    
    var body: some View {
        HStack {
            if mealViewModel.meals.isEmpty {
                HStack {
                    Spacer()
                    NavigationLink(destination: {
                        EditMealView(date: dateToFetch)
                    }, label: {
                        GeneralButtonDisplayExView(textToDisplay: "Ajouter un repas pour ce jour", firstColor: .zfOrange, secondColor: .zfMediumGray, textColor: .white, width: 360, imageSystem: "plus")
                    })
                    Spacer()
                }
            } else {
                let firstMeal = mealViewModel.meals.first(where: { $0.idMealType == mealTypeViewModel.mealTypes.first(where: { $0.name == "Petit déjeuner" })?.id })
                let secondMeal = mealViewModel.meals.first(where: { $0.idMealType == mealTypeViewModel.mealTypes.first(where: { $0.name == "Déjeuner" })?.id })
                let thirdMeal = mealViewModel.meals.first(where: { $0.idMealType == mealTypeViewModel.mealTypes.first(where: { $0.name == "Dîner" })?.id })
                let fourthMeal = mealViewModel.meals.first(where: { $0.idMealType == mealTypeViewModel.mealTypes.first(where: { $0.name == "Snack" })?.id })
                
                NavigationLink(destination: {
                    if firstMeal != nil {
                        MealDetailsView(meal: firstMeal!)
                    } else {
                        EditMealView(date: dateToFetch)
                    }
                }, label: {
                    MealExView(meal: firstMeal, mealType: "P'tit dej")
                })
                NavigationLink(destination: {
                    if secondMeal != nil {
                        MealDetailsView(meal: secondMeal!)
                    } else {
                        EditMealView(date: dateToFetch)
                    }
                }, label: {
                    MealExView(meal: secondMeal, mealType: "Déjeuner")
                })
                NavigationLink(destination: {
                    if thirdMeal != nil {
                        MealDetailsView(meal: thirdMeal!)
                    } else {
                        EditMealView(date: dateToFetch)
                    }
                }, label: {
                    MealExView(meal: thirdMeal, mealType: "Dîner")
                })
                NavigationLink(destination: {
                    if fourthMeal != nil {
                        MealDetailsView(meal: fourthMeal!)
                    } else {
                        EditMealView(date: dateToFetch)
                    }
                }, label: {
                    MealExView(meal: fourthMeal, mealType: "Snack")
                })
            }
        }
        .task {
            mealViewModel.fetch(filters: Filter(date: dateToFetch))
        }
    }
}

#Preview {
    MealsRowExViews(dateToFetch: Date.now)
}
