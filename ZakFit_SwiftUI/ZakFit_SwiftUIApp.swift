//
//  ZakFit_SwiftUIApp.swift
//  ZakFit_SwiftUI
//
//  Created by Apprenant 141 on 05/12/2024.
//

import SwiftUI

@main
struct ZakFit_SwiftUIApp: App {
    @StateObject var userViewModel = UserViewModel()
    @StateObject var userWeightViewModel = UserWeightViewModel()
    @StateObject var genderViewModel = GenderViewModel()
    @StateObject var foodPreferenceViewModel = FoodPreferenceViewModel()
    @StateObject var intensityViewModel = IntensityViewModel()
    @StateObject var physicalActivityViewModel = PhysicalActivityViewModel()
    @StateObject var activityTypeViewModel = ActivityTypeViewModel()
    @StateObject var mealTypeViewModel = MealTypeViewModel()
    @StateObject var alimentViewModel = AlimentViewModel()
    @StateObject var aqMealLinkViewModel = AQMealLinkViewModel()
    @StateObject var weightGoalViewModel = WeightGoalViewModel()
    @StateObject var physicalActivityGoalViewModel = PhysicalActivityGoalViewModel()
    @StateObject var caloriesGoalViewModel = CaloriesGoalViewModel()
    @StateObject var chosenPeriodViewModel = ChosenPeriodViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    userViewModel.verifyIfLoggedIn()
                    genderViewModel.fetch()
                    foodPreferenceViewModel.fetch()
                    intensityViewModel.fetch()
                    activityTypeViewModel.fetch()
                    mealTypeViewModel.fetch()
                    alimentViewModel.fetch()
                    chosenPeriodViewModel.fetch()
                })
        }
        .environmentObject(userViewModel)
        .environmentObject(userWeightViewModel)
        .environmentObject(genderViewModel)
        .environmentObject(foodPreferenceViewModel)
        .environmentObject(intensityViewModel)
        .environmentObject(physicalActivityViewModel)
        .environmentObject(activityTypeViewModel)
        .environmentObject(mealTypeViewModel)
        .environmentObject(alimentViewModel)
        .environmentObject(aqMealLinkViewModel)
        .environmentObject(weightGoalViewModel)
        .environmentObject(physicalActivityGoalViewModel)
        .environmentObject(caloriesGoalViewModel)
        .environmentObject(chosenPeriodViewModel)
    }
}
