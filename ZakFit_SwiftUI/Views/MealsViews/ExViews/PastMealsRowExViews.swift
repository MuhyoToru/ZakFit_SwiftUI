//
//  MealsRowExViews.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 16/12/2024.
//

import SwiftUI

struct PastMealsRowExViews: View {
    @EnvironmentObject var mealTypeViewModel : MealTypeViewModel
    @StateObject var mealViewModel : MealViewModel = MealViewModel()
    var dateToFetch : Date
    
    var body: some View {
        HStack {
            if mealViewModel.meals.isEmpty {
                Text("Pas de repas mangé ce jour")
            } else {
                let firstMeal = mealViewModel.meals.first(where: { $0.idMealType == mealTypeViewModel.mealTypes.first(where: { $0.name == "Petit déjeuner" })?.id })
                let secondMeal = mealViewModel.meals.first(where: { $0.idMealType == mealTypeViewModel.mealTypes.first(where: { $0.name == "Déjeuner" })?.id })
                let thirdMeal = mealViewModel.meals.first(where: { $0.idMealType == mealTypeViewModel.mealTypes.first(where: { $0.name == "Dîner" })?.id })
                let fourthMeal = mealViewModel.meals.first(where: { $0.idMealType == mealTypeViewModel.mealTypes.first(where: { $0.name == "Snack" })?.id })
                
                NavigationLink(destination: {
                    if firstMeal != nil {
                        MealDetailsView(meal: firstMeal!)
                    } else {
                        EditMealView(date: dateToFetch, mealType: "Petit déjeuner")
                    }
                }, label: {
                    MealExView(meal: firstMeal, mealType: "P'tit dej")
                })
                NavigationLink(destination: {
                    if secondMeal != nil {
                        MealDetailsView(meal: secondMeal!)
                    } else {
                        EditMealView(date: dateToFetch, mealType: "Déjeuner")
                    }
                }, label: {
                    MealExView(meal: secondMeal, mealType: "Déjeuner")
                })
                NavigationLink(destination: {
                    if thirdMeal != nil {
                        MealDetailsView(meal: thirdMeal!)
                    } else {
                        EditMealView(date: dateToFetch, mealType: "Dîner")
                    }
                }, label: {
                    MealExView(meal: thirdMeal, mealType: "Dîner")
                })
                NavigationLink(destination: {
                    if fourthMeal != nil {
                        MealDetailsView(meal: fourthMeal!)
                    } else {
                        EditMealView(date: dateToFetch, mealType: "Snack")
                    }
                }, label: {
                    MealExView(meal: fourthMeal, mealType: "Snack")
                })
            }
        }
        .onAppear(perform: {
            mealViewModel.fetch(filters: Filter(date: dateToFetch))
        })
    }
}

#Preview {
    MealsRowExViews(dateToFetch: Date.now)
}
