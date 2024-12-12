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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    userViewModel.verifyIfLoggedIn()
                    genderViewModel.fetch()
                    foodPreferenceViewModel.fetch()
                    intensityViewModel.fetch()
                })
        }
        .environmentObject(userViewModel)
        .environmentObject(userWeightViewModel)
        .environmentObject(genderViewModel)
        .environmentObject(foodPreferenceViewModel)
        .environmentObject(intensityViewModel)
        .environmentObject(physicalActivityViewModel)
    }
}
